module factorial_calc_dp_tb;

	// inputs
	reg RST, CLK, s1, s2, Load_reg, Load_cnt, EN;
	reg [3:0] factorial_in;
	
	// outputs
	wire [31:0] factorial_out;
	wire GT_output, ERROR;
	
	factorial_calc_dp DUT (RST, CLK, factorial_in, s1, s2, Load_reg, Load_cnt, EN, factorial_out, GT_output, ERROR
	);

reg [3:0] i;

initial begin
		// Start with reset
		RST = 1;
		{s1, s2, Load_reg, Load_cnt, EN} = 5'b00000;
		factorial_in = 4'b0000;
		#1;
		tick;
		RST = 0;
        
        for(i = 4'b0000; i < 4'b1111; i = i + 4'b0001)
        begin 
            // S0
            factorial_in = i;
            state_change(0, 0, 0, 0, 0);
            #1;
            tick;
            
            // S1
            state_change(0, 0, 1, 1, 1);
            #1;
            tick;
            
            if(ERROR == 1)
            begin 
                // S0
                state_change(0, 0, 0, 0, 0);
            end
            else
                begin
                while (GT_output == 1)
                    begin
                        // S2
                        state_change(1, 0, 1, 0, 1);
                        #1;
                        tick;
                        
                        // S3
                        state_change(1, 0, 0, 0, 0);
                        #1;
                        tick;
                    end
                // S4
                state_change(0, 1, 0, 0, 0);
                #1;
                tick;
                end       
        end
        
		$finish;
		end

task state_change (in_s1, in_s2, in_reg, in_cnt, in_EN);
	begin
		s1 = in_s1;
		s2 = in_s2;
		Load_reg = in_reg;
		Load_cnt = in_cnt;
		EN = in_EN;
	end
endtask
		
task tick;
	begin
		CLK = 1'b1; #5;
        CLK = 1'b0; #5;
    end
endtask
endmodule