`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2019 12:00:50 AM
// Design Name: 
// Module Name: FE_DE_Stage_Reg
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

module FE_DE_Stage_Reg(
        input   wire            clk, rst,
        input   wire    [31:0]  instrF,
        input   wire    [31:0]  pc_plus_4F,
        
        output  reg     [31:0]  instrD,
        output  reg     [31:0]  pc_plus_4D
    );
    
    always @ (posedge clk, posedge rst) begin
        if (rst) begin
            instrD      <= 0;
            pc_plus_4D  <= 0;
        end
        else begin
            instrD      <= instrF;
            pc_plus_4D  <= pc_plus_4F;
        end
    end
endmodule