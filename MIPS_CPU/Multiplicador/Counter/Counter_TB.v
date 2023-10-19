`timescale 1ns/10ps

module Counter_TB();

	reg Load, Clk;
	wire K;

	
	Counter DUT(
		
		.Load(Load),
		.Clk(Clk),
		.K(K)
	
	);

	initial begin
		
		Clk = 0;
		Load = 0;
		#1 Clk = 1;
		#1 Clk = 0;
		Load = 1;
		#1 Clk = 1;
		#1 Clk = 0;
		Load = 0;	
		#1 Clk = 1;
		#1 Clk = 0;	
		#1 Clk = 1;
		#1 Clk = 0;
		#1 Clk = 1;
		#1 Clk = 0;	
		#1 Clk = 1;
		#1 Clk = 0;	
		#1 Clk = 1;
		#1 Clk = 0;
		#1 Clk = 1;
		#1 Clk = 0;	
		#1 Clk = 1;
		#1 Clk = 0;
		#1 Clk = 1;
		#1 Clk = 0;		
		Load = 1;
		#1 Clk = 1;
		#1 Clk = 0;
		Load = 0;
		#1 Clk = 1;
		#1 Clk = 0;
		#1 Clk = 1;
		#1 Clk = 0;	
		#1 Clk = 1;
		#1 Clk = 0;	

	end
endmodule 	