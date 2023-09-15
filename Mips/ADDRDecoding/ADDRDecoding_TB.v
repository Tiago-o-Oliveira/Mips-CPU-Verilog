`timescale 1ns/100ps

module ADDRDecoding_TB();

	wire CS;
	reg [31:0] ADDR;
	
	integer i;
	
	ADDRDecoding DUT(
		.Cs(CS),
		.Address(ADDR)
	);
	
	initial begin
		for(i = 0; i <= 16'hFFFF; i = i + 1)
		#20 ADDR = i;				
	end
	initial begin
		#50000 $stop;
	end
	
endmodule 