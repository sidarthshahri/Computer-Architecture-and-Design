module controlunit (
        input  wire [5:0]  opcode,
        input  wire [5:0]  funct,
        output wire        branch,
        output wire        jump,
        output wire        reg_dst,
        output wire        we_reg,
        output wire        alu_src,
        output wire        we_dm,
        output wire        dm2reg,
        output wire [2:0]  alu_ctrl,
       
        // New outputs
        output wire        pc_jr_sel,
        output wire        rf_mult_shift_wd_sel,
        output wire        mult_we,
        output wire        mult_hilo_sel,
        output wire        mult_shift_sel,
        output wire        sl_or_sr,
        output wire        rf_wd_jal_sel,
        output wire        rf_wa_jal_sel
    );
    
    wire [1:0] alu_op;

    maindec md (
        .opcode         (opcode),
        .branch         (branch),
        .jump           (jump),
        .reg_dst        (reg_dst),
        .we_reg         (we_reg),
        .alu_src        (alu_src),
        .we_dm          (we_dm),
        .dm2reg         (dm2reg),
        .alu_op         (alu_op),
        .rf_wd_jal_sel  (rf_wd_jal_sel),
        .rf_wa_jal_sel  (rf_wa_jal_sel)
    );

    auxdec ad (
        .alu_op         (alu_op),
        .funct          (funct),
        .alu_ctrl       (alu_ctrl),
        .pc_jr_sel      (pc_jr_sel),
        .rf_mult_shift_wd_sel (rf_mult_shift_wd_sel),
        .mult_we        (mult_we),
        .mult_hilo_sel  (mult_hilo_sel),
        .mult_shift_sel (mult_shift_sel),
        .sl_or_sr       (sl_or_sr)
    );

endmodule