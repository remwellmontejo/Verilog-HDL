//module description of program exercise 2
module Prog_Exer1_2(input x3, x2, x1, output G3, G2, G1);
	
	supply0 gnd;

	xor U1(G3, gnd, x3), U2(G2, x3, x2), U3(G1, x2, x1);

endmodule

//test bench module of program exercise 2
module MUT_Prog_Exer1_2;
	
	reg tb_x1, tb_x2, tb_x3;
	wire tb_G1, tb_G2, tb_G3;
	//instantiation of the module
	Prog_Exer1_2 mut_prog_exer1_2(tb_x3, tb_x2, tb_x1, tb_G3, tb_G2, tb_G1);
	//test input values
	initial begin
		//initial input signals
		tb_x3=1'b0; tb_x2=1'b0; tb_x1=1'b0; 
		$display("Simulating output for Program Exercise 1-2");
		$display("Tsim\tx3 x2 x1\tG3 G2 G1");
		$monitor("%0d\t%b %b %b\t%b %b %b",$time, tb_x3, tb_x2, tb_x1, tb_G3, tb_G2, tb_G1);
		#2 tb_x3=1'b0; tb_x2=1'b0; tb_x1=1'b1; 
		#2 tb_x3=1'b0; tb_x2=1'b1; tb_x1=1'b0; 
		#2 tb_x3=1'b0; tb_x2=1'b1; tb_x1=1'b1; 
		#2 tb_x3=1'b1; tb_x2=1'b0; tb_x1=1'b0; 
		#2 tb_x3=1'b1; tb_x2=1'b0; tb_x1=1'b1; 
		#2 tb_x3=1'b1; tb_x2=1'b1; tb_x1=1'b0; 
		#2 tb_x3=1'b1; tb_x2=1'b1; tb_x1=1'b1;
		#2 $finish; 
	end
endmodule


