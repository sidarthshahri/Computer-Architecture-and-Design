`timescale 1ns / 1ps

module CMP_GT(
    input [31:0] A, B,
    output reg GT
    );

always @ (A, B) begin
    if (B > A)
        GT = 1;
    else 
        GT = 0;
    end
endmodule