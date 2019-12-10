`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/23/2019 04:32:40 PM
// Design Name: 
// Module Name: tb_fpga_Single_Cycle_SoC
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


module tb_fpga_Single_Cycle_SoC;
    reg             clk_tb, rst_tb, button_tb;
    reg     [4:0]   switches_tb;
    wire            factErr_tb;
    wire            dispSel_tb;
    wire    [3:0]   LEDSEL_tb;
    wire    [7:0]   LEDOUT_tb;
    integer         i;
    
    fpga_Single_Cycle_SoC DUT (
        .clk        (clk_tb),
        .rst        (rst_tb),
        .button     (),
        .switches   (switches_tb),
        .factErr    (factErr_tb),
        .dispSel    (dispSel_tb),
        .LEDSEL     (LEDSEL_tb),
        .LEDOUT     (LEDOUT_tb)
    );
    
    task tick; 
    begin 
        clk_tb = 0; #5;
        clk_tb = 1; #5;
    end
    endtask
    
    initial begin
        rst_tb = 1;
        tick;
        rst_tb = 0;
        i = 0;
        
        switches_tb = 5'b11010; // n = 10, sel = 1
        
        while(i < 50) begin
            tick;
            i = i+1; 
        end
        
    end
    
endmodule