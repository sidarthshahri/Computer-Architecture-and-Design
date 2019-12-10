`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2019 03:05:23 PM
// Design Name: 
// Module Name: gpio_reg
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

// Used for gpO1 and gpO2
module gpio_reg #(parameter w = 32) (
        input   wire    [w-1:0] D,
        input   wire            Clk, Rst,
        input   wire            Load_Reg,
        output  reg     [w-1:0] Q
    );
    
    always @ (posedge Clk, posedge Rst) begin
        if (Rst)
            Q <= 0;
        else if (Load_Reg)
            Q <= D;
        else 
            Q <= Q;
    end
endmodule