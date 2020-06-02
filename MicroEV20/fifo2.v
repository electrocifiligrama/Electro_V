module fifo2(input clk, 
				input pop,
				input push,
				input clear,
				input I,
				output reg P);
/**************************************
*****************fifo******************
***************************************
INPUT:
		1) clk: clock signal.
		2) pop: 1 if a value should be popped from the fifo to P register. 0 Otherwise.
					If clear = 1 and pop=1, pop is performed before clearing the fifo.
		3) push: 1 if the value in I should be pushed to the fifo. 0 Otherwise.
					push = 1 and pop = 1 is a valid operation only when the fifo is not empty, 
					as pop is performed before push.
		4) clear: 1 if the fifo should be cleared completely (filled with zeros by default).
					 If clear = 1, then push operations are not taken into account.
					 (The effect of clear=1 on push and pop is push=0 and pop=0 for the posedge). 
		5) I: value of the fifo input, to be pushed to the fifo when a push operation is performed.

OUTPUT:
		1) P: After performing a pop operation: value of the popped element.
				After posedge (no pop operation performed): value of first element of the fifo.
				When fifo is empty: 0
				
								
TIME ANALYSIS (for input and for output):

		1) posedge: all inputs are taken into account, and outputs updated.
						pop operations are performed before making a push to the fifo. 
*/		
integer index = 3;
reg [3:0] queue;

initial begin 
	queue[0] = 0;
	queue[1] = 0;
	queue[2] = 0;
	queue[3] = 0;
end 

	
always@(posedge clk) begin 

	// pop first, before clearing
	if (pop) begin 
		P = queue[3];
		queue[3] = queue[2];
		queue[2] = queue[1];
		queue[1] = queue[0];
		queue[0] = 0;
		index = index + 1;	
	end
	
	//if we need to clear, we don t take into account the push operation.
	if(clear) begin
		queue[0] = 0;
		queue[1] = 0;
		queue[2] = 0;
		queue[3] = 0;
		index = 3;
	end
	else if(push) begin
		queue[index] = I;
		index = index - 1;	
	end

	if(!pop) begin
		P = queue[3]; 
	end
end


endmodule
