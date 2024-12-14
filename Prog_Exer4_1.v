module BCD_to_9Comp(d, C, E);
	// I/O
	input [3:0]d;
	output [3:0]C;
	output E;
	wire w1;

	//C3
	nor U1(C[3], d[3], d[2], d[1]);
	//C2
	xor U2(C[2], d[2], d[1]);
	//C1
	buf U3(C[1], d[1]);
	//C0
	not U4(C[0], d[0]);
	//E
	or U5(w1, d[2], d[1]);
	and U6(E, w1, d[3]);
endmodule

module MUT_BCD_to_9Comp;
	reg [3:0]tb_d;
	wire [3:0]tb_C;
	wire tb_E;
	
	//module instantiation
	BCD_to_9Comp mut_bcd_to_9comp(tb_d, tb_C, tb_E);
	
	initial begin
		//initial input
		tb_d = 4'h0;
		$display("Truth table of BCD to 9's Complement Code Convert Circuit");
		$display("Time d[3:0] C[3:0] E");
		$monitor("%0d\t%b   %b  %b", $time, tb_d, tb_C, tb_E);
		//next inputs
		#5 tb_d = 4'h1;
		#5 tb_d = 4'h2;
		#5 tb_d = 4'h3;
		#5 tb_d = 4'h4;
		#5 tb_d = 4'h5;
		#5 tb_d = 4'h6;
		#5 tb_d = 4'h7;
		#5 tb_d = 4'h8;
		#5 tb_d = 4'h9;
		#5 tb_d = 4'ha;
		#5 tb_d = 4'hb;
		#5 tb_d = 4'hc;
		#5 tb_d = 4'hd;
		#5 tb_d = 4'he;
		#5 tb_d = 4'hf;
		#5 $finish;
	end
endmodule
