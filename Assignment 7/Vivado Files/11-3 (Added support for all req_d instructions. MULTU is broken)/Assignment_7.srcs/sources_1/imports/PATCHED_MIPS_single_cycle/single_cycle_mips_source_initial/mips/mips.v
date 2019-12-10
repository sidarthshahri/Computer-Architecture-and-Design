module mips (
        input  wire        clk,
        input  wire        rst,
        input  wire [4:0]  ra3,
        input  wire [31:0] instr,
        input  wire [31:0] rd_dm,
        output wire        we_dm,
        output wire [31:0] pc_current,
        output wire [31:0] alu_out,
        output wire [31:0] wd_dm,
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
    
    wire       branch;
    wire       jump;
    wire       reg_dst;
    wire       we_reg;
    wire       alu_src;
    wire       dm2reg;
    wire [2:0] alu_ctrl;
    
    // New wires Moved all control signals to output of this module to see in waveforms. To remove, uncomment below and remove outputs from module definition
//    wire       pc_jr_sel;
//    wire       rf_mult_shift_wd_sel;
//    wire       mult_we;
//    wire       mult_hilo_sel;
//    wire       mult_shift_sel;
//    wire       sl_or_sr;
//    wire       rf_wa_jal_sel;
//    wire       rf_wd_jal_sel;

    datapath dp (
            .clk            (clk),
            .rst            (rst),
            .branch         (branch),
            .jump           (jump),
            .reg_dst        (reg_dst),
            .we_reg         (we_reg),
            .alu_src        (alu_src),
            .dm2reg         (dm2reg),
            .alu_ctrl       (alu_ctrl),
            .ra3            (ra3),
            .instr          (instr),
            .rd_dm          (rd_dm),
            .pc_current     (pc_current),
            .alu_out        (alu_out),
            .wd_dm          (wd_dm),
            .rd3            (rd3),
            .pc_jr_sel      (pc_jr_sel),            
            .rf_mult_shift_wd_sel (rf_mult_shift_wd_sel),
            .mult_we        (mult_we),
            .mult_hilo_sel  (mult_hilo_sel),
            .mult_shift_sel (mult_shift_sel),
            .sl_or_sr       (sl_or_sr),
            .rf_wa_jal_sel  (rf_wa_jal_sel),
            .rf_wd_jal_sel  (rf_wd_jal_sel),
            .mult_result    (mult_result),
            .shift_result   (shift_result)
        );

    controlunit cu (
            .opcode         (instr[31:26]),
            .funct          (instr[5:0]),
            .branch         (branch),
            .jump           (jump),
            .reg_dst        (reg_dst),
            .we_reg         (we_reg),
            .alu_src        (alu_src),
            .we_dm          (we_dm),
            .dm2reg         (dm2reg),
            .alu_ctrl       (alu_ctrl),
            .pc_jr_sel      (pc_jr_sel),
            .rf_mult_shift_wd_sel (rf_mult_shift_wd_sel),
            .mult_we        (mult_we),
            .mult_hilo_sel  (mult_hilo_sel),
            .mult_shift_sel (mult_shift_sel),
            .sl_or_sr       (sl_or_sr),
            .rf_wa_jal_sel  (rf_wa_jal_sel),
            .rf_wd_jal_sel  (rf_wd_jal_sel)
        );

endmodule