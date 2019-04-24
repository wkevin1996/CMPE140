module comparatorGT #(WIDTH = 4) (
		input  wire [WIDTH-1:0] in0,
		input  wire	[WIDTH-1:0] in1,
		output wire 			out		
	);
	
	assign out = (in1 > in0) ? 0 : 1;
	
endmodule