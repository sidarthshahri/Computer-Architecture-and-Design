module mux2 #(parameter WIDTH = 8) (
        input  wire             sel,
        input  wire [WIDTH-1:0] a,
        input  wire [WIDTH-1:0] b, 
        output wire [WIDTH-1:0] y
    );

    assign y = (sel) ? b : a;

endmodule