`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2019 12:00:50 AM
// Design Name: 
// Module Name: EX_MEM_State_Reg
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


module EX_MEM_State_Reg (
        // Datapath
        input   wire            clk, rst,
        input   wire            pc_srcE,
        input   wire    [31:0]  alu_outE,
        input   wire    [31:0]  rd1E,
        input   wire    [31:0]  rd2E,
        input   wire    [63:0]  mult_outE,
        input   wire    [4:0]   rf_waE,
        input   wire    [31:0]  pc_plus_4E,
        input   wire    [31:0]  btaE,
        input   wire    [31:0]  shift_resultE,
        input   wire    [31:0]  instrE,
        
        output  reg             pc_srcM,
        output  reg     [31:0]  alu_outM,
        output  reg     [31:0]  rd1M,
        output  reg     [31:0]  rd2M,
        output  reg     [63:0]  mult_outM,
        output  reg     [4:0]   rf_waM,
        output  reg     [31:0]  pc_plus_4M,
        output  reg     [31:0]  btaM,
        output  reg     [31:0]  shift_resultM,
        output  reg     [31:0]  instrM,
        
        // Control Signals 
        input   wire            jumpE,
        input   wire            we_regE,
        input   wire            we_dmE,
        input   wire            dm2regE,
        input   wire            rf_wd_jal_selE,
        input   wire            mult_weE,
        input   wire            rf_mult_shift_wd_selE,
        input   wire            mult_shift_selE,
        input   wire            pc_jr_selE,
        input   wire            mult_hilo_selE,
        
        output  reg             jumpM,
        output  reg             we_regM,
        output  reg             we_dmM,
        output  reg             dm2regM,
        output  reg             rf_wd_jal_selM,
        output  reg             mult_weM,    
        output  reg             rf_mult_shift_wd_selM,
        output  reg             mult_shift_selM,
        output  reg             pc_jr_selM,
        output  reg             mult_hilo_selM 
    );
    
    always @ (posedge clk, posedge rst) begin
        if (rst) begin
            pc_srcM         <= 0;
            alu_outM        <= 0;
            rd1M            <= 0;
            rd2M            <= 0;
            mult_outM       <= 0;
            rf_waM          <= 0;
            pc_plus_4M      <= 0;
            btaM            <= 0;
            shift_resultM   <= 0;
            instrM          <= 0;
            
            jumpM           <= 0;
            we_regM         <= 0;
            we_dmM          <= 0;
            dm2regM         <= 0;
            rf_wd_jal_selM  <= 0;
            mult_weM        <= 0;
            rf_mult_shift_wd_selM   <= 0;
            mult_shift_selM <= 0;
            pc_jr_selM      <= 0;
            mult_hilo_selM  <= 0;
        end
        else begin
            pc_srcM         <= pc_srcE;
            alu_outM        <= alu_outE;
            rd1M            <= rd1E;
            rd2M            <= rd2E;
            mult_outM       <= mult_outE;
            rf_waM          <= rf_waE;
            pc_plus_4M      <= pc_plus_4E;
            btaM            <= btaE;
            shift_resultM   <= shift_resultE;
            instrM          <= instrE;
            
            jumpM           <= jumpE;
            we_regM         <= we_regE;
            we_dmM          <= we_dmE;
            dm2regM         <= dm2regE;
            rf_wd_jal_selM  <= rf_wd_jal_selE;
            mult_weM        <= mult_weE;
            rf_mult_shift_wd_selM   <= rf_mult_shift_wd_selE;
            mult_shift_selM <= mult_shift_selE;
            pc_jr_selM      <= pc_jr_selE;
            mult_hilo_selM  <= mult_hilo_selE;
        end
    end    
endmodule
