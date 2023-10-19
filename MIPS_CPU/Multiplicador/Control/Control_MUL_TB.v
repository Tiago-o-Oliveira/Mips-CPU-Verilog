`timescale 1ns/10ps
module Control_MUL_TB;

	reg St, Clk, k,  M;
	wire Idle, Done, Load, Sh, Ad;
	reg  [1:0] state;
	reg  [3:0] count;	
		
	Control_MUL DUT(
	.St(St), 
	.Clk(Clk),
	.k(k), 
	.M(M),
	.Idle(Idle), 
	.Done(Done), 
	.Load(Load),
	.Sh(Sh),
	.Ad(Ad)
	);
	
	initial 
	begin
		Clk   = 0;
		St    = 0;
		k     = 0;
		M     = 0;
		count = 0;
	end
	
	always @ (negedge Clk)
	begin
			count = count + 1;
			
			if(count == 2) begin St = 1; k = 0; end
			else St = 0;
			if(count == 4) M  = 1;
			else M = 0;
			if(count == 7) begin k  = 1; count = 0; end			
	end
	
	initial #800 $shop;
	
	always #10 Clk = ~Clk;
	
	initial 
		$init_signal_spy("/Control_TB/DUT/state","state",1);
		
endmodule 