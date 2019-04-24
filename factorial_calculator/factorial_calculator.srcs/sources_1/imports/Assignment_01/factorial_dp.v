module factorial_calc_dp #(DATA_WIDTH = 32)(
		input  wire RST, CLK,
		input  wire [3:0] factorial_in,
		input  wire s1, s2,
		input  wire Load_reg, Load_cnt, EN,
		output wire [DATA_WIDTH-1:0] factorial_out,
		output wire GT_output,
		output wire ERROR
	);
	
	wire [DATA_WIDTH-1:0] mult_transfer;
	wire [DATA_WIDTH-1:0] input_transfer;
	wire [DATA_WIDTH-1:0] d_reg_transfer;
	wire [3:0] cnt_transfer;
	
	//Input mux for register
	mux2 #(.WIDTH(DATA_WIDTH)) in_mux(
		.sel		(s1),
		.in0		({31'b0, 1'b1}),
		.in1		(mult_transfer),
		.out		(input_transfer)
		);
		
	//D-register for storing mult
	 DFF_register_EN #(.Data_width(DATA_WIDTH)) D_reg (
		.D			(input_transfer), 
		.Q			(d_reg_transfer), 
		.CLK		(CLK), 
		.RST		(RST), 
		.EN			(Load_reg)
		);
	
	//Down counter
	down_counter CNT (
		.CLK		(CLK), 
		.RST		(RST), 
		.CE			(EN), 
		.LD			(Load_cnt),
		.D			(factorial_in),
		.Q			(cnt_transfer)
	);
	
	//Error check checks if n is > 12
	error_check e_check (
		.in			(factorial_in),
		.out		(ERROR)
	);
	
	//Mul multiplies the D-reg value with the down counter value
	mul #(.WIDTH(DATA_WIDTH)) multiplier (
		.in0		({28'b0, cnt_transfer}),
		.in1		(d_reg_transfer),
		.out		(mult_transfer)
	);
	
	//Compares 1 and down counter value
	comparatorGT GT (
		.in0		(cnt_transfer),
		.in1		(4'b0010),
		.out		(GT_output)
	);
	
	//Output mux
	mux2 #(.WIDTH(DATA_WIDTH)) out_mux (
		.sel		(s2),
		.in0		(32'b0),
		.in1		(mult_transfer),
		.out		(factorial_out)
		);
		
endmodule