module branch_predictor(input clk,
								input [1:0]I,
								input predict,
								input last_prediction,
								input receive_prediction,
								output reg prediction);
/**************************************
**************branch_predictor*********
***************************************

INPUT:
		1) clk: clock signal
		2) I: instruction (from RAM), second and third most significant bits
				These bits indicate the type of condition branch instruction
				that has been received. These may be used when doing branch predictions. 
				(...but are not used on current implementation)
				
		3) predict: 1 when the block should make a prediction, 0 when not. 
						This effectively enables or disables the block. 
		4) last_prediction: When receive_prediction = 1, this bit indicates that the 
									conditional branch that is currently on  the execute step of the 
									pipeline was actually taken. 
									receive_prediction = 0 if the conditional branch was not taken.
									This is used for making future predictions. 
									When receive_prediction = 0, last_prediction is ignored.
		5) receive_prediction: 1 when last_prediction should be taken into account (branch instruction)
										reached the execute step of the pipeline), 0 otherwise.

OUTPUT:
		1) prediction: 1 if the prediction indicates the branch should be taken.
							0 otherwise.
							Undefined behaviour when predict = 0.
								
TIME ANALYSIS (for input and for output):

		1) negedge: receive_prediction is taken into account to update 
						the prediction algorithm.
		2) Continuous: prediction signal is continuously evaluated. 
							As received prediction is only taken into account on negedges, 
							The prediction signal is expected to change only after negedges.
*/		
								
//predictions: zero if not taken, zero if taken.
reg [6:0] last_takens;		

integer index;
integer takens;

initial begin 
	takens = 6;
	for (index = 0; index <= 6; index = index + 1) begin
		last_takens[index] <= 1;	//as a first prediction, we should take the branch
	end 
end 


always@(negedge clk) begin
	if(receive_prediction) begin
		last_takens[6] <= last_takens[5];
		last_takens[5] <= last_takens[4];
		last_takens[4] <= last_takens[3];
		last_takens[3] <= last_takens[2];
		last_takens[2] <= last_takens[1];
		last_takens[1] <= last_takens[0];
		last_takens[0] <= last_prediction;
	end
end

always@(*) begin
	if(predict) begin
		takens = 0;
		for (index = 0; index <= 6; index = index + 1) begin
			if(last_takens[index]) begin
				takens = takens + 1;
			end  
		end 
		if (takens > 3) begin
			prediction = 1;
		end 
		else begin
			prediction = 0;
		end
	end
end


endmodule
