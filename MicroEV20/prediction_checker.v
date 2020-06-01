module prediction_checker(input [6:0] T,
									input [10:0] P,
									input [15:0] W,
									input[1:0] pred_type,
									input CY,
									input last_pred,
									output reg incorrect_pred,
									output reg correct_pred,
									output reg pop);

always@(T or W) begin
	incorrect_pred = 0;
	correct_pred = last_pred;
	
	if(T == 7'b1000001) begin
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
	
	if (!incorrect_pred) begin
		pop = 1;
	end 
	else begin
		pop = 0;
	end
end
endmodule
