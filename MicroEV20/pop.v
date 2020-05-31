  module pop ( input in, 
								input ret,
								input [3:0]shift_reg,
								output reg [3:0]out, 
								output reg lifoOut);   
								
	initial out = 0;

	always @ (posedge ret)
			begin 	//pop
			  out <= {shift_reg[2:0], 1'b0};
			  lifoOut <= shift_reg[3];
			end
endmodule