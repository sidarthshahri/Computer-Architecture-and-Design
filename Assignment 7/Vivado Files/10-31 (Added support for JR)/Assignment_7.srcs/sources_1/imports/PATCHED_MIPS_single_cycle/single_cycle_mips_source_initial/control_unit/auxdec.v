module auxdec (
        input  wire [1:0] alu_op,
        input  wire [5:0] funct,
        output wire [2:0] alu_ctrl,
        output wire       pc_jr_sel
    );

    reg [3:0] ctrl;

    assign {alu_ctrl, pc_jr_sel} = ctrl;

    always @ (alu_op, funct) begin
        case (alu_op)
            2'b00: ctrl = 3'b010_0;          // ADD
            2'b01: ctrl = 3'b110_0;          // SUB
            default: case (funct)
                6'b10_0100: ctrl = 3'b000_0; // AND
                6'b10_0101: ctrl = 3'b001_0; // OR
                6'b10_0000: ctrl = 3'b010_0; // ADD
                6'b10_0010: ctrl = 3'b110_0; // SUB
                6'b10_1010: ctrl = 3'b111_0; // SLT
                6'b00_1000: ctrl = 3'b000_1; // JR
                default:    ctrl = 3'bxxx;
            endcase
        endcase
    end

endmodule