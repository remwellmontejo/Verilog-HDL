module Bit2_Multiplier(a,b,P);
	// I/O
	input [1:0]a; 
	input [1:0]b;
	wire [3:0]cp;
	output [3:0]P;

	// 1st level
	and U1(P[0], a[0], b[0]), U2(cp[0], a[0], b[1]), U3(cp[1], a[1], b[0]), U4(cp[2], a[1], b[1]);

	// 2nd level
	xor U5(P[1], cp[0], cp[1]), U7(P[2], cp[2], cp[3]);
	and U6(cp[3], cp[1], cp[0]), U8(P[3], cp[2], cp[3]);
endmodule

module MUT_Bit2_Multiplier;
	reg [1:0]tb_a;
	reg [1:0]tb_b;
	wire [3:0]tb_P;

	Bit2_Multiplier bit2_multiplier_testbench(tb_a, tb_b, tb_P); // 2-bit multiplier instantiation

	initial begin
		tb_a = 2'b00; tb_b = 2'b00;
		$display("Truth table of 2-bit Multiplier");
		$display("Time\ta[1:0] b[1:0] P[3:0]");
		$monitor("%0d\t  %b     %b    %b  ", $time, tb_a, tb_b, tb_P);

		#5 tb_a = 2'b00; tb_b = 2'b01;
		#5 tb_a = 2'b00; tb_b = 2'b10;
		#5 tb_a = 2'b00; tb_b = 2'b11;
		#5 tb_a = 2'b01; tb_b = 2'b00;
		#5 tb_a = 2'b01; tb_b = 2'b01;
		#5 tb_a = 2'b01; tb_b = 2'b10;
		#5 tb_a = 2'b01; tb_b = 2'b11;
		#5 tb_a = 2'b10; tb_b = 2'b00;
		#5 tb_a = 2'b10; tb_b = 2'b01;
		#5 tb_a = 2'b10; tb_b = 2'b10;
		#5 tb_a = 2'b10; tb_b = 2'b11;
		#5 tb_a = 2'b11; tb_b = 2'b00;
		#5 tb_a = 2'b11; tb_b = 2'b01;
		#5 tb_a = 2'b11; tb_b = 2'b10;
		#5 tb_a = 2'b11; tb_b = 2'b11;
		#5 $finish;
	end
endmodule
