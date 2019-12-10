`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/22/2019 06:33:54 AM
// Design Name: 
// Module Name: Single_Cycle_SoC
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


module Pipelined_SoC (
        input  wire        clk,
        input  wire        rst,
        input  wire [4:0]  ra3,
        input  wire [31:0] gpI1, gpI2,
        
        output wire        we_dm,
        output wire [31:0] pc_current,
        output wire [31:0] instr,
        output wire [31:0] alu_out,
        output wire [31:0] wd_dm,
        output wire [31:0] rd_dm,
        output wire [31:0] rd3,
        output wire [31:0] gpO1, gpO2,
        
        // Outputs for simulation
        output wire [31:0] instrD, instrE, instrM, instrW,
        
        output wire [31:0] rd1E, rd2E, sext_immE, alu_pb, alu_outE,
        
        output wire [31:0] shift_resultM, shift_resultE, shift_resultW,   
        
        output wire [31:0] mult_shift_result,
        output wire [31:0] wd_rfW,
        
        output wire [31:0] alu_outW, rd_dmW, rd1W, pc_plus_4W,
        output wire [4:0]  rf_waW,
        output wire        mult_hilo_selW, dm2regW, rf_wd_jal_selW, mult_shift_selW, rf_mult_shift_wd_selW
    );

    wire            WE1, WE2, WEM;
    wire    [1:0]   RdSel;
    wire    [31:0]  DMemData, FactData, GPIOData;

    mips mips (
            .clk            (clk),
            .rst            (rst),
            .ra3            (ra3),
            .instrF         (instr),
            .rd_dmM         (rd_dm),
            .we_dmM         (we_dm),
            .pc_current     (pc_current),
            .alu_outM       (alu_out),
            .rd2M           (wd_dm),
            .rd3            (rd3),
            
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

    imem imem (
            .a              (pc_current[7:2]),
            .y              (instr)
        );

    dmem dmem (
            .clk            (clk),
            .we             (WEM),
            .a              (alu_out[7:2]),
            .d              (wd_dm),
            .q              (DMemData),
            .rst            (rst)
        );
        
    SoC_ad SoC_ad (
            .WE             (we_dm),
            .A              (alu_out),
            .WE1            (WE1),
            .WE2            (WE2),
            .WEM            (WEM),
            .RdSel          (RdSel)
        );    
        
    SoC_mux4 SoC_mux4 (
            .DMemData       (DMemData),
            .FactData       (FactData),
            .GPIOData       (GPIOData),
            .RdSel          (RdSel),
            .ReadData       (rd_dm)
        );
        
    fact_top factorial_accelerator (
            .A              (alu_out[3:2]),
            .WE             (WE1),
            .WD             (wd_dm[3:0]),
            .Rst            (rst),
            .Clk            (clk),
            .RD             (FactData)
        );    
       
    gpio_top gpio_module (
            .A              (alu_out[3:2]),
            .WE             (WE2),
            .gpI1           (gpI1),
            .gpI2           (gpI2),
            .WD             (wd_dm),
            .Rst            (rst),
            .Clk            (clk),
            .gpO1           (gpO1),
            .gpO2           (gpO2),
            .RD             (GPIOData)
        );    
endmodule