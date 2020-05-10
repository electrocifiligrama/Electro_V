module ALU( input [15:0] A,B,
				input [3:0] aluC,
				input carryIn,
				output [15:0] Z,
				output carryOut );
	reg [15:0] aluRes;
	reg [16:0] temp;
	assign Z = aluRes;
	assign carryOut = temp[16];
	always @ (*)
	begin
		temp = {1'b0,A} + {1'b0,B}; // A+B 17bit sum
		case(aluC)
		4'b0000: // NopA
			aluRes = A;
		4'b0001: // NopB
			aluRes = B;
		4'b0010: // Not A
			aluRes = ~A;
		4'b0011: // Not B
			aluRes = ~B;
		4'b0100: // Sum
			aluRes = A + B;
		4'b0101: // Carry Sum
			aluRes = A + B + {15'b0,carryIn};
		4'b0110: // Or
			aluRes = A | B;	
		4'b0111: // And
			aluRes = A & B;
		4'b1000: // 0
			aluRes = 16'h0000;
		4'b1001: // 1
			aluRes = 16'h0001;
		4'b1010: // 0xFFFF
			aluRes = 16'hFFFF;
		4'b1011: // Clear Carry
			temp[16] = 1'b0;
		4'b1100: // Set Carry
			temp[16] = 1'b1;
		4'b1101: // Greater comparison
			aluRes = (A>B)?16'h0001:16'h0000;
		4'b1110: // Equal comparison
			aluRes = (A==B)?16'h0001:16'h0000;
		4'b1111: // xor
			aluRes = A ^ B;
		endcase
	end
endmodule
			