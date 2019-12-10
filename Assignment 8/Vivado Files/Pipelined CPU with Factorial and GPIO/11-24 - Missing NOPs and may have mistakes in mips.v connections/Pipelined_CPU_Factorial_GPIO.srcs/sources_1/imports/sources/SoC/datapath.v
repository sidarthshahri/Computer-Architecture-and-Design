module datapath (
        input  wire        clk,
        input  wire        rst,
        input  wire        branch,
        input  wire        jump,
        input  wire        reg_dst,
        input  wire        we_reg,
        input  wire        alu_src,
        input  wire        dm2reg,
        input  wire [2:0]  alu_ctrl,
        input  wire [4:0]  ra3,
        input  wire [31:0] instr,
        input  wire [31:0] rd_dm,
        
        // New inputs
        input wire        pc_jr_sel,
        input wire        rf_mult_shift_wd_sel,
        input wire        mult_we,
        input wire        mult_hilo_sel,
        input wire        mult_shift_sel,
        input wire        sl_or_sr,
        input wire        rf_wd_jal_sel,
        input wire        rf_wa_jal_sel,
        
        output wire [31:0] pc_current,
        output wire [31:0] alu_out,
        output wire [31:0] wd_dm,
        output wire [31:0] rd3
    );

    wire [4:0]  rf_wa;
    wire        pc_src;
    wire [31:0] pc_plus4;
    wire [31:0] pc_pre;
    wire [31:0] pc_next;
    wire [31:0] sext_imm;
    wire [31:0] ba;
    wire [31:0] bta;
    wire [31:0] jta;
    wire [31:0] alu_pa;
    wire [31:0] alu_pb;
    wire [31:0] wd_rf;
    wire        zero;
    
    // Newly added wires
    wire [31:0] pc_final;
    wire [63:0] mult_out;
    wire [31:0] mfhi;
    wire [31:0] mflo;
    wire [31:0] mult_result; 
    wire [31:0] shift_result; 
    wire [31:0] mult_shift_result;
    wire [31:0] rf_wd_jal_mux_out;
    wire [31:0] mux_alu_dm_out;
    wire [4:0]  rf_wa_mux_out;
    
    assign pc_src = branch & zero;
    assign ba = {sext_imm[29:0], 2'b00};
    assign jta = {pc_plus4[31:28], instr[25:0], 2'b00};
    
    // --- PC Logic --- //
    dreg pc_reg (
            .clk            (clk),
            .rst            (rst),
            .d              (pc_final),
            .q              (pc_current)
        );

    adder pc_plus_4 (
            .a              (pc_current),
            .b              (32'd4),
            .y              (pc_plus4)
        );

    adder pc_plus_br (
            .a              (pc_plus4),
            .b              (ba),
            .y              (bta)
        );

    mux2 #(32) pc_src_mux (
            .sel            (pc_src),
            .a              (pc_plus4),
            .b              (bta),
            .y              (pc_pre)
        );

    mux2 #(32) pc_jmp_mux (
            .sel            (jump),
            .a              (pc_pre),
            .b              (jta),
            .y              (pc_next)
        );

    // --- RF Logic --- //
    mux2 #(5) rf_wa_mux (
            .sel            (reg_dst),
            .a              (instr[20:16]),
            .b              (instr[15:11]),
            .y              (rf_wa_mux_out)
        );

    regfile rf (
            .clk            (clk),
            .we             (we_reg),
            .ra1            (instr[25:21]),
            .ra2            (instr[20:16]),
            .ra3            (ra3),
            .wa             (rf_wa),
            .wd             (wd_rf),
            .rd1            (alu_pa),
            .rd2            (wd_dm),
            .rd3            (rd3),
            .rst            (rst)
        );

    signext se (
            .a              (instr[15:0]),
            .y              (sext_imm)
        );

    // --- ALU Logic --- //
    mux2 #(32) alu_pb_mux (
            .sel            (alu_src),
            .a              (wd_dm),
            .b              (sext_imm),
            .y              (alu_pb)
        );

    alu alu (
            .op             (alu_ctrl),
            .a              (alu_pa),
            .b              (alu_pb),
            .zero           (zero),
            .y              (alu_out)
        );

    // --- MEM Logic --- //
    mux2 #(32) rf_wd_mux (
            .sel            (dm2reg),
            .a              (alu_out),
            .b              (rd_dm),
            .y              (mux_alu_dm_out)
        );
        
   // -- JR Logic --- //
   mux2 #(32) pc_jr_mux (
            .sel            (pc_jr_sel),
            .a              (pc_next),
            .b              (alu_pa),
            .y              (pc_final)
        );
   
   // -- MULTU, MFLO, MFHI Logic -- //
   mult multu (
            .a              (alu_pa),
            .b              (wd_dm),
            .y              (mult_out)
        );
        
   we_dreg #(32) hi (
            .d              (mult_out[63:32]),
            .q              (mfhi),
            .we             (mult_we),
            .clk            (clk)
        );

   we_dreg #(32) lo (
            .d              (mult_out[31:0]),
            .q              (mflo),
            .we             (mult_we),
            .clk            (clk)
        );
   
   mux2 #(32) mult_hilo_mux (
            .sel            (mult_hilo_sel),
            .a              (mfhi),
            .b              (mflo),
            .y              (mult_result)
        );
   
   // -- SLL, SLR Logic -- // 
   shifter #(32) sll_slr_shifter (
            .sl_or_sr       (sl_or_sr),
            .shamt          (instr[10:6]),
            .d              (wd_dm),
            .y              (shift_result)
        );
   
   // -- MULTU or SHIFT MUX -- // 
   mux2 #(32) mult_shift_mux (
            .sel            (mult_shift_sel),
            .a              (mult_result),
            .b              (shift_result),
            .y              (mult_shift_result)
        );
    
   mux2 #(32) rf_mult_shift_wd_mux (
            .sel            (rf_mult_shift_wd_sel),
            .a              (rf_wd_jal_mux_out),
            .b              (mult_shift_result),
            .y              (wd_rf)
        );
        
   // -- JAL Logic -- //
   mux2 #(32) rf_wd_jal_mux (
            .sel            (rf_wd_jal_sel),
            .a              (mux_alu_dm_out),
            .b              (pc_plus4),
            .y              (rf_wd_jal_mux_out)
        );
   
   mux2 #(5) rf_wa_jal_mux (
            .sel            (rf_wa_jal_sel),
            .a              (rf_wa_mux_out),
            .b              (5'd31),
            .y              (rf_wa)
        );   
        

endmodule