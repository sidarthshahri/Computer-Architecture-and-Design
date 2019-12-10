`timescale 1ns / 1ps

module MUX(
    input [31:0] input_0, input_1,
    input select,
    output reg [31:0] out
);
    
always @ (input_0, input_1, select)
begin
    if (select)
        out = input_1;
    else
        out = input_0;
end
endmodule
