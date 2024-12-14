module Prog_Exer2_2(F, x);
	input [3:0]x;
	wire [1:8]w;
	output F;
	
	//gate-level model converted from the logic diagram
	not U1(w[1], x[3]), U2(w[2], x[2]), U3(w[3], x[1]), U4(w[4], x[0]);
	and U5(w[5], w[1], x[2]), U6(w[6], x[1], x[0]), 
		U7(w[7], x[3], w[2]), U8(w[8], x[3], w[3], w[4]);
	or U9(F, w[5], w[6], w[7], w[8]);
endmodule

module MUT_Prog_Exer2_2;
	reg [3:0]tb_x;
	wire tb_F;

	//instantiation of module under test
	Prog_Exer2_2 mut_Prog_Exer2_2(tb_F, tb_x);

	//displaying outputs using all possible inputs
	initial begin
		tb_x=4'b0000;
		$display("Simulating output for Program Exercise 2-2");
		$display("Tsim\tx[3:0]\tF");
		$monitor("%0d\t%b\t%b", $time, tb_x, tb_F);
		#5 tb_x=4'b0001;
		#5 tb_x=4'b0010;
		#5 tb_x=4'b0011;
		#5 tb_x=4'b0100;
		#5 tb_x=4'b0101;
		#5 tb_x=4'b0110;
		#5 tb_x=4'b0111;
		#5 tb_x=4'b1000;
		#5 tb_x=4'b1001;
		#5 tb_x=4'b1010;
		#5 tb_x=4'b1011;
		#5 tb_x=4'b1100;
		#5 tb_x=4'b1101;
		#5 tb_x=4'b1110;
		#5 tb_x=4'b1111;
		#5 $finish;
	end
endmodule
