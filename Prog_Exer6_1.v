module NAND_Latch(input s, r, output Q, nQ);
	nand U1(Q, s, nQ);
	nand U2(nQ, r, Q); 
endmodule

module D_FF_Positive(input d, clk, output Q, nQ);
	wire [2:0]w;
	
	nand U2(w[2], w[1], d);
	NAND_Latch U3(.s(w[2]), .r(clk), .nQ(w[0])); //nand latch 1

	nand U1(w[1], w[0], clk, w[2]);
	NAND_Latch U4(.s(w[0]), .r(w[1]), .Q(Q), .nQ(nQ)); //nand latch 2
endmodule

module MUT_D_FF_Positive;
	reg tb_d, tb_clk;
	wire tb_Q, tb_nQ;

	//d flip flop module instantiation
	D_FF_Positive mut_d_ff_positive(.d(tb_d), .clk(tb_clk), .Q(tb_Q), .nQ(tb_nQ));

	initial begin
		//initial input
		#5 tb_clk = 1'b1; tb_d = 1'b1;

		$display("D Flip Flop using NAND Latch Truth Table");
		$display("clk D  Q Q'  			     Time");
		$monitor("%b   %b  %b %b %d", tb_clk, tb_d, tb_Q, tb_nQ, $time);
		
		#5 tb_clk = ~tb_clk; tb_d = 1'b0;
		#5 tb_clk = ~tb_clk; tb_d = 1'b0; 
		#5 tb_clk = ~tb_clk; tb_d = 1'b1; 
		#5 tb_clk = ~tb_clk; tb_d = 1'b1; 
		#5 tb_clk = ~tb_clk; tb_d = 1'b1; 
		#5 tb_clk = ~tb_clk; tb_d = 1'b1;
		#5 tb_clk = ~tb_clk; tb_d = 1'b0; 
		#5 tb_clk = ~tb_clk; tb_d = 1'b0; 
		#5 tb_clk = ~tb_clk; tb_d = 1'b0; 
		#5 tb_clk = ~tb_clk; tb_d = 1'b0; 
		#5 tb_clk = ~tb_clk; tb_d = 1'b1; 
		#5 tb_clk = ~tb_clk; tb_d = 1'b1; 
		#5 $finish;
	end
endmodule