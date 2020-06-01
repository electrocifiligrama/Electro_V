module eleven_fifo(	input clk,
							input enable,
							input clear,
							input select,
							input pop,
							input push,
							input [10:0] I1,
							input [10:0] I2,
							output reg [10:0] P);

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
			curr_selection = I1;		//push PC to fifo1 in posedge of clk
		end
		else begin
			curr_selection = I2;		//push I[10:0] to fifo1 in posedge of clk
		end
	end
	else begin
		curr_selection = I1;			
	end 
end
endmodule
