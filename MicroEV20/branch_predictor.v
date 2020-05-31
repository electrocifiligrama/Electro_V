module branch_predictor(input clk,
								input [1:0]I,
								input predict,
								input last_prediction,
								input receive_prediction,
								output reg prediction);
					
//predictions: zero if not taken, zero if taken.
reg [6:0] last_takens;		

integer index;
integer takens;

initial begin 
	takens = 6;
	for (index = 0; index <= 6; index = index + 1) begin
		last_takens[index] <= 1;	//we should take the branch as a first prediction. 
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
