include "seven_fifo.v"

module branch_control(input clk,
							input [13:0] I,
							input [10:0] PC,
							output next[10:0]) ;

reg enable;
initial enable = 0;
reg pop_push;
initial pop_push = 0;
reg prediction;
initial prediction = 0;

module branch_predictor predictor(I[13:11], prediction);
module branch_fifo1(.clk(clk),
                    .enable(enable),
                    .I(I[12:11]),
                    .pop_push(pop_push)
                    );
module branch_fifo2(.clk(clk),
                    .enable(enable),
                    .I(),
                    .pop_push(pop_push));

wire prediction;

	always@()
		begin
			if (prediction)
				next <= I[10:0];
			else
				next <= PC;
		end

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

//this piece of code is not necessary
	always @(posedge clk)
		begin
			if(enable) begin
				if(prediction) begin
					//push PC to fifo1
				end
				else begin
					//push I[10:0] to fifo1
				end
				//pushes automatically I[12:11] to fifo2
			end
		end

endmodule;
