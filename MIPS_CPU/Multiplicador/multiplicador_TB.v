`timescale 1ns/100ps

module multiplicador_TB();
	
	reg St, Clk;
	wire Idle, Done;
	wire [31:0] Produto;
	reg [15:0] Multiplicador, Multiplicando;
	
	reg [7:0] count;
	
	multiplicador DUT(
		.St(St),
		.Clk(Clk),
		.Idle(Idle),
		.Done(Done),
		.Produto(Produto),
		.Multiplicador(Multiplicador),
		.Multiplicando(Multiplicando)	
	);
	
	
	initial begin
	
		Clk = 0;
		St = 0;
		count = 0;
		//Multiplicador = $random;
		//Multiplicando = $random;
		Multiplicador = 2001;
		Multiplicando = 4001;
		
	
	end
		
	always @ (posedge Clk)
	begin
		count = count + 1;
		
		if(count == 2) St = 1;
		
		if(count == 4) St = 0;
		
		if(count == 36) 
		begin
				Multiplicador = $random;
				Multiplicando = $random;
				count = 0;
		end
	end 
		
	initial #800 $shop;
	
	always #20 Clk = ~Clk;
		
endmodule 	
	