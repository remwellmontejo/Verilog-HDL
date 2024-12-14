module Bit3GC_To_Octal7Seg(g, O);
	input [2:0]g;
	output [6:0]O;
	
	//inverts
	wire not_g2, not_g1, not_g0;
	nor U1(not_g2, g[2]), U2(not_g1, g[1]), U3(not_g0, g[0]);
	
	//O6
	wire [3:1]o6_wire;
	nor U4(o6_wire[1], g[1], g[0]), U5(o6_wire[2], g[2], not_g1), U6(o6_wire[3], not_g2, not_g0);
	nor U7(O[6], o6_wire[1], o6_wire[2], o6_wire[3]);

	//O5
	buf U8(O[5], o6_wire[3]);

	//O4
	wire o4_wire;
	nor U9(o4_wire, g[2], not_g1, not_g0);
	buf U10(O[4], o4_wire);

	//O3
	wire [2:1]o3_wire;
	nor U11(o3_wire[1], g[2], g[0]), U12(o3_wire[2], not_g1, not_g0);
	nor U13(O[3], o6_wire[3], o3_wire[1], o3_wire[2]);

	//O2
	wire [2:1]o2_wire;
	nor U14(o2_wire[1], g[2], g[1], g[0]), U15(o2_wire[2], not_g2, g[1], not_g0);
	nor U16(O[2], o2_wire[1], o2_wire[2], o4_wire);

	//O1
	wire o1_wire;
	nor U17(o1_wire, not_g2, not_g1);
	nor U18(O[1], o1_wire, o2_wire[1], o6_wire[3]);

	//O0
	nor U19(O[0], o6_wire[3], g[1]);
endmodule

module MUT_Bit3GC_To_Octal7Seg;
	reg [2:0]tb_g;
	wire [6:0]tb_O;
	
	//module instantiation
	Bit3GC_To_Octal7Seg mut_3bitgc_to_octal7seg(tb_g, tb_O);

	initial begin
		//initial input
		tb_g = 3'b000;
		$display("Truth table of 3-bit Gray Code to Octal 7 Segment Display Converter Circuit");
		$display("Time g[2:0]  O[6:0]");
		$monitor("%0d\t%b   %b", $time, tb_g, tb_O);
		//next inputs
		#5 tb_g = 3'b001;
		#5 tb_g = 3'b011;
		#5 tb_g = 3'b010;
		#5 tb_g = 3'b110;
		#5 tb_g = 3'b111;
		#5 tb_g = 3'b101;
		#5 tb_g = 3'b100;
		#5 $finish;
	end
endmodule
		
	
