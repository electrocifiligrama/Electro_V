module PCRegister (  input inc, 
							input preLoad,  
							input [10:0] nextAdd,      
							output reg [10:0] PC);
	reg [10:0] auxAdd;
	reg auxLoad;
	always @ (posedge inc)
		begin
			auxAdd <= nextAdd;
			auxLoad <= preLoad;
		end
   always @ (negedge inc)
			if(auxLoad)
				PC <= auxAdd;
			else
				PC <= PC + 11'b00000000001;
endmodule
