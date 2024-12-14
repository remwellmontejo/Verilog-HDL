module BCD_Adder_DF(a, b, Co, S);
	input [3:0]a;
	input [3:0]b;
	output Co;
	output [3:0]S;
	
	assign {Co, S} = (a + b) > 9? a + b + 6: a + b;
endmodule
	 
module MUT_BCD_Adder_DF;
	reg [3:0]tb_a;
	reg [3:0]tb_b;
	wire tb_Co;
	wire [3:0]tb_S;
	
	BCD_Adder_DF mut_bcd_adder_df(tb_a, tb_b, tb_Co, tb_S);
	
	initial begin
		tb_a = 9; tb_b = 4;
		$display("Truth table of Program Exercise 7-3");
		$display("Time\ta[3:0] b[3:0]   Co    S");
		$monitor("%0d\t %b   %b     %b  %b", $time, tb_a, tb_b, tb_Co, tb_S);
		#5 tb_a = 6; tb_b = 6;
		#5 tb_a = 6; tb_b = 2;
		#5 tb_a = 3; tb_b = 9;
		#5 tb_a = 4; tb_b = 11;
		#5 tb_a = 10; tb_b = 1;
		#5 tb_a = 3; tb_b = 4;
		#5 tb_a = 7; tb_b = 7;
		#5 $finish;
	end
endmodule 