module factorial_calc_cu_tb;
	
	// inputs
	reg GO, GT, ERROR, CLK, RST;
	
	// outputs
	wire s1, s2, Load_reg, Load_cnt, EN, Done;
	wire [2:0] cs_out;
	
	factorial_calc_cu DUT (GO, GT, ERROR, CLK, RST, s1, s2, Load_reg, Load_cnt, EN, Done, cs_out 
	);

initial begin
		CLK = 1'b0;
		// Start with reset
		{GO, GT, ERROR, RST} = 4'b0001;
        #1; CLK = 1'b1; #1; CLK = 1'b0;
        // Run through if input was zero
        // S0
        {GO, GT, ERROR, RST} = 4'b0000;
        #1; CLK = 1'b0; #3; CLK = 1'b1;
        // S1
        {GO, GT, ERROR, RST} = 4'b1000;
        #1; CLK = 1'b0; #3; CLK = 1'b1;
		// S4
        {GO, GT, ERROR, RST} = 4'b0000;
        #1; CLK = 1'b0; #3; CLK = 1'b1;  
          
		// Run through each state
		// S0-S4
		// S0
		{GO, GT, ERROR, RST} = 4'b0000;
		#1; CLK = 1'b0; #3; CLK = 1'b1;
		// S1
		{GO, GT, ERROR, RST} = 4'b1000;
		#1; CLK = 1'b0; #3; CLK = 1'b1;
		// S2
		{GO, GT, ERROR, RST} = 4'b0100;
		#1; CLK = 1'b0; #3; CLK = 1'b1;
		// S3
		{GO, GT, ERROR, RST} = 4'b0100;
		#1; CLK = 1'b0; #3; CLK = 1'b1;
		// S2
        {GO, GT, ERROR, RST} = 4'b0100;
        #1; CLK = 1'b0; #3; CLK = 1'b1;
		// S3
        {GO, GT, ERROR, RST} = 4'b0000;
        #1; CLK = 1'b0; #3; CLK = 1'b1;
        // S4
		{GO, GT, ERROR, RST} = 4'b0000;
		#1; CLK = 1'b0; #3; CLK = 1'b1;	   
		
		// Run through error
		// S0
        {GO, GT, ERROR, RST} = 4'b0000;
        #1; CLK = 1'b0; #3; CLK = 1'b1;
		// S1
        {GO, GT, ERROR, RST} = 4'b1000;
        #1; CLK = 1'b0; #3; CLK = 1'b1;
        		// S0
        {GO, GT, ERROR, RST} = 4'b0010;
        #1; CLK = 1'b0; #3; CLK = 1'b1;
        
		$finish;
		end

endmodule