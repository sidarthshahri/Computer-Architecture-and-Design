`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/02/2019 09:48:59 PM
// Design Name: 
// Module Name: shifter
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


module shifter # (parameter WIDTH = 32) (
        input   wire [4:0]       shamt,
        input   wire             sl_or_sr,
        input   wire [WIDTH-1:0] d,
        output  reg  [WIDTH-1:0] y
    );
    
    always @ (shamt, sl_or_sr, d) begin
        if  (sl_or_sr)  y = d >> shamt;
        else            y = d << shamt;
    end

endmodule
