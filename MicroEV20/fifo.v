module fifo(input clk, 
				input pop,
				input push,
				input clear,
				input I,
				output reg P);

integer index = 3;
reg [3:0] queue;

initial begin 
	queue[0] = 0;
	queue[1] = 0;
	queue[2] = 0;
	queue[3] = 0;
end 

	
always@(posedge clk) begin 
	if(clear) begin
		queue[0] = 0;
		queue[1] = 0;
		queue[2] = 0;
		queue[3] = 0;
		index = 3;
	end
	else begin
		if (pop) begin
			P = queue[3];
			queue[3] = queue[2];
			queue[2] = queue[1];
			queue[1] = queue[0];
			queue[0] = 0;
			index = index + 1;		
		end
		if(push) begin
			queue[index] <= I;
			index = index - 1;
		end	
	end

end


endmodule
