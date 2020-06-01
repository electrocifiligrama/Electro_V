module fifo_popper(input [6:0] T,
						 output reg pop_signal);

initial begin 
	pop_signal = 0;
end					
	 
always@(T) begin
	if((T == 7'b1000001) || (T == 7'b1010000)) begin
		pop_signal = 1;
	end 
	else begin
		pop_signal = 0;
	end
	
end
						 
endmodule
