`timescale 1ns / 1ps

module CMP_ERROR(
    input [3:0] A, B,
    output reg ERROR
    );

always @ (A, B) begin
    if (B > A)
        ERROR = 1;
    else 
        ERROR = 0;
    end
endmodule
