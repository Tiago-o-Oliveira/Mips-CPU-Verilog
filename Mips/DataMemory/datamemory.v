module datamemory #(
//Sizes//
	parameter data_WIDTH = 32,//32 bits por word
	parameter ADDR_WIDTH = 10//2^10 = 1024 endereços
)

(
//Inputs//
	input [ADDR_WIDTH-1:0] ADDR,
	input [data_WIDTH-1:0] din,
	input WR_RD,
	input clk,
//
//Outputs
	output reg [data_WIDTH-1:0] dout
);

//Internal//
reg [data_WIDTH-1:0] mem [0:(1<<ADDR_WIDTH)-1];

initial begin//Valores Iniciais da memoria
	$readmemb("datamemory.txt", mem);
end

//Code//
	always @(posedge clk)begin
		if(WR_RD)begin//Escrita
			mem[ADDR] <= din;
			end
		else begin//Leitura
			dout <= mem[ADDR];
		end
	end
//

endmodule	