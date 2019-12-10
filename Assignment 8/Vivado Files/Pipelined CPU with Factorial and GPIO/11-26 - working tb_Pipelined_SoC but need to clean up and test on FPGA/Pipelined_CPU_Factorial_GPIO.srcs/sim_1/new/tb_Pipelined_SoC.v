`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/23/2019 03:33:56 AM
// Design Name: 
// Module Name: tb_Single_Cycle_SoC
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module tb_Pipelined_SoC;
    reg             clk;
    reg             rst;
    reg     [31:0]  gpI1, gpI2;
    reg     [4:0]   ra3;
    wire            we_dm;
    wire    [31:0]  pc_current;
    wire    [31:0]  instr;
    wire    [31:0]  alu_out;
    wire    [31:0]  wd_dm;
    wire    [31:0]  rd_dm;
    wire    [31:0]  gpO1, gpO2;
    wire    [31:0]  rd3;
    
    // Outputs for simulation
    wire    [31:0]  instrD, instrE, instrM, instrW;
    
    wire    [31:0]  rd1E, rd2E, sext_immE, alu_pb, alu_outE;
    
    wire    [31:0]  shift_resultM;
    wire    [31:0]  shift_resultE;
    wire    [31:0]  shift_resultW;
    
    wire    [31:0]  mult_shift_result;
    wire    [31:0]  wd_rfW;
    
    wire    [31:0] alu_outW, rd_dmW, rd1W, pc_plus_4W;
    wire    [4:0]  rf_waW;
    wire        mult_hilo_selW, dm2regW, rf_wd_jal_selW, mult_shift_selW, rf_mult_shift_wd_selW;
    
    Pipelined_SoC DUT1 (
        .clk            (clk),
        .rst            (rst),
        .ra3            (ra3),
        .gpI1           (gpI1),
        .gpI2           (gpI2),
        .we_dm          (we_dm),
        .pc_current     (pc_current),
        .instr          (instr),
        .alu_out        (alu_out),
        .wd_dm          (wd_dm),
        .rd_dm          (rd_dm),
        .rd3            (rd3),
        .gpO1           (gpO1),
        .gpO2           (gpO2),
        
        // Outputs for simulation
        .instrD         (instrD),
        .instrE         (instrE),
        .instrM         (instrM),
        .instrW         (instrW),

        .rd1E           (rd1E),            
        .rd2E           (rd2E),
        .sext_immE      (sext_immE),
        .alu_pb         (alu_pb),
        .alu_outE       (alu_outE),
        
        .shift_resultM  (shift_resultM),
        .shift_resultE  (shift_resultE),
        .shift_resultW  (shift_resultW),
        
        .mult_shift_result (mult_shift_result),
        .wd_rfW         (wd_rfW),
        
        .alu_outW       (alu_outW),
        .rd_dmW         (rd_dmW),
        .rd1W           (rd1W),
        .pc_plus_4W     (pc_plus_4W),
        .rf_waW         (rf_waW),
        .mult_hilo_selW (mult_hilo_selW), 
        .dm2regW        (dm2regW), 
        .rf_wd_jal_selW (rf_wd_jal_selW), 
        .mult_shift_selW    (mult_shift_selW), 
        .rf_mult_shift_wd_selW  (rf_mult_shift_wd_selW)
    );
    
    task tick; 
    begin 
        clk = 0; #5;
        clk = 1; #5;
    end
    endtask

    initial begin
        // SoC_ad is outputting RdSel = 01 when alu_out (A) is 0x900???
        gpI1 = 32'b10101;   // n = 5, sel = 0
        rst = 1'b0; #5;
        rst = 1'b1; #5;
        rst = 1'b0;
        ra3 = 13;           // prove a register value
        tick;
        
        gpI2 = gpO2;
        tick;
        
        while(pc_current != 32'h9c) tick;
//        tick;
        $finish;
    end
endmodule