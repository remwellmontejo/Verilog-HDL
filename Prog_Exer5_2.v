module MUX_2by1(s, i, Z);
	input s;
	input [1:0]i;
	output Z;
	wire [2:0]w;
	
	not U1(w[0], s);
	and U2(w[1], i[0], w[0]);
	and U3(w[2], i[1], s);
	or U4(Z, w[2], w[1]);
endmodule

module MUX_4by1(s, i, Z);
	input [1:0]s;
	input [3:0]i;
	output Z;
	wire [1:0]w;

	//1st level
	MUX_2by1 U5(s[0], i[1:0], w[0]); 
	MUX_2by1 U6(s[0], i[3:2], w[1]); 

	//2nd level
	MUX_2by1 U7(s[1], w[1:0], Z); 
endmodule

module MUX_16by1(s, i, Z);
	input [3:0]s;
	input [15:0]i;
	output Z;
	wire [3:0]w;

	//1st level
	MUX_4by1 U8(s[1:0], i[3:0], w[0]);
	MUX_4by1 U9(s[1:0], i[7:4], w[1]);
	MUX_4by1 U10(s[1:0], i[11:8], w[2]);
	MUX_4by1 U11(s[1:0], i[15:12], w[3]);

	//2nd level
	MUX_4by1 U12(s[3:2], w[3:0], Z);
endmodule

module MUT_MUX_16by1;
	reg [3:0]tb_s;
	reg [15:0]tb_i;
	wire tb_Z;

	MUX_16by1 mut_mux_16by1(tb_s, tb_i, tb_Z);

	initial begin
		//initial inputs
		tb_s = 0; tb_i = 16'b1011010001011000;

		$display("Truth table of 16:1 Multiplexer using 4:1 Multiplexers");
		$display("Time s[3:0]      i[15:0]         Z");
		$monitor("%0d\t%b   %b    %b",$time,tb_s, tb_i, tb_Z);
		//next inputs
		#2 tb_s = 1; tb_i = 16'b1011010001011000;
		#2 tb_s = 2; tb_i = 16'b1011010001011000;
		#2 tb_s = 3; tb_i = 16'b1011010001011000;
		#2 tb_s = 4; tb_i = 16'b1011010001011000;
		#2 tb_s = 5; tb_i = 16'b1011010001011000;
		#2 tb_s = 6; tb_i = 16'b1011010001011000;
		#2 tb_s = 7; tb_i = 16'b1011010001011000;
		#2 tb_s = 8; tb_i = 16'b1011010001011000;
		#2 tb_s = 9; tb_i = 16'b1011010001011000;
		#2 tb_s = 10; tb_i = 16'b1011010001011000;
		#2 tb_s = 11; tb_i = 16'b1011010001011000;
		#2 tb_s = 12; tb_i = 16'b1011010001011000;
		#2 tb_s = 13; tb_i = 16'b1011010001011000;
		#2 tb_s = 14; tb_i = 16'b1011010001011000;
		#2 tb_s = 15; tb_i = 16'b1011010001011000;
		#2 $finish;
	end
endmodule