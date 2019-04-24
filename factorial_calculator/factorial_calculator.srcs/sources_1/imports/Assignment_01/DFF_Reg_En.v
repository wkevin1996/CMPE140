module DFF_register_EN #(parameter Data_width = 8) (D, Q, CLK, RST, EN);

input		CLK, RST, EN;
input		[Data_width-1:0] D;
output reg 	[Data_width-1:0] Q;

always@(posedge CLK | RST )
	if(EN)
		Q <= (RST) ? 0 : D;
	else
		Q = Q;

endmodule