module MC(a, b, EQ, GT, LT);
	input a, b;
	output EQ, GT, LT;
	wire [0:3]w;

	not U1(w[0], a), U2(w[1], b);
	and U3(w[2], w[0], b), U4(w[3], w[1], a);
	nor U5(EQ, w[2], w[3]);
	buf U6(LT, w[2]), U7(GT, w[3]);
endmodule

module Bit4_MC(a, b, EQ, GT, LT);
	input [3:0]a;
	input [3:0]b;
	output EQ, GT, LT;
	
	wire [3:0]eq_wire;
	wire [3:0]gt_wire;
	wire [3:0]lt_wire;

	//setting up comparators
	MC MC1(a[0], b[0], eq_wire[0], gt_wire[0], lt_wire[0]);
	MC MC2(a[1], b[1], eq_wire[1], gt_wire[1], lt_wire[1]);
	MC MC3(a[2], b[2], eq_wire[2], gt_wire[2], lt_wire[2]);
	MC MC4(a[3], b[3], eq_wire[3], gt_wire[3], lt_wire[3]);

	//EQ
	wire [1:0]eq_connector;
	and U1(eq_connector[1], eq_wire[3], eq_wire[2]), U2(eq_connector[0], eq_connector[1], eq_wire[1]);
	and U3(EQ, eq_connector[0], eq_wire[0]);

	//GT
	wire [2:0]gt_connector;
	and U4(gt_connector[2], eq_wire[3], gt_wire[2]), U5(gt_connector[1], eq_connector[1], gt_wire[1]);
	and U6(gt_connector[0], eq_connector[0], gt_wire[0]);
	or U7(GT, gt_wire[3], gt_connector[2], gt_connector[1], gt_connector[0]);

	//LT
	wire [2:0]lt_connector;
	and U8(lt_connector[2], eq_wire[3], lt_wire[2]), U9(lt_connector[1], eq_connector[1], lt_wire[1]);
	and U10(lt_connector[0], eq_connector[0], lt_wire[0]);
	or U11(LT, lt_wire[3], lt_connector[2], lt_connector[1], lt_connector[0]);
endmodule

//testbench
module MUT_Bit4_MC;
	reg [3:0]tb_a;
	reg [3:0]tb_b;
	wire tb_EQ, tb_GT, tb_LT;

	//instantiation of 4 bit magnitude comparator
	Bit4_MC bit4_mc_testbench(tb_a, tb_b, tb_EQ, tb_GT, tb_LT);

	initial begin
	tb_a = 4'b0110; tb_b = 4'b1100;
	$display("Truth table for 4-bit Magnitude Comparator");
	$display("Time\ta[3:0] b[3:0]  EQ GT LT");
	$monitor("%0d\t %b   %b   %b  %b  %b", $time, tb_a, tb_b, tb_EQ, tb_GT, tb_LT);
	#5 tb_a = 4'b1110; tb_b = 4'b1011;
	#5 tb_a = 4'b1101; tb_b = 4'b1101;
	#5 tb_a = 4'b0101; tb_b = 4'b0011;
	#5 tb_a = 4'b0111; tb_b = 4'b1000;
	#5 tb_a = 4'b1111; tb_b = 4'b1111;
	#5 $finish;
	end
endmodule