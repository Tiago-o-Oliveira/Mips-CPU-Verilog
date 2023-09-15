module Counter(
	input Load, Clk,
	output reg K
);
		
	reg [7:0] count;	
		
	always @ (posedge Clk) 
	begin									
			if (Load) 
			begin
					count = 1'b0;
					K = 1'b0;
			end 
			else if (count == 29) 
			begin
					K = 1'b1;
			end
			else 
			begin 
					K = 1'b0;
					count = count + 1;
			end
	end
endmodule


	