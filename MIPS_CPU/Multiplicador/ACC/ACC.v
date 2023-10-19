module ACC (
	input [32:0] Entradas,
	output reg [32:0] Saidas,
	input Load, Sh, Ad, Clk
); 
	
	always @(posedge Clk)
		begin		
			if (Ad) Saidas = {Entradas[32:16], Saidas[15:0]};
			
			if (Sh) Saidas = {1'b0, Saidas[32:1]};
			
			if (Load) Saidas = {17'b0, Entradas[15:0]};  			
		end
		   
endmodule 

	
