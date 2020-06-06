module pline_flush_ctrl(input clk,
								input incorrect_pred,
								output reg exec_ignore,
								output reg wrtback_ignore);

integer counter;
reg flushing;

initial begin 
	flushing <= 0;
	counter <= 4;
end
								
always @ (negedge clk) begin
	if(incorrect_pred) begin
		counter <= 4;
		flushing <= 1;
		exec_ignore <= 1;
		wrtback_ignore <=1;
	end
	
	else if(flushing) begin
		counter <= counter - 1;
		
		if(counter == 1) begin
			exec_ignore <= 0;
		end 
		else if(counter == 0) begin
			wrtback_ignore <= 0;
			flushing <= 0;
		end
	end
end 

endmodule
