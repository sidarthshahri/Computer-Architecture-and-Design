`timescale 1ns / 1ps

module fact_mux4(
        input   wire    [1:0]   RdSel,
        input   wire    [3:0]   n,
        input   wire            Go,
        input   wire            ResDone, ResErr,
        input   wire    [31:0]  Result,
        output  reg     [31:0]  RD
    );
    
    always @ (*) begin
        case (RdSel)
            2'b00:      RD = {{(32-4){1'b0}}, n};   // 32 - width of n; {1'b0} assigns all upper 28 bits = 0
            2'b01:      RD = {{31{1'b0}}, Go};
            2'b10:      RD = {{30{1'b0}}, ResErr, ResDone};
            2'b11:      RD = Result;
            default:    RD = {31{1'bx}};
        endcase
    end
endmodule
