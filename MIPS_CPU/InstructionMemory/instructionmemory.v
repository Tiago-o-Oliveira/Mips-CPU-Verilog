module instructionmemory #(
//---------Sizes-----------------
	parameter data_WIDTH = 32,//Words de 32 bits
	parameter ADDR_WIDTH = 10//2^10 = 1024 Enderecos
)
(
//---------Input-----------------
	input [ADDR_WIDTH-1:0] address,
	input clk,
//---------Output-----------------
	output reg [data_WIDTH-1:0] dataOut
);

//---------Interno---------------
	reg [data_WIDTH-1:0] memoria [0:(1<<ADDR_WIDTH)-1];
//
	initial begin //Carregamento de dados iniciais na memoria, no caso, instrucoes
		$readmemb("instructionmemory.txt", memoria);
	end

//Nao precisa implementar uma estrutura de leitura ou escrita, visto que a memoria sera utilizada apenas como leitura
	always @ (posedge clk) begin
		dataOut <= memoria[address];//Leitura
	end

endmodule

