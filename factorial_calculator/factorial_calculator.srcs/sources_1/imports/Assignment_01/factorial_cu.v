module factorial_calc_cu (
		input  wire     GO,
		input  wire     GT,
		input  wire     ERROR,
		input  wire     CLK,
		input  wire     RST,
		
		output reg		s1,
		output reg		s2,
		output reg		Load_reg,
		output reg		Load_cnt,
		output reg		EN,
		output reg		Done,
		output wire [2:0] cs_out
	);
	
	parameter	S0 = 3'b000,
				S1 = 3'b001,
				S2 = 3'b010,
				S3 = 3'b011,
				S4 = 3'b100;
	
	reg [2:0] CS, NS;
	assign cs_out = CS;
	
	always @ (posedge CLK, posedge RST)
		begin
			if(RST == 1) CS <= S0;
			else		 CS <= NS;
		end
		
	//Output logic
	always @ (CS)
		begin
			case(CS)
				S0: begin
					{s1, s2, Load_reg, Load_cnt, EN, Done} = 6'b0;
				end
				S1: begin
				    {s1, s2, Load_reg, Load_cnt, EN, Done} = 6'b001110;
				end
				S2: begin
				    {s1, s2, Load_reg, Load_cnt, EN, Done} = 6'b101010;
				end
				S3: begin
				    {s1, s2, Load_reg, Load_cnt, EN, Done} = 6'b100000;
				end
				S4: begin
				    {s1, s2, Load_reg, Load_cnt, EN, Done} = 6'b010001;
				end
			endcase
		end
	
	//Next state logic
	always @ (CS, GO, GT, ERROR)
		begin
			case (CS)
				S0: begin
					if (GO == 1) NS = S1;
					else		 NS = S0;
				end
				S1: begin
					if(ERROR == 0) 
						if (GT == 1) NS = S2;
						else         NS = S4;
					else		 NS = S0;
				end
				S2: begin
					NS = S3;
				end
				S3: begin
					if (GT == 1) NS = S2;
					else		NS = S4;	
				end
				S4: begin
					NS = S0;
				end
			endcase
		end
		
endmodule