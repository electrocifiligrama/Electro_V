module prediction_checker(	input clk,
									input [6:0] T,
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


wire checked_jcy;
wire checked_jze;
wire checked_jne;
wire correct_pred_jcy;
wire correct_pred_jze;
wire correct_pred_jne;
wire incorrect_pred_jcy;
wire incorrect_pred_jze;
wire incorrect_pred_jne;

generate
	jcy_checker jcy(.clk(clk),
					.T(T),
					.W(W),
					.aux_pred_type(pred_type),
					.CY(CY),
					.aux_last_pred(last_pred),
					.incorrect_pred(incorrect_pred_jcy),
					.correct_pred(correct_pred_jcy),
					.checked(checked_jcy));
					
	jze_checker jze(.clk(clk),
					.T(T),
					.W(W),
					.aux_pred_type(pred_type),
					.CY(CY),
					.aux_last_pred(last_pred),
					.incorrect_pred(incorrect_pred_jze),
					.correct_pred(correct_pred_jze),
					.checked(checked_jze));
					
	jne_checker jne(.clk(clk),
					.T(T),
					.W(W),
					.aux_pred_type(pred_type),
					.CY(CY),
					.aux_last_pred(last_pred),
					.incorrect_pred(incorrect_pred_jne),
					.correct_pred(correct_pred_jne),
					.checked(checked_jne));
						
endgenerate

always@(*) begin
	
	checked <= 0;
	incorrect_pred <= 0;
	correct_pred <= last_pred;
	
	if(T == 7'b1000001) begin
		if(pred_type == 2'b01) begin 	//JZE
			checked <= checked_jze;
			incorrect_pred <= incorrect_pred_jze;
			correct_pred <= correct_pred_jze;
		end
		else if(pred_type == 2'b10) begin		//JNE
			checked <= checked_jne;
			incorrect_pred <= incorrect_pred_jne;
			correct_pred <= correct_pred_jne;
		end 
	end
	else if(T == 7'b1010000) begin			//JCY
		checked <= checked_jcy;
		incorrect_pred <= incorrect_pred_jcy;
		correct_pred <= correct_pred_jcy;		
	end 
end

endmodule

