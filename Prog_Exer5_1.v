module DEC_2by4_AL_with_E(a, e, Y);
	input [1:0]a;
	input e;
	output [3:0]Y;

	//inverts
	wire [1:0]not_a;
	not U1(not_a[1], a[1]), U2(not_a[0], a[0]);

	//Y[0]
	or U3(Y[0], a[1], a[0], e);

	//Y[1]
	or U4(Y[1], a[1], not_a[0], e);

	//Y[2]
	or U5(Y[2], not_a[1], a[0], e);

	//Y[3]
	or U6(Y[3], not_a[1], not_a[0], e);
endmodule

module DEC_4by16_AL_with_E(a, Y);
	input [3:0]a;
	output [15:0]Y;
	supply0 L;

	//2nd level
	wire [3:0]w;
	DEC_2by4_AL_with_E U7(a[3:2], L, w);

	//1st level
	DEC_2by4_AL_with_E U8(a[1:0], w[0], Y[3:0]);
	DEC_2by4_AL_with_E U9(a[1:0], w[1], Y[7:4]);
	DEC_2by4_AL_with_E U10(a[1:0], w[2], Y[11:8]);
	DEC_2by4_AL_with_E U11(a[1:0], w[3], Y[15:12]);
endmodule

module MUT_DEC_4by16_AL_with_E;
	reg [3:0]tb_a;
	wire [15:0]tb_Y;
	
	//module instantiation
	DEC_4by16_AL_with_E mut_dec_4by16_al_with_e(tb_a, tb_Y);

	initial begin
		//initial inputs
		tb_a = 0;

		$display("Truth table of 4:16 Decoder using 2:4 Decoders");
		$display("Time a[3:0]      Y[15:0]");
		$monitor("%0d\t%b   %b",$time,tb_a, tb_Y);
		//next inputs
		#2 tb_a = 1;
		#2 tb_a = 2; 
		#2 tb_a = 3;
		#2 tb_a = 4;
		#2 tb_a = 5;
		#2 tb_a = 6;
		#2 tb_a = 7; 
		#2 tb_a = 8; 
		#2 tb_a = 9;
		#2 tb_a = 10;
		#2 tb_a = 11; 
		#2 tb_a = 12;
		#2 tb_a = 13;
		#2 tb_a = 14;
		#2 tb_a = 15;
		#2 $finish;
	end
endmodule