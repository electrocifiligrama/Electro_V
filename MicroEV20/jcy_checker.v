module jcy_checker(	input clk,
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

	incorrect_pred <= 0;
	correct_pred <= last_pred;
	
	if(T == 7'b1010000) begin		//JCY
		checked <= 1;
		if(CY) begin				//Should have taken the branch
			if(!last_pred) begin
				incorrect_pred <= 1;
				correct_pred <= 1;
			end
		end
		else if(last_pred) begin //should not have taken the branch and mistakes were made
				incorrect_pred <= 1;
				correct_pred <= 0;
		end
	end 
	else begin
		checked <= 0;
	end 

end

endmodule
