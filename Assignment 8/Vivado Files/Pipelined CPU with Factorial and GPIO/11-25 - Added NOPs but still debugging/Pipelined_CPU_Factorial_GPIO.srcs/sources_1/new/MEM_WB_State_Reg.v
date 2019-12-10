`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2019 12:00:50 AM
// Design Name: 
// Module Name: MEM_WB_State_Reg
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


module MEM_WB_State_Reg (
        // Datapath
        input   wire            clk, rst,
        input   wire    [31:0]  alu_outM,
        input   wire    [31:0]  rd_dmM,
        input   wire    [31:0]  rd1M,
        input   wire    [31:0]  mfhiM,
        input   wire    [31:0]  mfloM,
        input   wire    [4:0]   rf_waM,
        input   wire    [31:0]  pc_plus_4M,
        input   wire    [31:0]  shift_resultM,
        input   wire    [31:0]  instrM,
        
        output  reg     [31:0]  alu_outW,
        output  reg     [31:0]  rd_dmW,
        output  reg     [31:0]  rd1W,
        output  reg     [31:0]  mfhiW,
        output  reg     [31:0]  mfloW,
        output  reg     [4:0]   rf_waW,    
        output  reg     [31:0]  pc_plus_4W,
        output  reg     [31:0]  shift_resultW,
        output  reg     [31:0]  instrW,
        
        // Control Signals 
        input   wire            jumpM,
        input   wire            we_regM,
        input   wire            dm2regM,
        input   wire            rf_wd_jal_selM,
        input   wire            rf_mult_shift_wd_selM,
        input   wire            mult_shift_selM,
        input   wire            pc_jr_selM,
        input   wire            mult_hilo_selM,
        
        output  reg             jumpW,
        output  reg             we_regW,
        output  reg             dm2regW,
        output  reg             rf_wd_jal_selW,
        output  reg             rf_mult_shift_wd_selW,
        output  reg             mult_shift_selW,
        output  reg             pc_jr_selW,
        output  reg             mult_hilo_selW
    );
    
    always @ (posedge clk, posedge rst) begin
        if (rst) begin
            alu_outW            <= 0;
            rd_dmW              <= 0;
            rd1W                <= 0;
            mfhiW               <= 0;
            mfloW               <= 0;
            rf_waW              <= 0;  
            pc_plus_4W          <= 0;
            shift_resultW       <= 0;
            instrW              <= 0;
            
            jumpW               <= 0;
            we_regW             <= 0;
            dm2regW             <= 0;
            rf_wd_jal_selW      <= 0;
            rf_mult_shift_wd_selW   <= 0;
            mult_shift_selW     <= 0;
            pc_jr_selW          <= 0;
            mult_hilo_selW      <= 0;
        end
        else begin
            alu_outW            <= alu_outM;
            rd_dmW              <= rd_dmM;
            rd1W                <= rd1M;
            mfhiW               <= mfhiM;
            mfloW               <= mfloM;
            rf_waW              <= rf_waM;  
            pc_plus_4W          <= pc_plus_4M;
            shift_resultW       <= shift_resultM;
            instrW              <= instrM;
            
            jumpW               <= jumpM;
            we_regW             <= we_regM;
            dm2regW             <= dm2regM;
            rf_wd_jal_selW      <= rf_wd_jal_selM;
            rf_mult_shift_wd_selW   <= rf_mult_shift_wd_selM;
            mult_shift_selW     <= mult_shift_selM;
            pc_jr_selW          <= pc_jr_selM;
            mult_hilo_selW      <= mult_hilo_selM;
        end
    end    
endmodule
