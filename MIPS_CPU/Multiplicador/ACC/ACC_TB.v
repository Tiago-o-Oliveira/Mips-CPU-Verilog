`timescale 1ns/10ps

module ACC_TB();
	
	reg [8:0] Entradas;
	reg Load, Sh, Ad, Clk;
	wire [8:0] Saidas;

	ACC DUT (	
		.Entradas(Entradas),
		.Load(Load),
		.Sh(Sh),
		.Ad(Ad),
		.Clk(Clk),
		.Saidas(Saidas)
	);
	
	initial begin
		
		Clk = 0;
		Entradas = 8'b01100110;
		Load = 0;
		Ad = 0;
		Sh = 0;

		#1 Clk = 1;
		#1 Clk = 0;
		Entradas = 8'b01100110;
		Load = 1;
		Ad = 0;
		Sh = 0;
	
		#1 Clk = 1;
		#1 Clk = 0;
		Entradas = 8'b01100110;
		Load = 0;
		Ad = 1;
		Sh = 0;
	
		#1 Clk = 1;
		#1 Clk = 0;
		Entradas = 8'b01100110;
		Load = 0;
		Ad = 0;
		Sh = 1;
		#1 Clk = 1;
		#1 Clk = 0;

			
	end
endmodule 