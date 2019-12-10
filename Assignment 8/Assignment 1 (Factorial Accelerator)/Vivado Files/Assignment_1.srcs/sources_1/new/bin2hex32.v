`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/08/2019 07:41:43 PM
// Design Name: 
// Module Name: bin2hex32
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


module bin2hex32(
    input wire [31:0] value,
    output wire [3:0] dig0,
    output wire [3:0] dig1,
    output wire [3:0] dig2,
    output wire [3:0] dig3,
    output wire [3:0] dig4,
    output wire [3:0] dig5,
    output wire [3:0] dig6,
    output wire [3:0] dig7
);

    assign dig0 = value & 4'hFF;
    assign dig1 = value >> 4 & 4'hFF;
    assign dig2 = value >> 8 & 4'hFF;
    assign dig3 = value >> 12 & 4'hFF;
    assign dig4 = value >> 16 & 4'hFF;
    assign dig5 = value >> 20 & 4'hFF;
    assign dig6 = value >> 24 & 4'hFF;
    assign dig7 = value >> 28 & 4'hFF;
endmodule 
