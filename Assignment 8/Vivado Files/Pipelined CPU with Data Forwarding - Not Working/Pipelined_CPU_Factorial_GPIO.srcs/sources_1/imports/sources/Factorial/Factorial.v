`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2018 05:13:47 PM
// Design Name: 
// Module Name: main
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


module Factorial(
    input wire go, clk,
    input wire [3:0] n,
    output wire done, error,
    output wire [31:0] product
);

wire load_cnt, en, load_reg, sel1, sel2, DP_error, GT;

DP DP0(
    .n(n), 
    .load_cnt(load_cnt), 
    .en(en), 
    .load_reg(load_reg), 
    .sel1(sel1), 
    .sel2(sel2), 
    .clk(clk), 
    .Error(DP_error), 
    .GT(GT), 
    .product(product)
);

CU CU0(
    .go(go),
    .clk(clk),
    .GT(GT),
    .DP_error(DP_error),
    .load_cnt(load_cnt),
    .en(en),
    .load_reg(load_reg),
    .sel1(sel1),
    .sel2(sel2),
    .done(done),
    .CU_error(error)
);


endmodule
