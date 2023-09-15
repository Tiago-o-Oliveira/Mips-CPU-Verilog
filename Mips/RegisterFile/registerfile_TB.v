`timescale 1ns/10ps

module registerfile_TB();
	
reg [31:0] dataIn;
reg we;
reg clk, rst;
reg [4:0] rs,rt,rd;
wire [31:0] A,B;


RegisterFile DUT(
	.dataIn(dataIn),  
	.we(we), 
	.clk(clk),
	.rst(rst),
	.rs(rs),
	.rt(rt),
	.rd(rd),
	.A(A),
	.B(B)
);

	initial  
	begin
		clk = 0;
		rst = 0;
		#10 we = 1;
		dataIn = 2001;
		rd = 1;
		
		#10 dataIn = 4001;
		rd = 2;
		
		#10 dataIn = 8002;
		rd = 6;
		
		#10 dataIn = 3002;
		rd = 8;
		
		#5 we = 0;
		rs = 1;
		rt = 2;
		
		#5 
		rs = 6;
		rt = 8;
		
		#10 rst = 1;
		
		#30 $stop; 
	end
		
	always #5 clk = ~clk;

endmodule 