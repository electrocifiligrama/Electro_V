module fifo(input clk, 
				input enable,
				input pop_push,
				input I,
				output reg P);

integer index = 3;
reg [3:0] queue;


always@(posedge clk) 
	begin 
		if(enable)
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
