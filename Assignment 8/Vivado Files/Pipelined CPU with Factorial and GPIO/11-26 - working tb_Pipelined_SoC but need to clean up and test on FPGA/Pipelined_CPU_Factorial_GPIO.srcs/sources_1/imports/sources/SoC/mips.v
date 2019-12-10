module mips (
        input  wire        clk,
        input  wire        rst,
        input  wire [4:0]  ra3,         
        input  wire [31:0] instrF,      // Instruction
        input  wire [31:0] rd_dmM,      // RD
        
        output wire        we_dmM,      // MemWrite
        output wire [31:0] pc_current,  // PC
        output wire [31:0] alu_outM,    // Address
        output wire [31:0] rd2M,        // WD
        output wire [31:0] rd3,
        
        // Outputs for simulation. To remove, remove from here, uncomment from wire declaration below, module instatiation in Pipelined_SoC.v and tb_Pipelined_SoC.v
        output wire [31:0] instrD, instrE, instrM, instrW,
        
        output wire [31:0] rd1E, rd2E, sext_immE, alu_pb, alu_outE,
        
        output wire [31:0] shift_resultM, shift_resultE, shift_resultW,  
        
        output wire [31:0] mult_shift_result,
        output wire [31:0] wd_rfW,
        
        output wire [31:0] alu_outW, rd_dmW, rd1W, pc_plus_4W,
        output wire [4:0]  rf_waW,
        output wire        mult_hilo_selW, dm2regW, rf_wd_jal_selW, mult_shift_selW, rf_mult_shift_wd_selW
    );
    
    // Fetch Stage
        // Datapath Wires
        wire    [31:0]  pc_final;
        wire    [31:0]  pc_next;
        wire    [31:0]  pc_pre;
        wire    [31:0]  pc_plus_4F;
        wire    [31:0]  jta;

    // Decode Stage 
        // Datapath Wires
 //       wire    [31:0]  instrD;
        wire    [31:0]  pc_plus_4D;
        wire    [31:0]  sext_immD;
        wire    [31:0]  rd1D;
        wire    [31:0]  rd2D;
        wire    [4:0]   rf_wa_mux_out;
        wire    [4:0]   rf_waD;
        
        // Control Signals
        wire            branchD;
        wire            jumpD;
        wire            reg_dstD;
        wire            we_regD;
        wire            alu_srcD;
        wire            we_dmD;
        wire            dm2regD;
        wire            rf_wd_jal_selD;
        wire            rf_wa_jal_selD;
        wire    [2:0]   alu_ctrlD;
        wire            mult_weD;
        wire            rf_mult_shift_wd_selD;
        wire            sl_or_srD;
        wire            mult_shift_selD;
        wire            pc_jr_selD;
        wire            mult_hilo_selD;
    
    // Execute Stage 
        // Datapath Wires
//        wire    [31:0]  rd1E;
//        wire    [31:0]  rd2E;
//        wire    [31:0]  sext_immE;
        wire    [4:0]   rf_waE;
        wire    [31:0]  pc_plus_4E;
        wire    [31:0]  ba;
//        wire    [31:0]  instrE;
        wire            zero;
        wire            pc_srcE;
//        wire    [31:0]  alu_outE;
//        wire    [31:0]  alu_pb;
        wire    [63:0]  mult_outE;
        wire    [31:0]  btaE;
//        wire    [31:0]  shift_resultE;
        
        // Control Signals
        wire            branchE;
        wire            jumpE;
        wire            we_regE;
        wire            alu_srcE;
        wire            we_dmE;
        wire            dm2regE;
        wire            rf_wd_jal_selE;
        wire     [2:0]  alu_ctrlE;
        wire            mult_weE;
        wire            rf_mult_shift_wd_selE;
        wire            sl_or_srE;
        wire            mult_shift_selE;
        wire            pc_jr_selE;
        wire            mult_hilo_selE;     
    
    // Memory Stage 
        // Datapath Wires
        wire            pc_srcM;
//        wire    [31:0]  alu_outM;     // Output of MIPS to DM
//        wire    [31:0]  rd2M;         // Output of MIPS to DM
        wire    [31:0]  rd1M;
        wire    [63:0]  mult_outM;
        wire    [4:0]   rf_waM;
        wire    [31:0]  pc_plus_4M;
        wire    [31:0]  btaM;
//        wire    [31:0]  shift_resultM;    // commented out for simulation output 
//        wire    [31:0]  instrM;
        wire    [31:0]  mfhiM;
        wire    [31:0]  mfloM;
        
        
        // Control Signals
        wire            jumpM;
        wire            we_regM;
//        wire            we_dmM;       // Output of MIPS to DM
        wire            dm2regM;
        wire            rf_wd_jal_selM;
        wire            mult_weM;
        wire            rf_mult_shift_wd_selM;
        wire            mult_shift_selM;
        wire            pc_jr_selM;
        wire            mult_hilo_selM;
    
    // Writeback Stage
        // Datapath Wires 
//        wire    [31:0]  alu_outW;
//        wire    [31:0]  rd_dmW;
//        wire    [31:0]  rd1W;
        wire    [31:0]  mfhiW;
        wire    [31:0]  mfloW;
//        wire    [4:0]   rf_waW;
//        wire    [31:0]  pc_plus_4W;
 //       wire    [31:0]  shift_resultW;
 //       wire    [31:0]  instrW;
        wire    [31:0]  mult_result;
        wire    [31:0]  mux_alu_dm_out;
        wire    [31:0]  rf_wd_jal_mux_out;
//        wire    [31:0]  mult_shift_result;
//        wire    [31:0]  wd_rfW;
        
        // Control Signals
        wire            jumpW;
        wire            we_regW;
//        wire            dm2regW;
//        wire            rf_wd_jal_selW;
//        wire            rf_mult_shift_wd_selW;
//        wire            mult_shift_selW;
        wire            pc_jr_selW;
//        wire            mult_hilo_selW;

     // Modules and connections
/////// Fetch
        assign jta = {pc_plus_4F[31:28], instrW[25:0], 2'b00};
        
        dreg pc_reg (
                .clk            (clk),
                .rst            (rst),
                .d              (pc_final),
                .q              (pc_current)
            );
        
        mux2 #(32) pc_jr_mux (
                .sel            (pc_jr_selW),
                .a              (pc_next),
                .b              (rd1W),
                .y              (pc_final)
            );

        mux2 #(32) pc_jmp_mux (
                .sel            (jumpW),
                .a              (pc_pre),
                .b              (jta),
                .y              (pc_next)
            );
            
        mux2 #(32) pc_src_mux (
                .sel            (pc_srcM),
                .a              (pc_plus_4F),
                .b              (btaM),
                .y              (pc_pre)
            );
 
        adder pc_plus_4 (
                .a              (pc_current),
                .b              (32'd4),
                .y              (pc_plus_4F)
            );
        
        FE_DE_Stage_Reg FE_DE_Stage_Reg (
                .clk            (clk),
                .rst            (rst),
                .instrF         (instrF),
                .pc_plus_4F     (pc_plus_4F),
                .instrD         (instrD),
                .pc_plus_4D     (pc_plus_4D)
            );
                   
/////// Decode
        controlunit cu (
                .opcode             (instrD[31:26]),
                .funct              (instrD[5:0]),
                .branch             (branchD),
                .jump               (jumpD),
                .reg_dst            (reg_dstD),
                .we_reg             (we_regD),
                .alu_src            (alu_srcD),
                .we_dm              (we_dmD),
                .dm2reg             (dm2regD),
                .alu_ctrl           (alu_ctrlD),
                .pc_jr_sel          (pc_jr_selD),
                .rf_mult_shift_wd_sel (rf_mult_shift_wd_selD),
                .mult_we            (mult_weD),
                .mult_hilo_sel      (mult_hilo_selD),
                .mult_shift_sel     (mult_shift_selD),
                .sl_or_sr           (sl_or_srD),
                .rf_wa_jal_sel      (rf_wa_jal_selD),
                .rf_wd_jal_sel      (rf_wd_jal_selD)
            );
            
        regfile rf (
                .clk            (clk),
                .we             (we_regW),
                .ra1            (instrD[25:21]),
                .ra2            (instrD[20:16]),
                .ra3            (ra3),
                .wa             (rf_waW),
                .wd             (wd_rfW),
                .rd1            (rd1D),
                .rd2            (rd2D),
                .rd3            (rd3),
                .rst            (rst)
            );       
            
        mux2 #(5) rf_wa_mux (
                .sel            (reg_dstD),
                .a              (instrD[20:16]),
                .b              (instrD[15:11]),
                .y              (rf_wa_mux_out)
            );            

        mux2 #(5) rf_wa_jal_mux (
                .sel            (rf_wa_jal_selD),
                .a              (rf_wa_mux_out),
                .b              (5'd31),
                .y              (rf_waD)
            );  
            
        signext se (
                .a              (instrD[15:0]),
                .y              (sext_immD)
            );
            
        DE_EX_State_Reg DE_EX_State_Reg ( 
                // Datapath
                .clk            (clk),
                .rst            (rst),
                .rd1D           (rd1D),
                .rd2D           (rd2D),
                .sext_immD      (sext_immD),
                .rf_waD         (rf_waD),
                .pc_plus_4D     (pc_plus_4D),
                .instrD         (instrD),
                .rd1E           (rd1E),
                .rd2E           (rd2E),
                .sext_immE      (sext_immE),
                .rf_waE         (rf_waE),
                .pc_plus_4E     (pc_plus_4E),
                .instrE         (instrE),
                
                // Control Signals
                .branchD        (branchD),
                .jumpD          (jumpD),
                .we_regD        (we_regD),
                .alu_srcD       (alu_srcD),
                .we_dmD         (we_dmD),
                .dm2regD        (dm2regD),
                .rf_wd_jal_selD (rf_wd_jal_selD),
                .alu_ctrlD      (alu_ctrlD),
                .mult_weD       (mult_weD),
                .rf_mult_shift_wd_selD  (rf_mult_shift_wd_selD),
                .sl_or_srD      (sl_or_srD),
                .mult_shift_selD    (mult_shift_selD),
                .pc_jr_selD     (pc_jr_selD),
                .mult_hilo_selD (mult_hilo_selD),
                .branchE        (branchE),
                .jumpE          (jumpE),
                .we_regE        (we_regE),
                .alu_srcE       (alu_srcE),
                .we_dmE         (we_dmE),
                .dm2regE        (dm2regE),
                .rf_wd_jal_selE (rf_wd_jal_selE),
                .alu_ctrlE      (alu_ctrlE),
                .mult_weE       (mult_weE),
                .rf_mult_shift_wd_selE  (rf_mult_shift_wd_selE),
                .sl_or_srE      (sl_or_srE),
                .mult_shift_selE    (mult_shift_selE),
                .pc_jr_selE     (pc_jr_selE),
                .mult_hilo_selE (mult_hilo_selE)
            );    
        
/////// Execute
        assign pc_srcE = branchE & zero;
        assign ba = {sext_immE[29:0], 2'b00};
        
        mux2 #(32) alu_pb_mux (
                .sel            (alu_srcE),
                .a              (rd2E),
                .b              (sext_immE),
                .y              (alu_pb)
            );
    
        alu alu (
                .op             (alu_ctrlE),
                .a              (rd1E),
                .b              (alu_pb),
                .zero           (zero),
                .y              (alu_outE)
            );        

        mult multu (
                .a              (rd1E),
                .b              (rd2E),
                .y              (mult_outE)
            );        
        
        adder pc_plus_br (
                .a              (pc_plus_4E),
                .b              (ba),
                .y              (btaE)
            );
            
        shifter #(32) sll_slr_shifter (
                .sl_or_sr       (sl_or_srE),
                .shamt          (instrE[10:6]),
                .d              (rd2E),
                .y              (shift_resultE)
            );
            
        EX_MEM_State_Reg EX_MEM_State_Reg( 
                .clk            (clk),
                .rst            (rst),
                .pc_srcE        (pc_srcE),
                .alu_outE       (alu_outE),
                .rd1E           (rd1E),
                .rd2E           (rd2E),
                .mult_outE      (mult_outE),
                .rf_waE         (rf_waE),
                .pc_plus_4E     (pc_plus_4E),
                .btaE           (btaE),
                .shift_resultE  (shift_resultE),
                .instrE         (instrE),
                .pc_srcM        (pc_srcM),
                .alu_outM       (alu_outM),
                .rd1M           (rd1M),
                .rd2M           (rd2M),
                .mult_outM      (mult_outM),
                .rf_waM         (rf_waM),
                .pc_plus_4M     (pc_plus_4M),
                .btaM           (btaM),
                .shift_resultM  (shift_resultM),
                .instrM         (instrM),
                
                // Control Signals 
                .jumpE          (jumpE),
                .we_regE        (we_regE),
                .we_dmE         (we_dmE),
                .dm2regE        (dm2regE),
                .rf_wd_jal_selE (rf_wd_jal_selE),
                .mult_weE       (mult_weE),
                .rf_mult_shift_wd_selE  (rf_mult_shift_wd_selE),
                .mult_shift_selE    (mult_shift_selE),
                .pc_jr_selE     (pc_jr_selE),
                .mult_hilo_selE (mult_hilo_selE),
                .jumpM          (jumpM),
                .we_regM        (we_regM),
                .we_dmM         (we_dmM),
                .dm2regM        (dm2regM),
                .rf_wd_jal_selM (rf_wd_jal_selM),
                .mult_weM       (mult_weM),    
                .rf_mult_shift_wd_selM (rf_mult_shift_wd_selM),
                .mult_shift_selM    (mult_shift_selM),
                .pc_jr_selM     (pc_jr_selM),
                .mult_hilo_selM (mult_hilo_selM) 
            );            
                 
/////// Memory
        we_dreg #(32) hi (
                .d              (mult_outM[63:32]),
                .q              (mfhiM),
                .we             (mult_weM),
                .clk            (clk)
            );
    
        we_dreg #(32) lo (
                .d              (mult_outM[31:0]),
                .q              (mfloM),
                .we             (mult_weM),
                .clk            (clk)
            ); 
            
        MEM_WB_State_Reg MEM_WB_State_Reg (
                // Datapath
                .clk            (clk), 
                .rst            (rst),
                .alu_outM       (alu_outM),
                .rd_dmM         (rd_dmM),
                .rd1M           (rd1M),
                .mfhiM          (mfhiM),
                .mfloM          (mfloM),
                .rf_waM         (rf_waM),
                .pc_plus_4M     (pc_plus_4M),
                .shift_resultM  (shift_resultM),
                .instrM         (instrM),
                .alu_outW       (alu_outW),
                .rd_dmW         (rd_dmW),
                .rd1W           (rd1W),
                .mfhiW          (mfhiW),
                .mfloW          (mfloW),
                .rf_waW         (rf_waW),    
                .pc_plus_4W     (pc_plus_4W),
                .shift_resultW  (shift_resultW),
                .instrW         (instrW),
                
                // Control Signals 
                .jumpM          (jumpM),
                .we_regM        (we_regM),
                .dm2regM        (dm2regM),
                .rf_wd_jal_selM (rf_wd_jal_selM),
                .rf_mult_shift_wd_selM  (rf_mult_shift_wd_selM),
                .mult_shift_selM    (mult_shift_selM),
                .pc_jr_selM     (pc_jr_selM),
                .mult_hilo_selM (mult_hilo_selM),
                .jumpW          (jumpW),
                .we_regW        (we_regW),
                .dm2regW        (dm2regW),
                .rf_wd_jal_selW (rf_wd_jal_selW),
                .rf_mult_shift_wd_selW  (rf_mult_shift_wd_selW),
                .mult_shift_selW(mult_shift_selW),
                .pc_jr_selW     (pc_jr_selW),
                .mult_hilo_selW (mult_hilo_selW)
            );
        
/////// Writeback
        mux2 #(32) mult_hilo_mux (
                .sel            (mult_hilo_selW),
                .a              (mfhiW),
                .b              (mfloW),
                .y              (mult_result)
            );
        
        mux2 #(32) rf_wd_mux (
                .sel            (dm2regW),
                .a              (alu_outW),
                .b              (rd_dmW),
                .y              (mux_alu_dm_out)
            );
       
        mux2 #(32) mult_shift_mux (
                .sel            (mult_shift_selW),
                .a              (mult_result),
                .b              (shift_resultW),
                .y              (mult_shift_result)
            );
        
        mux2 #(32) rf_mult_shift_wd_mux (
                .sel            (rf_mult_shift_wd_selW),
                .a              (rf_wd_jal_mux_out),
                .b              (mult_shift_result),
                .y              (wd_rfW)
            );
            
        mux2 #(32) rf_wd_jal_mux (
                .sel            (rf_wd_jal_selW),
                .a              (mux_alu_dm_out),
                .b              (pc_plus_4W),
                .y              (rf_wd_jal_mux_out)
            );    
endmodule