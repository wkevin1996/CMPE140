module error_check #(WIDTH = 4) (
		input  wire [WIDTH-1:0] in,
		output wire 			out
	);
	
	assign out = (in > 12) ? 1 : 0;
	
endmodule