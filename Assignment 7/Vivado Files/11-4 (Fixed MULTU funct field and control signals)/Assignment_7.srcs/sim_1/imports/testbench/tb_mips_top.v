module tb_mips_top;

    reg         clk;
    reg         rst;
    wire        we_dm;
    wire [31:0] pc_current;
    wire [31:0] instr;
    wire [31:0] alu_out;
    wire [31:0] wd_dm;
    wire [31:0] rd_dm;
    wire [31:0] reg_31;
    
    // Outputs for simulation
    wire [31:0] mult_result;
    wire [31:0] shift_result;
    wire       pc_jr_sel;
    wire       rf_mult_shift_wd_sel;
    wire       mult_we;
    wire       mult_hilo_sel;
    wire       mult_shift_sel;
    wire       sl_or_sr;
    wire       rf_wa_jal_sel;
    wire       rf_wd_jal_sel;
    
    integer i;
    
    mips_top DUT (
            .clk            (clk),
            .rst            (rst),
            .we_dm          (we_dm),
            .ra3            (5'd31),
            .pc_current     (pc_current),
            .instr          (instr),
            .alu_out        (alu_out),
            .wd_dm          (wd_dm),
            .rd_dm          (rd_dm),
            .rd3            (reg_31),
            
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
    
    task tick; 
    begin 
        clk = 1'b0; #5;
        clk = 1'b1; #5;
    end
    endtask

    task reset;
    begin 
        rst = 1'b0; #5;
        rst = 1'b1; #5;
        rst = 1'b0;
    end
    endtask
    
    initial begin
        reset;
        tick;
//        tick;
//        tick;
//        tick;
//        tick;
//        tick;
//        for(i = 0; i < 13; i = i + 1)
//        begin
//            tick;
//        end
//        reset;
        while(pc_current != 32'hc) tick;
//        tick;
        $finish;
    end

endmodule