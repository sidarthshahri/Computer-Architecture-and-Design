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
    wire    [31:0]  wd_rfW;
    
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
        .wd_rfW         (wd_rfW)
    );
    
    task tick; 
    begin 
        clk = 0; #5;
        clk = 1; #5;
    end
    endtask

    initial begin
        // SoC_ad is outputting RdSel = 01 when alu_out (A) is 0x900???
        gpI1 = 32'b00000;   // n = 5, sel = 0
        rst = 1'b0; #5;
        rst = 1'b1; #5;
        rst = 1'b0;
        ra3 = 13;           // probe a register value
        tick;
        
        gpI2 = gpO2;
        tick;
        
        while(pc_current != 32'hb8) // tick until end of program
            tick;
        $finish;
    end
endmodule