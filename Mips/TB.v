`timescale 1ns/100ps
module TB();
	//----Inputs-and-Outputs-------
	reg CLK,RST;
	reg Data_BUS_READ;
	wire[31:0] ADDR, Data_BUS_WRITE;
	wire Cs, WR_RD;
	//
	
	cpu DUT(
	.CLK(CLK),
	.RST(RST),
	.Data_BUS_READ(Data_BUS_READ),
	.ADDR(ADDR), 
	.Data_BUS_WRITE(Data_BUS_WRITE),
	.CS(Cs),
	.WR_RD(WR_RD)
	);
	
	//Signals that need to be spied o_0 0_o
	reg CLK_SYS,CLK_MUL;
	reg[31:0] WriteBack;
	//
	initial begin
		RST = 1;
		CLK = 0;
		Data_BUS_READ=32'dz;
		#500 RST = 0;
		#15500 $stop;
	end
	
	initial begin
		$init_signal_spy("DUT/CLK_SYS","CLK_SYS",1);
		$init_signal_spy("DUT/CLK_MUL","CLK_MUL",1);
		$init_signal_spy("DUT/WriteBack","WriteBack",1);
	end
	
	always begin
		#5 CLK = ~CLK;//Levar em consideracao que essa e´ a frequencia do multiplicador
	end
	
endmodule	