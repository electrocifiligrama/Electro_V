module prediction_control(input clk,
							input [21:0] I,
							input [10:0] PC,
							output reg enable,
							output reg [10:0]next);

/**************************************
**************prediction_control*******
***************************************

INPUT:
		1) clk: clock signal
		2) I: instruction (from RAM)
		3) PC: Current value of PC register.

OUTPUT:
		1) enable: 1 if I is an instruction that requires prediction.
					  0 otherwise.
						The instructions that require prediction are:
								a) JZE
								B) JNE
								C) JCY
								
		2) next: resolves conflict for instructions that don t require prediction
					(except for BSR)
					If I is an instruction that does not require prediction,
								a) next = PC if I is not JMP.
								b) next = I[10:0] if I is JMP.
					If I is an instruction that requires prediction, next is undefined.
					
TIME ANALYSIS (for input and for output):

		1) Continuous: enable is continuously evaluated based on changes on I. 
							If changes on I happen with every negedge, then enable will 
							also be updated after each negedge.
*/							
							
							
initial begin
	enable = 0;
end 

always @ (I) begin
	if(I[21] == 1) begin
		if(I[21:19] == 3'b100) begin  //unconditional jump
			next <= I[10:0];
			enable <= 0;
		end
		else begin
			enable <= 1;
		end
	end
	else begin
		next <= PC;
		enable <= 0;
	end
end


endmodule
