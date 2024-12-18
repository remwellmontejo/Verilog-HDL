module Bit8_Mux_Using_2to1_and_4to1(i, s, Z);
	input [7:0]i;
	input [2:0]s;
	reg [3:0]w;
	output reg Z;

	always @(*) begin //1st level (4 2:1 mux)
		case (s[0])
			1'b0: begin
				w[0] = i[0];
				w[1] = i[2];
				w[2] = i[4];
				w[3] = i[6];
			end
			1'b1: begin
				w[0] = i[1];
				w[1] = i[3];
				w[2] = i[5];
				w[3] = i[7];
			end
		endcase
	end

	always @(*) begin //2nd level (1 4:1 mux)
		case ({s[2], s[1]})
			{1'b0, 1'b0}: Z = w[0];
			{1'b0, 1'b1}: Z = w[1];
			{1'b1, 1'b0}: Z = w[2];
			{1'b1, 1'b1}: Z = w[3];
		endcase
	end
endmodule

module MUT_Bit8_Mux_Using_2to1_and_4to1;
	reg [7:0]tb_i;
	reg [2:0]tb_s;
	wire tb_Z;

	Bit8_Mux_Using_2to1_and_4to1 mut_Bit8_Mux_Using_2to1_and_4to1(tb_i, tb_s, tb_Z);

	initial begin
		tb_i = 8'b11001100; tb_s = 0;
		$display("Truth table of Behavioral implementation of 8:1 Multiplexer using 2:1 and 4:1 multiplexers");
		$display("Time\t i[7:0]     s[2:0]   Z");
		$monitor("%0d\t%b     %b     %b", $time, tb_i, tb_s, tb_Z);	

		repeat (7) begin
			#2 tb_s = tb_s + 1;
		end

		#2 $finish;
	end
endmodule