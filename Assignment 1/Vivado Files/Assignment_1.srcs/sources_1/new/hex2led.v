`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/08/2019 07:43:21 PM
// Design Name: 
// Module Name: hex2led
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

module hex2led(number, s0, s1, s2, s3, s4, s5, s6);
    output s0, s1, s2, s3, s4, s5, s6;
    input [3:0] number;
    reg s0, s1, s2, s3, s4, s5, s6;

always @ (number)
begin // BCD to 7-segment decoding
    case (number) // s0 - s6 are active low
        4'h0: begin s0=0; s1=0; s2=0; s3=0; s4=0; s5=0; s6=1; end
        4'h1: begin s0=1; s1=0; s2=0; s3=1; s4=1; s5=1; s6=1; end
        4'h2: begin s0=0; s1=0; s2=1; s3=0; s4=0; s5=1; s6=0; end
        4'h3: begin s0=0; s1=0; s2=0; s3=0; s4=1; s5=1; s6=0; end
        4'h4: begin s0=1; s1=0; s2=0; s3=1; s4=1; s5=0; s6=0; end
        4'h5: begin s0=0; s1=1; s2=0; s3=0; s4=1; s5=0; s6=0; end
        4'h6: begin s0=0; s1=1; s2=0; s3=0; s4=0; s5=0; s6=0; end
        4'h7: begin s0=0; s1=0; s2=0; s3=1; s4=1; s5=1; s6=1; end
        4'h8: begin s0=0; s1=0; s2=0; s3=0; s4=0; s5=0; s6=0; end
        4'h9: begin s0=0; s1=0; s2=0; s3=1; s4=1; s5=0; s6=0; end
        4'ha: begin s0=0; s1=0; s2=0; s3=0; s4=0; s5=1; s6=0; end
        4'hb: begin s0=1; s1=1; s2=0; s3=0; s4=0; s5=0; s6=0; end
        4'hc: begin s0=1; s1=1; s2=1; s3=0; s4=0; s5=1; s6=0; end
        4'hd: begin s0=1; s1=0; s2=0; s3=0; s4=0; s5=1; s6=0; end
        4'he: begin s0=0; s1=0; s2=1; s3=0; s4=0; s5=0; s6=0; end
        4'hf: begin s0=0; s1=1; s2=1; s3=1; s4=0; s5=0; s6=0; end
        default: begin s0=1; s1=1; s2=1; s3=1; s4=1; s5=1; s6=1; end
    endcase
end
endmodule // end led
