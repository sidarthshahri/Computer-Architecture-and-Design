`timescale 1ns / 1ps

module CNT(
    input [3:0] D,
    input load_cnt, en, clk,
    output reg [31:0] Q
    );
    
always @ (posedge clk) begin
    if (en) begin
        if (load_cnt)
            Q <= D;
        else
            Q <= Q - 1;
    end else 
        Q <= Q;
end
    
endmodule


//// Testbench code
//module CNT_tb;

//reg [3:0] D;
//reg load_cnt, en, clk;
//wire [31:0] Q;

//initial begin 
//    clk = 0;
//    D = 4'b0000;
//    load_cnt = 1'b0;
//    en = 1'b0;
    
//    #5 load_cnt = 1'b1; en = 1'b1; D = 4'b0111;
//    #5 load_cnt = 1'b0; 
//    #60 en = 1'b0; $finish;
//end

//always begin
//    #5 clk = !clk;
//end

//CNT CNT_UT (
//.D(D),
//.load_cnt(load_cnt),
//.en(en),
//.clk(clk),
//.Q(Q)
//);

//endmodule