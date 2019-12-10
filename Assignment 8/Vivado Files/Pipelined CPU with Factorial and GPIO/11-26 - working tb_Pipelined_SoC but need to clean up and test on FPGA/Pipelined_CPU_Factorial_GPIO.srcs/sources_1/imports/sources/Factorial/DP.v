`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/05/2019 05:22:15 PM
// Design Name: 
// Module Name: DP
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module DP(
    input [3:0] n, 
    input load_cnt,
    input en,
    input load_reg, 
    input sel1, 
    input sel2,  
    input clk,
    output Error, 
    output GT, 
    output [31:0] product///reg or wire
);
    
          
wire [31:0] mux1_out;
wire [31:0] reg_out;
wire [31:0] cnt_out;
wire [31:0] mult_out;

// instantiate the building blocks, within parenthesis is the wire or include same name
    CMP_ERROR U0(
        .A(4'b1100), 
        .B(n), 
        .ERROR(Error)
    );

    CMP_GT U1(
        .A(32'h00000001), 
        .B(cnt_out), 
        .GT(GT)
    );
    
    CNT U2(
        .D(n), 
        .load_cnt(load_cnt), 
        .en(en), 
        .clk(clk), 
        .Q(cnt_out)
    );
    
    MUL U3(
        .X(cnt_out), 
        .Y(reg_out),
        .Z(mult_out)
    );
    
    MUX M1(
        .input_0(1),
        .input_1(mult_out), 
        .select(sel1), 
        .out(mux1_out)
    );
    
    MUX M2(
        .input_0(0),
        .input_1(reg_out), 
        .select(sel2), 
        .out(product)
    );
    
    REG R1(
        .D(mux1_out),
        .Q(reg_out), 
        .clk(clk), 
        .load_reg(load_reg)
    );

endmodule //DP