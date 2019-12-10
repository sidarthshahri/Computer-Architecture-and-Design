`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2019 03:04:55 PM
// Design Name: 
// Module Name: gpio_ad
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


module gpio_ad(
        input   wire    [3:2]   A,
        input   wire            WE,
        output  reg             WE1, WE2,
        output  wire    [1:0]   RdSel
    );
    
    always @ (*) begin
        case (A) 
            2'b00: begin
                WE1 = 1'b0;
                WE2 = 1'b0;
            end
            
            2'b01: begin
                WE1 = 1'b0;
                WE2 = 1'b0;
            end
            
            2'b10: begin
                WE1 = WE;
                WE2 = 1'b0;
            end
            
            2'b11: begin
                WE1 = 1'b0;
                WE2 = WE;
            end
            
            default: begin
                WE1 = 1'bx;
                WE2 = 1'bx;
            end
        endcase
    end
    
    assign RdSel = A;
    
endmodule