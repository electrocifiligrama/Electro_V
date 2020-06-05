  module push ( input in, 
								input bsr,
								input [3:0]shift_reg,
								output reg [3:0]out);   
								

	initial out = 0;				
								
	always @ (posedge bsr)
			begin	//push
				out <= {in, shift_reg[3:1]};		  
			end
endmodule

