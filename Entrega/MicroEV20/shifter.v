module shifter( input [15:0] Z,
					 input [1:0] SH,
					 output [15:0] C );
	reg [15:0] shRes;
	assign C = shRes;
	always @ (*)
	begin
		case(SH)
		2'b00: // No Shift
			shRes = Z;
		2'b01: // LSR1
			shRes = Z >> 1;
		2'b10: // LSL1
			shRes = Z << 1;
		2'b11: // ASR1
			shRes = Z >>> 1;
		endcase
	end
endmodule