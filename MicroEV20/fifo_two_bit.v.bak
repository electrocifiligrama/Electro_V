module fifo_two_bit(	input clk,
							input clear,
							input pop,
							input push,
							input [1:0] I,
							output [1:0] P);
							


genvar i;
generate
	for (i = 0; i <= 1; i = i + 1) begin : fifo2b_block
      fifo2 f0(.clk(clk),
				.clear(clear),
				.push(push),
				.pop(pop),
				.I(I[i]),
				.P(P[i]));
	end
endgenerate

endmodule
