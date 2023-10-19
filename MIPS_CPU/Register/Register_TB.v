`timescale 1ns/10ps

module Register_TB();

reg rst, clk;
reg [31:0] D;
wire [31:0] Q;
	
integer i;
	
Register DUT(
	.rst(rst),
	.clk(clk),
	.D(D),
	.Q(Q)
);
	
	
initial 
begin
	clk = 0;
	rst = 1;	
	#10 rst = 0;
		
	for(i = 0; i < 15; i = i + 1) 
	begin	
		#10 D = i;
	end

	#100 $stop;
end
	
always #5 clk = ~clk;
	
endmodule