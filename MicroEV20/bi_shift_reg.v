// Code your design here
//module bi_shift_reg (input in, input clk, input enb, input dir, input rstn, output reg [3:0] out);   
module bi_shift_reg ( input in, 
								input bsr, //input enb, 
								input ret, 	input rstn,	
								output reg out3, 
								output reg out2,
								output reg out1,
								output reg out0,
								output reg lifoOut,
								output reg fifoOut);   
			
//  if (!rstn) begin
//			out3 <= 0;
//			out2 <= 0;
//			out1 <= 0;
//			out0 <= 0;
//	end						
  always @ (posedge bsr or posedge ret) 
  if(bsr)
		begin
			//push
			fifoOut <= out0;
			out0 <= out1;
			out1 <= out2;
			out2 <= out3;
			out3 <= in;	
		end
	else if(ret)
    	begin 	//pop
		  lifoOut <=out3;
		  out3 <= out2;
		  out2 <= out1;
		  out1 <= out0;
		  out0 <= 1'b0;
		end
endmodule