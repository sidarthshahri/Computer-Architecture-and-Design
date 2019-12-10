module auxdec (
        input  wire [1:0] alu_op,
        input  wire [5:0] funct,
        output wire [2:0] alu_ctrl,
        
        // New outputs
        output wire       pc_jr_sel,
        output wire       rf_mult_shift_wd_sel,
        output wire       mult_we,
        output wire       mult_hilo_sel,
        output wire       mult_shift_sel,
        output wire       sl_or_sr
    );

    reg [9:0] ctrl;

    assign {alu_ctrl, pc_jr_sel, rf_mult_shift_wd_sel, mult_we, mult_hilo_sel, mult_shift_sel, sl_or_sr} = ctrl;

    always @ (alu_op, funct) begin
        case (alu_op)
            2'b00: ctrl = 9'b010_0_0_0_0_0_0;          // ADD (LW or SW)
            2'b01: ctrl = 9'b110_0_0_0_0_0_0;          // SUB (BEQ)
            default: case (funct)
                9'b10_0100: ctrl = 9'b000_0_0_0_0_0_0; // AND
                9'b10_0101: ctrl = 9'b001_0_0_0_0_0_0; // OR
                9'b10_0000: ctrl = 9'b010_0_0_0_0_0_0; // ADD
                9'b10_0010: ctrl = 9'b110_0_0_0_0_0_0; // SUB
                9'b10_1010: ctrl = 9'b111_0_0_0_0_0_0; // SLT
                9'b01_1001: ctrl = 9'b000_0_0_1_0_0_0; // NEW: MULTU
                9'b01_0000: ctrl = 9'b000_0_1_0_0_0_0; // NEW: MFHI
                9'b01_0010: ctrl = 9'b000_0_1_0_1_0_0; // NEW: MFLO
                9'b00_1000: ctrl = 9'b000_1_0_0_0_0_0; // NEW: JR
                9'b00_0000: ctrl = 9'b000_0_1_0_0_1_0; // NEW: SLL
                9'b00_0010: ctrl = 9'b000_0_1_0_0_1_1; // NEW: SLR
                default:    ctrl = 9'bxxx_x;
            endcase
        endcase
    end

endmodule