  module bi_shift_reg ( input in, 
								input clk, 
								input ret,
								input bsr,
								output reg [3:0]out, 
								output reg TOS);   
								

	
	always @ (posedge clk)
			if(ret)
				begin 	//pop
				  out <= {out[2:0], 1'b0};
				  TOS <= out[3];
				end
			else if (bsr)
				begin	//push
					out <= {in, out[3:1]};
					TOS <= in;				
				end
endmodule
