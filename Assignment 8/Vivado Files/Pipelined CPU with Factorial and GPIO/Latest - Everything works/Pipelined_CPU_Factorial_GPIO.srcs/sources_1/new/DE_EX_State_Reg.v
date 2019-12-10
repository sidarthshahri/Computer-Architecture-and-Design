`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2019 12:00:50 AM
// Design Name: 
// Module Name: DE_EX_State_Reg
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


module DE_EX_State_Reg(
        // Datapath 
        input   wire            clk, rst,
        input   wire    [31:0]  rd1D,
        input   wire    [31:0]  rd2D,
        input   wire    [31:0]  sext_immD,
        input   wire    [4:0]   rf_waD,
        input   wire    [31:0]  pc_plus_4D,
        input   wire    [31:0]  instrD,
        
        output  reg     [31:0]  rd1E,
        output  reg     [31:0]  rd2E,
        output  reg     [31:0]  sext_immE,
        output  reg     [4:0]   rf_waE,
        output  reg     [31:0]  pc_plus_4E,
        output  reg     [31:0]  instrE,
        
        // Control Signals
        input   wire            branchD,
        input   wire            jumpD,
        input   wire            we_regD,
        input   wire            alu_srcD,
        input   wire            we_dmD,
        input   wire            dm2regD,
        input   wire            rf_wd_jal_selD,
        input   wire    [2:0]   alu_ctrlD,
        input   wire            mult_weD,
        input   wire            rf_mult_shift_wd_selD,
        input   wire            sl_or_srD,
        input   wire            mult_shift_selD,
        input   wire            pc_jr_selD,
        input   wire            mult_hilo_selD,
        
        output   reg            branchE,
        output   reg            jumpE,
        output   reg            we_regE,
        output   reg            alu_srcE,
        output   reg            we_dmE,
        output   reg            dm2regE,
        output   reg            rf_wd_jal_selE,
        output   reg    [2:0]   alu_ctrlE,
        output   reg            mult_weE,
        output   reg            rf_mult_shift_wd_selE,
        output   reg            sl_or_srE,
        output   reg            mult_shift_selE,
        output   reg            pc_jr_selE,
        output   reg            mult_hilo_selE
    );
    
    always @ (posedge clk, posedge rst) begin
        if (rst) begin
            rd1E                    <= 0;
            rd2E                    <= 0;
            sext_immE               <= 0;
            rf_waE                  <= 0;
            pc_plus_4E              <= 0;
            instrE                  <= 0;
            
            branchE                 <= 0;
            jumpE                   <= 0;
            we_regE                 <= 0;
            alu_srcE                <= 0;
            we_dmE                  <= 0;
            dm2regE                 <= 0;
            rf_wd_jal_selE          <= 0;
            alu_ctrlE               <= 0;
            mult_weE                <= 0;
            rf_mult_shift_wd_selE   <= 0;
            sl_or_srE               <= 0;
            mult_shift_selE         <= 0;
            pc_jr_selE              <= 0;  
            mult_hilo_selE          <= 0;
        end
        else begin
            rd1E                    <= rd1D;
            rd2E                    <= rd2D;
            sext_immE               <= sext_immD;
            rf_waE                  <= rf_waD;
            pc_plus_4E              <= pc_plus_4D;
            instrE                  <= instrD;
            
            branchE                 <= branchD;
            jumpE                   <= jumpD;
            we_regE                 <= we_regD;
            alu_srcE                <= alu_srcD;
            we_dmE                  <= we_dmD;
            dm2regE                 <= dm2regD;
            rf_wd_jal_selE          <= rf_wd_jal_selD;
            alu_ctrlE               <= alu_ctrlD;
            mult_weE                <= mult_weD;
            rf_mult_shift_wd_selE   <= rf_mult_shift_wd_selD;
            sl_or_srE               <= sl_or_srD;
            mult_shift_selE         <= mult_shift_selD;
            pc_jr_selE              <= pc_jr_selD;  
            mult_hilo_selE          <= mult_hilo_selD;
        end
    end
endmodule
