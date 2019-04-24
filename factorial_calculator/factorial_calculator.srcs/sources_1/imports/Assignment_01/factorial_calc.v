module factorial_calc #(WIDTH = 32) (
		input  wire		  GO,
		input  wire		  RST,
		input  wire		  CLK,
		input  wire	[3:0] N,	
		
		output wire		  DONE,
		output wire		  ERROR,
		output wire [2:0] CS_out, //Used for test bench
		output wire [WIDTH-1:0] factorial_output
	);
	
wire GT_transfer;
wire s1_transfer;
wire s2_transfer;
wire Load_cnt_transfer;
wire Load_reg_transfer;
wire EN_transfer;
	
factorial_calc_cu CU(
	.GO			(GO),
	.GT			(GT_transfer),
	.ERROR		(ERROR),
	.CLK		(CLK),
	.RST		(RST),
	
	.s1			(s1_transfer),
	.s2			(s2_transfer),
	.Load_reg	(Load_reg_transfer),
	.Load_cnt	(Load_cnt_transfer),
	.EN			(EN_transfer),
	.Done		(DONE),
	.cs_out		(CS_out)    //Used for debugging
);

factorial_calc_dp DP(
	.RST			(RST),
	.CLK			(CLK),
	.factorial_in	(N),
	.s1				(s1_transfer),
	.s2				(s2_transfer),
	.Load_reg		(Load_reg_transfer),
	.Load_cnt		(Load_cnt_transfer),
	.EN				(EN_transfer),
	
	.factorial_out	(factorial_output),
	.GT_output		(GT_transfer),
	.ERROR			(ERROR)
);

endmodule