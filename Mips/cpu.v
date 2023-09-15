module cpu (
	input  CLK, RST, 
	input  [31:0] Data_BUS_READ,
	output [31:0] ADDR, Data_BUS_WRITE,
	output CS, WR_RD
);
	/*Perguntas e Respostas
		a) Qual a latência do sistema?
		
			R: O sistema tem latencia de 5 pulso de Clock.
			
		b) Qual o throughput do sistema?
		
			R: Apos a pipeline estar cheia, o sistema tem throughput de 1 instrucao por ciclo de Clock, apesar de cada 
		instrucao levar 5 ciclos para ser completamente processada.
			Resposta rapida: 1 instrucao por ciclo de Clock
			
		c) Qual a máxima frequência operacional entregue pelo Time Quest Timing Analizer para o multiplicador e para
		o sistema? (Indique aFPGA utilizada)
		
			R: FPGA Cyclone IV GX EP4CGX22CF19C6
			fmaxmul = 240,91 MHz
			fmaxsys = 56,69MHz
			
		d) Qual a máxima frequência de operação do sistema? (Indique a FPGA utilizada)
		
			R: FPGA Cyclone IV GX EP4CGX22CF19C6
			Como fmaxmul = 240,91 MHz e sabemos que a cada ciclo do clock do sistema, passam 34 ciclos do clock do multiplicador,
		podemos obter a frequencia de: 240,91MHz/34 = 7,085MHz que esta de acordo com ambas as frquencias maximas 
		encontradas no Time Quest.
		
		e) Com a arquitetura implementada, a expressão (A*B) – (C+D) é executada corretamente (se executada em sequência
		ininterrupta)?Por quê? O que pode ser feito para que a expressão seja calculada corretamente?
		
			R: De forma ininterrupta a operacao nao e executada corretamente, devido ao pipeline hazard, no caso, as operacoes
		dependem de informacoes que ainda nao estao disponiveis no registro.
			Para a execucao de forma correta, podem ser inseridas instrucoes entre as operacoes (bubbles) para dar ao sistema
		o tempo que ele necessita para que as informacoes estejam prontas.
		
		f) Analisando a sua implementação de dois domínios de clock diferentes, haverá problemas com metaestabilidade? Por que?
			
			R: Nao, pois os clocks, apesar de diferentes, sao multiplos um do outro, alem de estarem em fase entre si.
		
		g) A aplicação de um multiplicador do tipo utilizado, no sistema MIPS sugerido, é eficiente em termos de velocidade? Por que?
		
			R: Nao, o multiplicador utilizado, apesar de ser implementado de forma eficiente por si so, nao se encaixa bem
		na arquitetura proposta, pois demanda muitos pulsos de clocks comparado ao sistema em si, diminuindo a velocidade
		geral do sistema. 
		
		h) Cite modificações cabíveis na arquitetura do sistema que tornaria o sistema mais rápido (frequência de operação maior). Para
		cada modificação sugerida, qual a nova latência e throughput do sistema?
			
			R: 1) Utilizacao de Outra implementacao de multiplicador, talvez alguma que ja venha implementada na FPGA,
		nesse caso, a latencia e throughput do sistema se manteriam os mesmos, a frequencia de operacao eh que seria 
		aumentada
				2) Utilizando o Mesmo multiplicador, pode-se segmentar o estagio de execucao em 34 estagios, aumentando
		assim a frequencia de operacao, nesse caso o throughput seria de 1 instrucao por ciclo, e a latencia de 38 ciclos.
	*/
	(*keep=1*) wire CLK_SYS, CLK_MUL, ChipS;
	
	(*keep=1*) wire[9:0] ProgAddr;
	(*keep=1*) wire[31:0] Instruction,Controle,Ext_Out,RegA_Out,RegB1_Out,IMM_Out,Ctrl1_Out,Alumu_Out,Alu_Out,Mult_Out;
	(*keep=1*) wire[31:0] MultMu_Out,RegD_Out,RegB2_Out,Ctrl2_Out,MemD_Out,Memmu_Out,Ctrl3_Out,WriteBack,RegD2_Out,RegCs_Out;
	
	assign CS = RegCs_Out;
	assign WR_RD = Ctrl3_Out[0];
	assign ADDR = RegD_Out;
	assign Data_BUS_WRITE = RegB2_Out;
	
//Memoria de Programa
	instructionmemory ProgMem(
	.address(ProgAddr),
	.clk(CLK_SYS),
	.dataOut(Instruction) 
	);
//
//Contador de Programa
	pc ProCont(
	.Reset(RST),
	.clk(CLK_SYS),
	.Address(ProgAddr)
	);
//
//Controle
	control Cntr(
	.Instruction(Instruction),
	.Ctrl(Controle)
	);
//
//Extend
	extend EXTE(
	.Entrada(Instruction[15:0]),
	.Saida(Ext_Out),
	.Enable(Controle[7])
	);
//
//Register File
	registerfile Rfile(
	.dataIn(WriteBack),
	.we(Ctrl3_Out[6]),
	.clk(CLK_SYS),
	.rst(RST),
	.rs(Controle[23:19]),
	.rt(Controle[18:14]),
	.rd(Ctrl3_Out[13:9]),
	.regA(RegA_Out),
	.regB(RegB1_Out)
	);
//
//Registro IMM
	Register IMM(
	.rst(RST),
	.clk(CLK_SYS),
	.Entrada(Ext_Out),
	.Saida(IMM_Out)
	);
//
//Registro CTRL1
	Register CTRL1(
	.rst(RST),
	.clk(CLK_SYS),
	.Entrada(Controle),
	.Saida(Ctrl1_Out)
	);
//
//Mux ->Alu
	mux Mux_Alu(
	.EntradaA(RegB1_Out),
	.EntradaB(IMM_Out),
	.SEL(Ctrl1_Out[5]),
	.Saida(Alumu_Out)
	);
//
//ALU
	alu Alua(
	.EntradaA(RegA_Out),
	.EntradaB(Alumu_Out),
	.OP(Ctrl1_Out[2:1]),
	.Saida(Alu_Out)
	);
//
//Multiplicador
	multiplicador MUL(
	.St(Ctrl1_Out[8]),
	.Clk(CLK_MUL),
	.Produto(Mult_Out),
	.Multiplicador(RegA_Out),
	.Multiplicando(RegB1_Out)
	);
//
//Mux ->MUL
	mux Mux_Mul(
	.EntradaA(Mult_Out),
	.EntradaB(Alu_Out),
	.SEL(Ctrl1_Out[4]),
	.Saida(MultMu_Out)
	);
//
//Registro D
	Register D(
	.rst(RST),
	.clk(CLK_SYS),
	.Entrada(MultMu_Out),
	.Saida(RegD_Out)
	);
//
//Registro B2
	Register B2(
	.rst(RST),
	.clk(CLK_SYS),
	.Entrada(RegB1_Out),
	.Saida(RegB2_Out)
	);
//
//Registro CTRL2
	Register CTRL2(
	.rst(RST),
	.clk(CLK_SYS),
	.Entrada(Ctrl1_Out),
	.Saida(Ctrl2_Out)
	);
//
//Memoria de Dados
	datamemory MemData(
	.ADDR(RegD_Out[9:0]),
	.din(RegB2_Out),
	.WR_RD(Ctrl2_Out[0]),
	.clk(CLK_SYS),
	.dout(MemD_Out)
	);
//
//Decodificador de Enderecos
	ADDRDecoding Addecod(
	.Address(RegD_Out),
	.Cs(ChipS)
	);
//
//Mux Mem
	mux MuxMem(
	.EntradaA(Data_BUS_READ),
	.EntradaB(MemD_Out),
	.SEL(RegCs_Out),
	.Saida(Memmu_Out)
	);
//
//Registro D2
	Register D2(
	.rst(RST),
	.clk(CLK_SYS),
	.Entrada(RegD_Out),
	.Saida(RegD2_Out)
	);
//
//Registro CTRL3
	Register CTRL3(
	.rst(RST),
	.clk(CLK_SYS),
	.Entrada(Ctrl2_Out),
	.Saida(Ctrl3_Out)
	);
//
//Registro CS //Esse registro foi necessario para sincronizar o cs com a informacao da memoria
	Register RegCs(
	.rst(RST),
	.clk(CLK_SYS),
	.Entrada(ChipS),
	.Saida(RegCs_Out)
	);
///

//Mux WB
	mux WB(
	.EntradaA(Memmu_Out),
	.EntradaB(RegD2_Out),
	.SEL(Ctrl3_Out[3]),
	.Saida(WriteBack)
	);
//
//PLL
	PLL PLL(
		.areset(RST),
		.inclk0(CLK),
		.c0(CLK_MUL),
		.c1(CLK_SYS)
	);
//
//C'est fini
endmodule	