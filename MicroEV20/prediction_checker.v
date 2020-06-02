module prediction_checker(input [6:0] T,
									input [15:0] W,
									input[1:0] pred_type,
									input CY,
									input last_pred,
									output reg incorrect_pred,
									output reg correct_pred,
									output reg checked);
/**************************************
************prediction_checker*********
***************************************

INPUT:
		1) T: TYPE of the MIR that is currently on the execute step of the pipeline.
		2) W: current working register.
				
		3) pred_type: type of prediction to be checked (01 for JZE, 10 for JNE, XX for JCY)
		4) CY: current value of carry.
		5) last_pred: prediction to be checked (1 taken, 0 not taken).

OUTPUT:
		1) incorrect_pred: 1 if the prediction was incorrect. 0 Otherwise.
		2) correct_pred: 1 if the prediction should have been "take the branch". 0 otherwise.
		3) checked: 1 if the current instruction on the execute step of the pipeline
						involved previous prediction when fetched. 
						0 Otherwise.
		
TIME ANALYSIS (for input and for output):

		1) Continuous: 
*/		
always@(T or W or last_pred or pred_type) begin
	incorrect_pred = 0;
	correct_pred = last_pred;
	
	if(T == 7'b1000001) begin
		checked <= 1;
		if(pred_type == 2'b01) begin		//JZE 	
			if(W == 15'b0) begin 	//should have taken the branch
				if (!last_pred) begin	//mistakes were made
					incorrect_pred <= 1;
					correct_pred <= 1;
				end
			end 
			else begin		//should not have taken the branch
				if(last_pred) begin 	//mistakes were made
					incorrect_pred <= 1;
					correct_pred <= 0;					
				end
			end
		end
		else if (pred_type == 2'b10) begin	//JNE
			if(W[15] == 0) begin 	//should have taken the branch
				if (!last_pred) begin	//mistakes were made
					incorrect_pred <= 1;
					correct_pred <= 1;
				end 
			end 
			else begin				//should not have taken the branch
				if(last_pred) begin //mistakes were made
					incorrect_pred <= 1;
					correct_pred <= 0;
				end
			end
		end
	end
	else if(T == 7'b1010000) begin		//JCY
		checked <= 1;
		if(CY) begin				//Should have taken the branch
			if(!last_pred) begin
				incorrect_pred <= 1;
				correct_pred <= 1;
			end
		end
		else begin			//should not have taken the branch
			if(last_pred) begin
				incorrect_pred <= 1;
				correct_pred <= 0;
			end
		end
	end 
	else begin
		checked <= 0;
	end
end
endmodule
