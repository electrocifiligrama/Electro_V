module jze_checker(	input clk,
							input [6:0] T,
							input [15:0] W,
							input[1:0] aux_pred_type,
							input CY,
							input aux_last_pred,
							output reg incorrect_pred,
							output reg correct_pred,
							output reg checked);
		
reg last_pred = 0;
reg [1:0] pred_type = 0;

always@(negedge clk) begin
	last_pred <= aux_last_pred;
	pred_type <= aux_pred_type;
end

always@(*) begin
	correct_pred <= last_pred;
	incorrect_pred <= 0;
	
	if(T == 7'b1000001) begin
		checked <= 1;
		
		if(pred_type == 2'b01) begin		//JZE 	
			if(W == 15'b0) begin 	//should have taken the branch
				if (!last_pred) begin	//mistakes were made
					incorrect_pred <= 1;
					correct_pred <= 1;
				end
			end 
			else if(last_pred) begin	//should have NOT taken the branch and mistakes were made
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
