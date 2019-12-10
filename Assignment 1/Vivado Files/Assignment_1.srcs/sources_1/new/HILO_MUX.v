`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/08/2019 08:01:04 PM
// Design Name: 
// Module Name: HILO_MUX
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


module HILO_MUX(
    input wire [3:0] HI_dig3,
    input wire [3:0] HI_dig2,
    input wire [3:0] HI_dig1,
    input wire [3:0] HI_dig0,
    
    input wire [3:0] LO_dig3,
    input wire [3:0] LO_dig2,
    input wire [3:0] LO_dig1,
    input wire [3:0] LO_dig0,
    
    input wire HILO_sel,
    
    output wire [3:0] HW_dig3,
    output wire [3:0] HW_dig2,
    output wire [3:0] HW_dig1,
    output wire [3:0] HW_dig0
);

assign HW_dig3 = HILO_sel ? HI_dig3 : LO_dig3;
assign HW_dig2 = HILO_sel ? HI_dig2 : LO_dig2;
assign HW_dig1 = HILO_sel ? HI_dig1 : LO_dig1;
assign HW_dig0 = HILO_sel ? HI_dig0 : LO_dig0;
endmodule
