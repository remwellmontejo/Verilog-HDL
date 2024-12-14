module Prog_Exer2_1(F, i);
	input [1:0]i;
	output [0:7]F;
	
	//MSB input to buffer and inverter
	buf U1(F[0], i[1]);
	not U2(F[1], i[1]);
	
	and U3(F[2], i[1], i[0]);
	or U4(F[3], i[1], i[0]);
	nor U5(F[4], i[1], i[0]);
	nand U6(F[5], i[1], i[0]);
	xor U7(F[6], i[1], i[0]);
	xnor U8(F[7], i[1], i[0]);
endmodule

module MUT_Prog_Exer2_1;
	reg [1:0]tb_i;
	wire [0:7]tb_F;

	//instantiation of module under test
	Prog_Exer2_1 mut_Prog_Exer2_1(tb_F, tb_i);
	
	//displaying outputs using all possible inputs (including x and z)
	initial begin
		tb_i=2'b00;
		$display("Simulating output for Program Exercise 2-1");
		$display("Tsim\ti[1:0]\tbuf not and or nor nand xor xnor");
		$monitor("%0d\t  %b\t %b   %b   %b  %b   %b   %b    %b   %b",
			 $time, tb_i, tb_F[0], tb_F[1], tb_F[2], tb_F[3], tb_F[4], tb_F[5], tb_F[6], tb_F[7]);
		#5 tb_i=2'b01;
		#5 tb_i=2'b10;
		#5 tb_i=2'b11;
		#5 tb_i=2'b0x;
		#5 tb_i=2'b0z;
		#5 tb_i=2'b1x;
		#5 tb_i=2'b1z;
		#5 tb_i=2'bx0;
		#5 tb_i=2'bx1;
		#5 tb_i=2'bxx;
		#5 tb_i=2'bxz;
		#5 tb_i=2'bz0;
		#5 tb_i=2'bz1;
		#5 tb_i=2'bzx;
		#5 tb_i=2'bzz;
		#5 $finish;
	end
endmodule
	
	
