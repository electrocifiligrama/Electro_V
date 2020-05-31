module branch_control(input clk,
							input [13:0] I,
							input [10:0] PC,
							output reg [10:0]next);

reg enable;
reg pop_push;
reg prediction;
reg clear;
reg [10:0] aux_next;

initial begin
	clear = 0;
	enable = 0;
	pop_push = 0;
	prediction = 0;
end 

branch_predictor predictor(.I(I[12:11]), 
									.predict(enable),
									.prediction(prediction));

//eleven_fifo fifo1(.clk(clk),
//						.enable(enable),
//						.clear(clear),
//						.select(prediction),
//						.I1(PC),
//						.I2(I[10:0]),
//						.P(aux_next));
//
//						
//branch_queue fifo2(.clk(clk),
//						 .enable(!enable),
//						 .pop_push(pop_push),
//						 .clear(clear),
//						 .I(I[12:11]),
//						 .P());

always @ (I) begin
		if(I[13] == 1) begin
			if(I[13:11] == 3'b100)begin  //unconditional jump
				next <= I[10:0];
				enable <= 0;
			end
			else begin
				enable <= 1;
			end
		else begin
			enable <= 0;
		end
	end
end

////this piece of code is not necessary
//always @(posedge clk)
//	begin
//		if(enable) begin
//			if(prediction) begin
//				//push PC to fifo1
//			end
//			else begin
//				//push I[10:0] to fifo1
//			end
//			//pushes automatically I[12:11] to fifo2
//		end
//	end

endmodule;
