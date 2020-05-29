//module bi_shift_reg (input in, input clk, input enb, input dir, input rstn, output reg [3:0] out);   
  module bi_shift_reg (input in, input clk, input enb, input dir, input rstn, 
								output reg out3, 
								output reg out2,
								output reg out1,
								output reg out0);   
	always @ (posedge clk)
      if (!rstn)
		begin
			out3 <= 0;
		  out2 <= 0;
		  out1 <= 0;
		  out0 <= 0;
		 end
      else begin
         if (enb)
            case (dir)
              0 : begin 	//pop
				  //out <= {out[2:0], 1'b0};
				  out3 <= out2;
				  out2 <= out1;
				  out1 <= out0;
				  out0 <= 1'b0;
					end
              1 :  begin	//push
				  //out <= {in, out[3:1]};
				  out3 <= in;
				  out2 <= out3;
				  out1 <= out2;
				  out0 <= out1;
				  end
            endcase
         else
            out3 <= out3;
				out2 <= out2;
				out1 <= out1;
				out0 <= out0;
      end
endmodule