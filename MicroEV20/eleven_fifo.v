module eleven_fifo(	input clk,
							input enable,
							input clear,
							input select,
							input pop,
							input push,
							input [10:0] I1,
							input [10:0] I2,
							output reg [10:0] P);
							
/**************************************
**************eleven_fifo**************
***************************************
The eleven_fifo acts as a backup of the opposite PC of the prediction
in case the prediction of the branch_predictor is incorrect.
INPUT:
		1) clk: clock signal.
		2) enable: 1 when the select signal should be taken into account. 0 Otherwise.
		3) clear: see fifo.v
		4) select: 1 when I1 should be the input to the fifo. 0 when I2 should be the input to the fifo.
					  The input to the fifo is I1 when enable = 0.
		5) pop: see fifo.v
		6) push: see fifo.v
		7) I1: Default input to the fifo(enable = 0 or (enable = 1 and select = 1) )
				 for when a push operation is performed.
		8) I2: input to the fifo when select = 0 for when a push operation is performed.

OUTPUT:
		1) P: output of the fifo when a pop operation is performed. See fifo.v
								
TIME ANALYSIS (for input and for output):
		1) posedge: see fifo.v
		2) Continuous: the input selection (enable and select signals) is done continuously.
							In this way, if enable changes on negedge, then select will be taken into 
							account after negedge and will this will define the input bus after negedge.
*/		

reg [10:0] curr_selection;

integer i;
initial begin
	for (i = 0; i <= 10; i = i + 1) begin
      fifo(.clk(clk),
				.clear(clear),
				.push(push),
				.pop(pop),
				.I(curr_selection[i]),
				.P(P[i]));
	end
end

always@(*) begin
	if(enable) begin
		if(select) begin
			curr_selection = I1;		//push I[10:0] to fifo1 in posedge of clk
		end
		else begin
			curr_selection = I2;		//push PC to fifo1 in posedge of clk
		end
	end
	else begin
		curr_selection = I1;			
	end 
end
endmodule
