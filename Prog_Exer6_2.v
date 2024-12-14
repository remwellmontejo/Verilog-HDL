module NAND_Latch(input s, r, output Q, nQ);
	nand U1(Q, s, nQ);
	nand U2(nQ, r, Q); 
endmodule


module D_FF_Positive(output Q, nQ, input d, clk);
	wire [2:0]w;
	NAND_Latch U3(.s(w[2]), .r(clk), .Q(), .nQ(w[0])); //nand latch 1
	NAND_Latch U4(.s(w[0]), .r(w[1]), .Q(Q), .nQ(nQ)); //nand latch 2
	nand U1(w[1], clk, w[2], w[0]), U2(w[2], d, w[1]);
endmodule

module JK_FF_Positive(output Q, nQ, input j, k, clk);
	wire [1:3]w;
	wire not_k;

	D_FF_Positive U11(.d(w[3]), .clk(clk), .Q(Q), .nQ(nQ)); //d latch module instantiation
	not U8(not_k,k);
	and U3(w[1], not_k, Q), U9(w[2], j, nQ);
	or U10(w[3], w[1], w[2]);	
endmodule

module MUT_JK_FF_Positive;
	reg tb_j, tb_k, tb_clk;
	wire tb_Q, tb_nQ;
	
	//jk ff instantiation
	JK_FF_Positive mut_jk_ff_positive(.j(tb_j), .k(tb_k), .clk(tb_clk), .Q(tb_Q), .nQ(tb_nQ));
    
   	initial begin // clock generator
    	    tb_clk = 1;
   	    forever #2 tb_clk = ~tb_clk;
	end
	
	initial begin
		tb_j = 1'b0; tb_k = 1'b1;

		$display("JK Flip Flop using D Flip Flop Truth Table");
		$display("Time\tclk  J K  Q Q'");
		$monitor("%0d\t %b   %b %b  %b %b", $time, tb_clk, tb_j, tb_k, tb_Q, tb_nQ);
		
		#5  tb_j = 1'b0; tb_k = 1'b0;
		#5  tb_j = 1'b1; tb_k = 1'b0; 
		#5  tb_j = 1'b1; tb_k = 1'b1;
		#5  tb_j = 1'b0; tb_k = 1'b1;
		#5  tb_j = 1'b1; tb_k = 1'b1;
		#5  tb_j = 1'b1; tb_k = 1'b0; 
		#5 tb_j = 1'b0; tb_k = 1'b1;
	    	#5 $finish;
	end
endmodule
