module control (
	input  [31:0] Instruction, 
	output [31:0] Ctrl
);
//Internal
	reg[4:0] rs,rt,rd;//Registros Fonte e Destino
	reg Mult;// 1: Habilita Multiplicador; 0: Desabilita
	reg Extend;// 1: Extende O: Nao extende
	reg RegFile_We;// 1: Habilita Escrita No RegisterFile; 0: Desabilita
	reg Mux_Alu;// 1: Seleciona RegistroB; 0: Seleciona Registro IMM
	reg Mux_Mul;// 1: Seleciona Saida do Multiplicador; 0: Seleciona Saida da Alu
	reg Mux_Wb;// 1: Seleciona Registro M; 0: Seleciona Registro D
	reg[1:0] Operation;// 0: Soma; 1:Subtracao; 2:And; 3:Or
	reg Wr_Rd;// 1: Leitura; 0: Escrita
//
	
	assign Ctrl = {8'd0,rs[4:0],rt[4:0],rd[4:0],Mult,Extend,RegFile_We,Mux_Alu,Mux_Mul,Mux_Wb,Operation[1:0],~Wr_Rd};
	
	always @(Instruction)begin
		rs = Instruction[25:21];
		rt = Instruction[20:16];
		Extend <= 0;
		Mult <= 0;
		Wr_Rd <= 1;
		RegFile_We <= 0;
		Mux_Alu <= 0;
		Mux_Mul <= 0;
		Mux_Wb <= 0;
		Operation <= 0;
		rd<= 0;
		if(Instruction[31:26] == 5)begin//LW
			Mult <= 0;
			Extend <= 1;
			RegFile_We <= 1;
			Mux_Alu <= 0;
			Mux_Mul <= 0;
			Mux_Wb <= 1;
			Operation <= 2'b00;
			Wr_Rd <= 1;
			rd <= rt;
		end
		if(Instruction[31:26] == 6)begin//SW
			Mult <= 0;
			Extend <= 1;
			RegFile_We <= 0;
			Mux_Alu <= 0;
			Mux_Mul <= 0;
			Mux_Wb <= 1;
			Operation <= 2'b00;
			Wr_Rd <= 0;
			rd <= 0;
		end
		if(Instruction[31:26] == 4)begin//Tipo R
			rd <= Instruction[15:11];
			Extend <= 0;
			Wr_Rd <= 1;
			RegFile_We <= 1;
			Mux_Alu <= 1;
			Mux_Wb <= 0;
			if(Instruction[10:6] == 10 && Instruction[5:0] == 32)begin//Soma
				Operation <= 2'b00;
				Mult <= 0;
				Mux_Mul <= 0;
			end
			if(Instruction[10:6] == 10 && Instruction[5:0] == 34)begin//Subtracao
				Operation <=2'b01;
				Mult <= 0;
				Mux_Mul <= 0;
			end
			if(Instruction[10:6] == 10 && Instruction[5:0] == 36)begin//And
				Operation <= 2'b10;
				Mult <= 0;
				Mux_Mul <= 0;
			end
			if(Instruction[10:6] == 10 && Instruction[5:0] == 37)begin//Or
				Operation <= 2'b11;
				Mult <= 0;
				Mux_Mul <= 0;
			end
			if(Instruction[10:6] == 10 && Instruction[5:0] == 50)begin//Or
				Operation <= 2'b11;
				Mult <= 1;
				Mux_Mul <= 1;
			end
		end
	end
endmodule 