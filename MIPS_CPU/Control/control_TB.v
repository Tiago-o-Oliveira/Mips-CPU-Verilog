`timescale 1ns/10ps

module control_TB();

	reg  [31:0] Instruction;
	wire [23:0] Ctrl;
	
	control DUT (
	.Instruction(Instruction),
	.Ctrl(Ctrl)
	);
	
	initial
	begin
		//formato i       opcode   rs   rt          offset
		Instruction = 32'b000100_00000_00001_0000_1111_0000_0000; //LW
		#10 
		Instruction = 32'b000101_00000_00001_0000_0000_0000_0000; //SW
		#10
		//formato R			opcode   rs    rt    rd       op
		Instruction = 32'b000011_00001_00010_00101_01010_110010; //MUL
		#10
		Instruction = 32'b000011_00011_00100_00110_01010_100000; //ADD
		#10
		Instruction = 32'b000011_00101_00110_00111_01010_100010; //SUB
		#10 $shop;
	end
	
endmodule
