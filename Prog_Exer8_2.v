module AL_Dec_4to16_using_2to4_Behavioral(a, en, Y);

	input [3:0]a;
	input en; 
	output reg [15:0]Y;
	reg [3:0]w;

	always @(en or a[3] or a[2]) begin //2nd level (1 2:4 dec)
		if (~en)
			case ({a[3], a[2]})
				{1'b0, 1'b0}: w = 4'b1110;
				{1'b0, 1'b1}: w = 4'b1101;
				{1'b1, 1'b0}: w = 4'b1011;
				{1'b1, 1'b1}: w = 4'b0111;
				default: w = 4'b1111;
			endcase
		else w = 4'b1111;
	end

	always @(w or a[1] or a[0]) begin //1st level (4 2:4 dec)
		if (~w[0]) //1
			case({a[1], a[0]})
				{1'b0, 1'b0}: Y[3:0] = 4'b1110;
				{1'b0, 1'b1}: Y[3:0] = 4'b1101;
				{1'b1, 1'b0}: Y[3:0] = 4'b1011;
				{1'b1, 1'b1}: Y[3:0] = 4'b0111;
				default: Y[3:0] = 4'b1111;
			endcase
		else Y[3:0] = 4'b1111;
	
		if (~w[1]) //2
			case({a[1], a[0]})
				{1'b0, 1'b0}: Y[7:4] = 4'b1110;
				{1'b0, 1'b1}: Y[7:4] = 4'b1101;
				{1'b1, 1'b0}: Y[7:4] = 4'b1011;
				{1'b1, 1'b1}: Y[7:4] = 4'b0111;
				default: Y[7:4] = 4'b1111;
			endcase
		else Y[7:4] = 4'b1111;

		if (~w[2]) //3
			case({a[1], a[0]})
				{1'b0, 1'b0}: Y[11:8] = 4'b1110;
				{1'b0, 1'b1}: Y[11:8] = 4'b1101;
				{1'b1, 1'b0}: Y[11:8] = 4'b1011;
				{1'b1, 1'b1}: Y[11:8] = 4'b0111;
				default: Y[11:8] = 4'b1111;
			endcase
		else Y[11:8] = 4'b1111;

		if (~w[3]) //4
			case({a[1], a[0]})
				{1'b0, 1'b0}: Y[15:12] = 4'b1110;
				{1'b0, 1'b1}: Y[15:12] = 4'b1101;
				{1'b1, 1'b0}: Y[15:12] = 4'b1011;
				{1'b1, 1'b1}: Y[15:12] = 4'b0111;
				default: Y[15:12] = 4'b1111;
			endcase
		else Y[15:12] = 4'b1111;
	end
endmodule



module MUT_AL_Dec_4to16_using_2to4_Behavioral;
	reg [3:0]tb_a;
	reg tb_en; 
	wire [15:0]tb_Y;

	AL_Dec_4to16_using_2to4_Behavioral mut_AL_Dec_4to16_using_2to4_Behavioral(tb_a, tb_en, tb_Y);

	initial begin
		tb_a = 0; tb_en = 1; 
		$display("Truth table of Behavioral implementation of 4-to-16 Line Decoder using 2-4 Line Decoders");
		$display("Time\ta[3:0] en      Y[15:0]");
		$monitor("%0d\t %b  %b   %b", $time, tb_a, tb_en, tb_Y);
		
		repeat (15) begin
			#2 tb_a = tb_a + 1; 
		end

		#2 tb_a = 0; tb_en = 0; 

		repeat (15) begin
			#2 tb_a = tb_a + 1; 
		end

		#2 $finish;
	end
endmodule
