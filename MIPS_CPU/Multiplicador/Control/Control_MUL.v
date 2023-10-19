module Control_MUL (
	input St, Clk, k,  M,
	output Idle, Done, Load, Sh, Ad
);

	reg      [4:0] out;
	reg		[1:0] state = 1'b0;
	
	assign Idle = out[0];
	assign Load = out[1];
	assign Ad   = out[2];
	assign Sh   = out[3];
	assign Done = out[4];
	
	parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3;

	always @ (state or M or St) 
	begin
		case (state)
			S0:
				if(St)
					out = 5'b00010;
				else
					out = 5'b00001;
			S1:
				if(M)
					out = 5'b00100;
				else 
					out = 5'b00000;
			S2:
					out = 5'b01000;
			S3:
					out = 5'b10000;
			default:
				   out = 5'b00001;
		endcase
	end

	always @ (posedge Clk) 
	begin
			case (state)
				S0:
					if(St) 
						state <= S1;
					else 
						state <= S0;
				S1:	
						state <= S2;
				S2:
					if (k)
						state <= S3;
					else
						state <= S1;
				S3:
						state <= S0;

			endcase
	end
endmodule
