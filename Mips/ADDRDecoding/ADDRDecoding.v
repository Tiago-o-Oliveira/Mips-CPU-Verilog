module ADDRDecoding(
	input [31:0] Address,
	output reg Cs //Cs = 1 memoria interna; = 0 memoria externa 
);
	reg [31:0] Lower, Upper;
	
	//Memoria interna 0800h a 0BFFh
	
	always @(*)begin
		Lower <= 32'h800; //Lower Limit 0x800 = 0x200* grupo
		Upper <= 32'hBFF; //Upper Limit 0xBFF = 0x800 + 0x400(1024 posiçoes) - 1(desconta posicao '0')
		if(Address >= Lower)begin
			if(Address <= Upper)begin
				Cs = 1'b0;
			end
			else begin
				Cs = 1'b1;
			end
		end
		else begin
			Cs = 1'b1;
		end
	end
endmodule	