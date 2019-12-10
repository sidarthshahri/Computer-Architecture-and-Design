`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/23/2019 06:05:22 AM
// Design Name: 
// Module Name: fpga_Single_Cycle_SoC
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

module fpga_Pipelined_SoC (
        input  wire       clk,
        input  wire       rst,
        input  wire       button,
        input  wire [4:0] switches,
        output wire [3:0] factErr,  // 4 bits wide to trigger 4 LEDs
        output wire       dispSel,
        output wire [3:0] LEDSEL,
        output wire [7:0] LEDOUT
    );

    wire  [15:0] reg_hex;
    wire        clk_sec;
    wire        clk_5KHz;
    wire        clk_pb;

    wire [7:0]  digit0;
    wire [7:0]  digit1;
    wire [7:0]  digit2;
    wire [7:0]  digit3;
    
    wire [31:0] gpO1_wire;
    wire [31:0] gpO2_wire;
    
    assign dispSel = gpO1_wire[4];  // Not bit 0 of GPO1 as the slides would have you believe
    assign factErr[0] = gpO1_wire[0];
    assign factErr[1] = factErr[0];
    assign factErr[2] = factErr[0];
    assign factErr[3] = factErr[0];

    clk_gen clk_gen (
            .clk100MHz          (clk),
            .rst                (rst),
            .clk_4sec           (clk_sec),
            .clk_5KHz           (clk_5KHz)
        );

    button_debouncer bd (
            .clk                (clk_5KHz),
            .button             (button),
            .debounced_button   (clk_pb)
        );

    Pipelined_SoC Pipelined_SoC (
            .clk                (clk_5KHz), //clk_pb//
            .rst                (rst),
            .ra3                (),
            .gpI1               ({27'b0,switches[4:0]}),
            .gpI2               (gpO1_wire),
            .we_dm              (),
            .pc_current         (),
            .instr              (),
            .alu_out            (),
            .wd_dm              (),
            .rd_dm              (),
            .rd3                (),
            .gpO1               (gpO1_wire),
            .gpO2               (gpO2_wire)
        );
        
    mux2 #(16) fgpa_mux (
            .a                  (gpO2_wire[15:0]),
            .b                  (gpO2_wire[31:16]),
            .y                  (reg_hex),
            .sel                (dispSel)     
        );

    hex_to_7seg hex3 (
            .HEX                (reg_hex[15:12]),
            .s                  (digit3)
        );

    hex_to_7seg hex2 (
            .HEX                (reg_hex[11:8]),
            .s                  (digit2)
        );

    hex_to_7seg hex1 (
            .HEX                (reg_hex[7:4]),
            .s                  (digit1)
        );

    hex_to_7seg hex0 (
            .HEX                (reg_hex[3:0]),
            .s                  (digit0)
        );

    led_mux led_mux (
            .clk                (clk_5KHz),
            .rst                (rst),
            .LED3               (digit3),
            .LED2               (digit2),
            .LED1               (digit1),
            .LED0               (digit0),
            .LEDSEL             (LEDSEL),
            .LEDOUT             (LEDOUT)
        );
endmodule
