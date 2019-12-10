`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2019 03:38:41 PM
// Design Name: 
// Module Name: gpio_top
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


module gpio_top(
        input   wire    [1:0]   A,
        input   wire            WE,
        input   wire    [31:0]  gpI1, gpI2,
        input   wire    [31:0]  WD,
        input   wire            Rst, Clk,
        output          [31:0]  gpO1, gpO2, 
        output          [31:0]  RD
    );
    
    wire            WE1, WE2;
    wire    [1:0]   RdSel;
    
    gpio_ad gpio_ad (
        .A(A),
        .WE(WE),
        .WE1(WE1),
        .WE2(WE2),
        .RdSel(RdSel)
    );
    
    gpio_reg gpO1_reg (
        .D(WD),
        .Clk(Clk),
        .Rst(Rst),
        .Load_Reg(WE1),
        .Q(gpO1)
    );
    
    gpio_reg gpO2_reg (
        .D(WD),
        .Clk(Clk),
        .Rst(Rst),
        .Load_Reg(WE2),
        .Q(gpO2)
    );
    
    gpio_mux4 gpio_mux4(
        .gpI1(gpI1),
        .gpI2(gpI2),
        .gpO1(gpO1),
        .gpO2(gpO2),
        .RdSel(RdSel),
        .RD(RD)
    );
endmodule
