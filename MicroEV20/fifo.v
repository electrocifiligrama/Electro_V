module fifo(input clk, 
				input enable,
				input pop_push,
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

	
always@(posedge clk) 
	begin 
		if(clear) begin
			queue[0] = 0;
			queue[1] = 0;
			queue[2] = 0;
			queue[3] = 0;
			index = 3;
		end
		else if(enable)
			begin
				if(!pop_push)
					begin
						queue[index] <= I;
						index = index - 1;
					end
				else 
					begin 
						P = queue[3];
						queue[3] = queue[2];
						queue[2] = queue[1];
						queue[1] = queue[0];
						queue[0] = 0;
						index = index + 1;
					end 
			end
	end


endmodule
