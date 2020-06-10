module bi_shift_reg (input in, input clk, input enb, input dir, input rstn, output reg [3:0] out);   
   always @ (posedge clk)
      if (!rstn)
         out <= 0;
      else begin
         if (enb)
            case (dir)
              0 :  out <= {out[2:0], 1'b0};
              1 :  out <= {in, out[3:1]};
            endcase
         else
            out <= out;
      end
endmodule