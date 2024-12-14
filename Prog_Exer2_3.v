module Prog_Exer2_3(F,x);
	input [1:4]x;
	wire [1:6]w;
	output [1:2]F;

	not U1(w[1], x[3]), U2(w[2], x[4]);

	//gate-level model for F1
	and U3(w[3], x[2], w[2]), U4(w[4], x[3], w[2]);
	or U7(F[1], x[1], w[3], w[4]);

	//gate-level model for F2
	or U5(w[5], x[1], x[2], x[4]), U6(w[6], x[1], w[1], w[2]);
	and U8(F[2], w[5], w[6]);
endmodule

module MUT_Prog_Exer2_3;
	reg [1:4]tb_x;
	wire [1:2]tb_F;
	
	//instantiation of module under test
	Prog_Exer2_3 mut_Prog_Exer2_3(tb_F, tb_x);

	initial begin
		tb_x=4'b0000;
		$display("Simulating output for Program Exercise 2-3");
		$display("Tsim\tx[1:4]\tF[1] F[2]");
		$monitor("%0d\t%b\t %b    %b", $time, tb_x, tb_F[1], tb_F[2]);
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


	
	
	
