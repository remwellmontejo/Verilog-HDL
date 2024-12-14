// module for 2-Bit Parallel Adder or Subtractor
module Bit2_Parallel_AoS(a, b, m, S, CoBo);
	input [2:1]a;
	input [2:1]b;
	input m;
	output [2:1]S;
	output CoBo;
	wire Co_1, xor_out_1, xor_out_2;

	xor U1(xor_out_1, b[1], m), U2(xor_out_2, b[2], m); //xor1 and xor2
	FA FA1(a[1], xor_out_1, m, S[1], Co_1); //FA1
	FA FA2(a[2], xor_out_2, Co_1, S[2], CoBo); //FA2


endmodule

// module for Full Adder
module FA(a, b, cin, S, Co);
	input a, b, cin;
	output S, Co;
	wire [2:0]w;
	
	HA HA1(a, b, w[0], w[1]); //HA1
	HA HA2(w[0], cin, S, w[2]); //HA2
	or  U1(Co, w[1], w[2]);
endmodule

// module for Half Adder
module HA(a, b, S, Co);
	input a, b;
	output S, Co;
	xor U1(S, a, b); 
	and U2(Co, a, b);
endmodule

//testbench
module MUT_Bit2_Parallel_AoS;
	reg [2:1]tb_a;
	reg [2:1]tb_b;
	reg tb_m;
	wire [2:1]tb_S;
	wire tb_CoBo;

	Bit2_Parallel_AoS bit2_parallel_aos_testbench(tb_a, tb_b, tb_m, tb_S, tb_CoBo);

	initial begin
		tb_m = 1'b0; tb_a = 2'b11; tb_b = 2'b01; 
		$display("Truth table of 2-bit Parallel Adder or Subtractor");
		$display("Time\tM a[2:1] b[2:1] CoBo S[2:1]");
		$monitor("%0d\t%b  %b     %b     %b    %b", $time, tb_m, tb_a, tb_b, tb_CoBo, tb_S);
		#5 tb_m = 1'b1; tb_a = 2'b11; tb_b = 2'b01; 
		#5 tb_m = 1'b1; tb_a = 2'b10; tb_b = 2'b11; 
		#5 tb_m = 1'b0; tb_a = 2'b10; tb_b = 2'b11; 
		#5 tb_m = 1'b0; tb_a = 2'b11; tb_b = 2'b11; 
		#5 $finish;
	end
endmodule

