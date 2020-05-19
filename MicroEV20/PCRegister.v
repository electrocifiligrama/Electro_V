module PCRegister (  input inc, 
							input preLoad,  
							input [10:0] nextAdd,      
							output reg [10:0] PC);
							
   always @ (posedge inc)
		begin
			if(preLoad)
				PC <= nextAdd;
			else
				PC <= PC + 1;
		end
endmodule
