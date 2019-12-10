module mips_top (
        input  wire        clk,
        input  wire        rst,
        input  wire [4:0]  ra3,
        output wire        we_dm,
        output wire [31:0] pc_current,
        output wire [31:0] instr,
        output wire [31:0] alu_out,
        output wire [31:0] wd_dm,
        output wire [31:0] rd_dm,
        output wire [31:0] rd3,
        
        // Outputs for simulation
        output wire [31:0] mult_result,
        output wire [31:0] shift_result,
        output wire       pc_jr_sel,
        output wire       rf_mult_shift_wd_sel,
        output wire       mult_we,
        output wire       mult_hilo_sel,
        output wire       mult_shift_sel,
        output wire       sl_or_sr,
        output wire       rf_wa_jal_sel,
        output wire       rf_wd_jal_sel
    );

    wire [31:0] DONT_USE;

    mips mips (
            .clk            (clk),
            .rst            (rst),
            .ra3            (ra3),
            .instr          (instr),
            .rd_dm          (rd_dm),
            .we_dm          (we_dm),
            .pc_current     (pc_current),
            .alu_out        (alu_out),
            .wd_dm          (wd_dm),
            .rd3            (rd3),
            
            // For simulation
            .mult_result    (mult_result),
            .shift_result   (shift_result),
            .pc_jr_sel      (pc_jr_sel),
            .rf_mult_shift_wd_sel (rf_mult_shift_wd_sel),
            .mult_we        (mult_we),
            .mult_hilo_sel  (mult_hilo_sel),
            .mult_shift_sel (mult_shift_sel),
            .sl_or_sr       (sl_or_sr),
            .rf_wa_jal_sel  (rf_wa_jal_sel),
            .rf_wd_jal_sel  (rf_wd_jal_sel)
        );

    imem imem (
            .a              (pc_current[7:2]),
            .y              (instr)
        );

    dmem dmem (
            .clk            (clk),
            .we             (we_dm),
            .a              (alu_out[7:2]),
            .d              (wd_dm),
            .q              (rd_dm),
            .rst            (rst)
        );

endmodule