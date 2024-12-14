module Bit6_Adder_Subtractor_DF(a, b, m, CoBo, SD);
	input [5:0]a;
	input [5:0]b;
	input m;
	output CoBo;
	output [5:0]SD;

	assign {CoBo, SD} = m? (a + ~b) + m: (a + b) + m;	
	
endmodule

module MUT_Bit6_Adder_Subtractor_DF;
	reg [5:0]tb_a;
	reg [5:0]tb_b;
	reg tb_m;
	wire tb_CoBo;
	wire [5:0]tb_SD;
	
	Bit6_Adder_Subtractor_DF mut_bit6_adder_subtractor_df(tb_a, tb_b, tb_m, tb_CoBo, tb_SD);
	
	initial begin
		tb_a = 23; tb_b = 20; tb_m = 0;
		$display("Truth table of Program Exercise 7-2");
		$display("Time\ta[5:0] b[5:0] m   Co/Bo    S/D");
		$monitor("%0d\t%b %b %b     %b     %b", $time, tb_a, tb_b, tb_m, tb_CoBo, tb_SD);
		#5 tb_a = 53; tb_b = 10; tb_m = 1;
		#5 tb_a = 56; tb_b = 42; tb_m = 0;
		#5 tb_a = 23; tb_b = 40; tb_m = 1;
		#5 tb_a = 2; tb_b = 56; tb_m = 0;
		#5 tb_a = 12; tb_b = 6; tb_m = 1;
		#5 tb_a = 30; tb_b = 63; tb_m = 0;
		#5 tb_a = 23; tb_b = 10; tb_m = 1;
		#5 tb_a = 20; tb_b = 27; tb_m = 0;
		#5 tb_a = 15; tb_b = 60; tb_m = 1;
		#5 $finish;
	end
endmodule
