module multiplicador (
	input St, Clk, 
	output Idle, Done,
	output [31:0] Produto,
	input [15:0] Multiplicador, Multiplicando
	
);

	wire Wire_k, Wire_Load, Wire_Sh, Wire_Ad, St_out;
	wire [16:0] Wire_Soma; 
	wire [15:0] Wire_OperandoB;
	
	Control_MUL U1(
	.St(St),
	.Clk(Clk),
	.k(Wire_k),
	.M(Produto[0]),
	.Idle(Idle),
	.Done(Done),
	.Load(Wire_Load),
	.Sh(Wire_Sh),
	.Ad(Wire_Ad)
	);
	
	ACC U2(
	.Entradas({Wire_Soma,Multiplicador}),
	.Saidas(Produto),
	.Load(Wire_Load),
	.Sh(Wire_Sh),
	.Ad(Wire_Ad),
	.Clk(Clk)
	);
	
	Adder U3(
	.OperandoA(Multiplicando),
	.OperandoB(Produto[31:16]),
	.Soma(Wire_Soma)
	);
	
	Counter U4(
	.Load(Wire_Load),
	.Clk(Clk),
	.K(Wire_k)
	);

endmodule

