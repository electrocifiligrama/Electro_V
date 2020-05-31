  module bi_shift_reg ( input in, 
								input clk, 
								input ret,
								input bsr,
								output reg [3:0]out, 
								//output reg out2,
								//output reg out1,
								//output reg out0,
								output reg lifoOut);
								//output reg fifoOut);   
								
	reg enb;

	
	
	always @(posedge clk)
	begin
			enb <= 1;	
	end
	
	always @ (ret or bsr)
			if (enb)
			begin
				if(ret)
					begin 	//pop
					  out <= {out[2:0], 1'b0};
					  lifoOut <= out[3];
					end
				else if (bsr)
					begin	//push
						//fifoOut <= out0;
						out <= {in, out[3:1]};		  
					end
			end
endmodule

