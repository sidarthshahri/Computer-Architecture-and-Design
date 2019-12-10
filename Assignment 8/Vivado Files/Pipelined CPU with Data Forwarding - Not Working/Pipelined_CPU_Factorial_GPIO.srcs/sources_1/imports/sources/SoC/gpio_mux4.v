`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2019 03:04:55 PM
// Design Name: 
// Module Name: gpio_mux4
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


module gpio_mux4(
        input   wire    [31:0]  gpI1,
        input   wire    [31:0]  gpI2,
        input   wire    [31:0]  gpO1,
        input   wire    [31:0]  gpO2,
        input   wire    [1:0]   RdSel,
        output  reg     [31:0]  RD
    );
    
    always @ (*) begin
        case (RdSel)
            2'b00: RD = gpI1;
            2'b01: RD = gpI2;
            2'b10: RD = gpO1;
            2'b11: RD = gpO2;
            default: RD = {31{1'bx}};
        endcase
    end
endmodule