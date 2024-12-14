module Prog_Exer1_1(W, x, y, z);

	output	W[3:0];
	input	x, y, z;
	wire	w1, w2, w3;
	
	not	U1(w1, x), U2(w2, y), U3(w3, z);
	nand	U4(W[0], w1, w2, w3), U5(W[1], w1, y, w3),
		U6(W[2], x, w2, w3), U7(W[3], x, y, w3);

endmodule

module MUT_Prog_Exer1_1;

	reg	tb_x, tb_y, tb_z;
	wire	tb_W[3:0];

	Prog_Exer1_1 mut_Prog_Exer1_1(tb_W[3:0], tb_x, tb_y, tb_z);
	
	initial begin
		tb_x=1'b0; tb_y=1'b0; tb_z=1'b0;
		$display("Simulating output for Program Exercise 1-1");
		$display("Tsim\tx y z\tW[3] W[2] W[1] W[0]");
		$monitor("%0d\t%b %b %b\t%b    %b    %b    %b",$time, tb_x, tb_y, tb_z, tb_W[3], tb_W[2], tb_W[1], tb_W[0]);
		#2 tb_x=1'b0; tb_y=1'b0; tb_z=1'b1;
		#2 tb_x=1'b0; tb_y=1'b1; tb_z=1'b0;
		#2 tb_x=1'b0; tb_y=1'b1; tb_z=1'b1;
		#2 tb_x=1'b1; tb_y=1'b0; tb_z=1'b0;
		#2 tb_x=1'b1; tb_y=1'b0; tb_z=1'b1;
		#2 tb_x=1'b1; tb_y=1'b1; tb_z=1'b0;
		#2 tb_x=1'b1; tb_y=1'b1; tb_z=1'b1;
		#2 $finish;
	end
endmodule
