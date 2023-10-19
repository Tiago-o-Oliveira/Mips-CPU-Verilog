`timescale 1ns/100ps

module Adder_TB();
	
	reg [3:0] OperandoA, OperandoB;
	wire [4:0] Soma;
	
	Adder DUT (
	
		.OperandoA(OperandoA),
		.OperandoB(OperandoB),
		.Soma(Soma)	
		
	);
	
	initial begin

		OperandoA = 4'b1010;
		OperandoB = 4'b1011;
		#5;

	end 
endmodule 