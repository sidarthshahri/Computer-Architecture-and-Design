module hex_to_7seg (
            input  wire [3:0] HEX,
            output reg  [7:0] s
        );

    always @ (HEX) begin
        case (HEX) 
               4'h0: s = 8'b11000000;
               4'h1: s = 8'b11111001;
               4'h2: s = 8'b10100100;
               4'h3: s = 8'b10110000;
               4'h4: s = 8'b10011001;
               4'h5: s = 8'b10010010;
               4'h6: s = 8'b10000010;
               4'h7: s = 8'b11111000;
               4'h8: s = 8'b10000000;
               4'h9: s = 8'b10010000;
               4'hA: s = 8'b10001000;
               4'hB: s = 8'b10000000;
               4'hC: s = 8'b11000110;
               4'hD: s = 8'b11000000;
               4'hE: s = 8'b10000110;
               4'hF: s = 8'b10001110;
            default: s = 8'b01111111;
       endcase
    end

endmodule