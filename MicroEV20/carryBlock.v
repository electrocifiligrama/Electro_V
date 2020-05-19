module carryBlock (  input CYout, 
							input clk,  
							input [3:0] aluC,      
							output reg CY);
							
   always @ (posedge clk)
		begin
			case(aluC)
				4'b0100: // A+B
					CY <= CYout;
				4'b0101: // A+B+CY
					CY <= CYout;
				4'b1011: // CY = 0
					CY <= CYout;
				4'b1100: // CY = 1
					CY <= CYout;
			endcase
		end
endmodule
