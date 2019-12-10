`timescale 1ns / 1ps

module MUL(
    input [31:0] X, Y,
    output reg [31:0] Z
    );
    
always @ (X, Y) begin
    Z = X * Y;
end

endmodule
