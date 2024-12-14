module NAND_Latch(input s, r, output Q, nQ);
	nand U1(Q, s, nQ);
	nand U2(nQ, r, Q); 
endmodule

module D_Latch(input en, d, output Q, nQ);
	wire s_wire, r_wire, d_not;
	not  U3(d_not, d);
	nand U4(s_wire, d, en);
	nand U5(r_wire, d_not, en); 
	NAND_Latch U6(s_wire, r_wire, Q, nQ); //nand latch module instantiation
endmodule

module Bit4_Register(input [4:1]i, clk, output[4:1]A);
	//4 d latch module instantiation
	D_Latch U6(.en(clk), .d(i[4]), .Q(A[4])); 
	D_Latch U7(.en(clk), .d(i[3]), .Q(A[3]));
	D_Latch U8(.en(clk), .d(i[2]), .Q(A[2]));
	D_Latch U9(.en(clk), .d(i[1]), .Q(A[1]));
endmodule

module MUT_Bit4_Register;
	reg [4:1]tb_i;
	reg tb_clk;
	wire [4:1]tb_A;

	Bit4_Register mut_bit4_register(tb_i, tb_clk, tb_A);

	initial begin
		tb_clk = 1'b1; tb_i = 4'b1000;

		$display("4-bit Register using D Latch Truth Table");
		$display("clk\t[4:1]i  [4:1]A\t  Time");
		$monitor(" %b \t %b    %b \t   %0d", tb_clk, tb_i, tb_A, $time);
		
		#5 tb_clk = ~tb_clk; tb_i = 4'b1010;
		#5 tb_clk = ~tb_clk; tb_i = 4'b1011;
		#5 tb_clk = ~tb_clk; tb_i = 4'b1100;
		#5 tb_clk = ~tb_clk; tb_i = 4'b0010; 
		#5 tb_clk = ~tb_clk; tb_i = 4'b1010;
		#5 tb_clk = ~tb_clk; tb_i = 4'b0010;
		#5 tb_clk = ~tb_clk; tb_i = 4'b1111;
		#5 tb_clk = ~tb_clk; tb_i = 4'b0000;
		#5 tb_clk = ~tb_clk; tb_i = 4'b1100;
		#5 tb_clk = ~tb_clk; tb_i = 4'b0001;
		#5 tb_clk = ~tb_clk; tb_i = 4'b0101;
		#5 tb_clk = ~tb_clk; tb_i = 4'b1000;
		#5 $finish;
	end
endmodule