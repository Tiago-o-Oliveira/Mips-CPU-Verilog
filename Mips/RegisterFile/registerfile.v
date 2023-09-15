module registerfile (
//----------Input-----------
	input [31:0] dataIn,
	input we,
	input clk, rst,
	input [4:0] rs,rt,rd,
//----------Output-----------
	output reg [31:0] regA,regB
);
//--------Internal-----------------
	integer k;
	reg [31:0] register [0:15];//A hierarquia tem 32 registros, mas dada a opcao, escolhemos implementar 16
	
//Reseta todos os registros e em seguida efetua a leitura, caso we = 1;
	always @ (negedge clk, posedge rst) begin
		k = 0;
		if(rst)
			for(k = 0; k < 16; k = k+1) begin
				register[k] = 32'b0;
			end
		else if (we) begin
			register[rd] <= dataIn;
		end
	end

//Mantem as saidas A e B com o conteudo dos registros selecionados, os registros A e B da hierarquia, estao embutidos aqui
	always @ (posedge clk) begin
		regA <= register[rs];
		regB <= register[rt];
	end

endmodule
