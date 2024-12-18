module Prog_Exer8_1(a, b, ops, R);
    input [3:0]a;
    input [3:0]b;
    input [2:0]ops;
    output reg [4:0]R;
    
    always @(ops or a or b) begin
        case(ops) //signal selects
            0: R = a;
            1: R = a + b;
            2: R = a - b;
            3: R = a / b;
            4: R = a % b;
            5: R = a << 1;
            6: R = a >> 1;
            7: R = a > b;
        endcase
    end
endmodule

module MUT_Prog_Exer8_1;
    reg [3:0]tb_a;
    reg [3:0]tb_b;
    reg [2:0]tb_ops;
    wire [4:0]tb_R;
    
    Prog_Exer8_1 mut_Prog_Exer8_1(tb_a, tb_b, tb_ops, tb_R);
    
    initial begin
        tb_a = 4'b1110; tb_b = 4'b0111; tb_ops = 0;
        
        $display("Truth table of Program Exercise 8-1");
	$display("Time\ta[3:0] b[3:0] ops\t Result");
	$monitor("%0d\t %b   %b   %0d\t  %b", $time, tb_a, tb_b, tb_ops, tb_R);

        repeat(7) begin
            #2 tb_ops = 1 + tb_ops;
        end

        #2 $finish;
    end
    
endmodule
