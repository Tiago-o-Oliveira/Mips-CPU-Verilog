`timescale 1ns/10ps

module mux_TB();

	reg [31:0] EntradaA,EntradaB;
	reg SEL;
	wire [31:0] Saida;
	
	mux DUT (
	.EntradaA(EntradaA),
	.EntradaB(EntradaB),
	.SEL(SEL),
	.Saida(Saida)
	);
	
	initial 
	begin
		EntradaA = 1;
		EntradaB = 2;
		
		#10 SEL = 1;
		
		#10 SEL = 0;
		
		#10 $stop;
	end

endmodule 
