module DelayInicial( input clk,
					output wire mux_sel,
					output reg [32:0]MI_out);
	reg [1:0] counter = 3;
	initial MI_out = 33'b000000000000000100011000000000000;
	assign mux_sel = counter[0]|counter[1];
	
	always @ (negedge clk)
		begin
			if(counter > 0)
				counter = counter - 1;
		end
	
endmodule