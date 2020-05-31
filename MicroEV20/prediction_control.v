module prediction_control(input clk,
							input [13:0] I,
							input [10:0] PC,
							output reg enable,
							output reg [10:0]next);;

initial begin
	enable = 0;
end 

always @ (I) begin
	if(I[13] == 1) begin
		if(I[13:11] == 3'b100) begin  //unconditional jump
			next <= I[10:0];
			enable <= 0;
		end
		else begin
			enable <= 1;
		end
	end
	else begin
		next <= PC;
		enable <= 0;
	end
end


endmodule
