module pc (
	input Reset, clk,
	output reg [9:0] Address
);
	
	always @(posedge clk or posedge Reset)begin 
		if(Reset)begin
			Address <= 10'd0;//Reseta para o endereço 0x0000
		end
		else begin
			Address <= Address + 1'b1;//Contagem Incremental
		end
	end
	
endmodule
