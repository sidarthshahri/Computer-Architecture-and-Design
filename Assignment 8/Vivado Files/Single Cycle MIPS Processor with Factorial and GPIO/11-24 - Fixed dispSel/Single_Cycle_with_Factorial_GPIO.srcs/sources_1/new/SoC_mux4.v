`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/22/2019 06:45:15 AM
// Design Name: 
// Module Name: SoC_mux4
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


module SoC_mux4(
        input   wire    [31:0]  DMemData, FactData, GPIOData,
        input   wire    [1:0]   RdSel,
        output  reg     [31:0]  ReadData     
    );
    
    always @ (*) begin
        case (RdSel)
            2'b00: ReadData = DMemData;
            2'b01: ReadData = DMemData;
            2'b10: ReadData = FactData;
            2'b11: ReadData = GPIOData;
            default: ReadData = {31{1'bx}};
        endcase
    end
endmodule