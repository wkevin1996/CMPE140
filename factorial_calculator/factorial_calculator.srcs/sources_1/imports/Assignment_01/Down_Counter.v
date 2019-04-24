module down_counter #(WIDTH = 4) (
		input  wire 		    CLK, RST, CE, LD,
		input  wire [WIDTH-1:0] D,
		output reg  [WIDTH-1:0] Q
	);
	
	always @(posedge CLK)
		begin
			if(RST) // Reset is 1 
				Q = 1;
			else if(CE) // CE is 1
				begin
					if(LD) // CE is 1 and LD is 1
					    Q <= (D == 0) ? 1 : D; // If input is 0 Q is 1, else Q is D
					else        // CE is 1 and LD is 0
						Q = Q - 1; 
				end
			else 
				Q = Q; // CE is 0
		end

endmodule