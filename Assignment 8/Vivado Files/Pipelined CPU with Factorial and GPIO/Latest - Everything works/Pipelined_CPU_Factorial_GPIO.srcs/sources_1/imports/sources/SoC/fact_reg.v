`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2019 01:23:07 PM
// Design Name: 
// Module Name: fact_reg
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


module fact_reg #(parameter w = 32) (
        input   wire            Clk, Rst,
        input   wire    [w-1:0] D,
        input   wire            Load_Reg,
        output  reg     [w-1:0] Q
    );
    
    always @ (posedge Clk, posedge Rst)
        if (Rst)
            Q <= 0;
        else if (Load_Reg)
            Q <= D;
        else 
            Q <= Q;
endmodule
