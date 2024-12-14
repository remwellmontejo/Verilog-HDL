module Prog_Exer7_1(input x, y, z, output F);
	wire w;
	assign w = (~y & 0) | (y & ~z);
	assign F = (~x & w) | (x & ~z);
endmodule

module MUT_Prog_Exer7_1;
	wire tb_F;
	reg tb_x, tb_y, tb_z;

	Prog_Exer7_1 mut_prog_exer7_1(tb_x, tb_y, tb_z, tb_F);
	
	initial begin
		tb_x = 1'b0; tb_y = 1'b0; tb_z = 1'b0; 
		$display("Truth table of Program Exercise 7-1");
		$display("Time\tx y z  F");
		$monitor("%0d\t%b %b %b  %b", $time, tb_x, tb_y, tb_z, tb_F);
		#5 tb_x = 1'b0; tb_y = 1'b0; tb_z = 1'b1;
		#5 tb_x = 1'b0; tb_y = 1'b1; tb_z = 1'b0;
		#5 tb_x = 1'b0; tb_y = 1'b1; tb_z = 1'b1;
		#5 tb_x = 1'b1; tb_y = 1'b0; tb_z = 1'b0;
		#5 tb_x = 1'b1; tb_y = 1'b0; tb_z = 1'b1;
		#5 tb_x = 1'b1; tb_y = 1'b1; tb_z = 1'b0;
		#5 tb_x = 1'b1; tb_y = 1'b1; tb_z = 1'b1;
		#5 $finish;
	end
endmodule 