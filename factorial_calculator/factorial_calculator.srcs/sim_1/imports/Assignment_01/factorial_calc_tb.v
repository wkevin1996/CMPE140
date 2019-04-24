module factorial_calc_tb;

	// inputs
	reg GO, RST, CLK;
	reg [3:0] N;
	
	// outputs
	wire DONE, ERROR;
	wire [2:0] CS_out;
	wire [31:0] factorial_output;
	
	factorial_calc DUT (GO, RST, CLK, N, DONE, ERROR, CS_out, factorial_output
	);

reg [3:0] i;

initial begin
		// Start with reset
		CLK = 1'b0;
		GO = 1'b0;
		RST = 1'b1;
		N = 4'b0000;
		#3; CLK = 1'b1; #3; CLK = 1'b0;
		RST = 0;
		for(i = 4'b0000; i < 4'b1111; i = i + 4'b0001)
		begin
		    N = i;
		    GO = 1'b1;
			#3; CLK = 1'b1; #3; CLK = 1'b0;
			//GO = 1'b0;
			while(DONE != 1)
			begin
			         #3; CLK = 1'b1; #3; CLK = 1'b0;
			         GO = 1'b0;
			end
		end
		
		$finish;
		end
endmodule