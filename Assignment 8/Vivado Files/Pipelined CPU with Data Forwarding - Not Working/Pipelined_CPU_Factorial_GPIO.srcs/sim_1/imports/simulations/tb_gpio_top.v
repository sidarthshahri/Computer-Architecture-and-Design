`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2019 04:23:55 PM
// Design Name: 
// Module Name: tb_gpio_top
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


module tb_gpio_top;
    //inputs
    reg     [1:0]   A_tb;
    reg             WE_tb;
    reg     [31:0]  gpI1_tb;
    reg     [31:0]  gpI2_tb;
    reg     [31:0]  WD_tb;
    reg             rst_tb;  
    reg             clk_tb;

    //outputs
    wire [31:0] RD_tb;
    wire [31:0] gpO1_tb;
    wire [31:0] gpO2_tb;
   
    gpio_top DUT1(
        .A(A_tb),
        .WE(WE_tb),
        .gpI1(gpI1_tb),
        .gpI2(gpI2_tb),
        .WD(WD_tb),
        .Rst(rst_tb),
        .Clk(clk_tb),
        .gpO1(gpO1_tb),
        .gpO2(gpO2_tb),
        .RD(RD_tb)
    );   
       
    task tick; 
        begin 
           clk_tb = 0; #5; // Set bit 1 --> 0 after 5 time units
           clk_tb = 1; #5;
        end
    endtask

    initial begin
        begin
            // Reset GPIO module
            rst_tb = 1;
            tick;
            rst_tb = 0;
        
            // Set up GPIO module
            WE_tb = 1'b1;
            
            // Give test values to input
            WD_tb = 3;
            gpI1_tb = 5;
            gpI2_tb = 7;
            
            // Test all values for A
            A_tb = 2'b00;
            tick;
            
            A_tb = 2'b01;
            tick;
            
            A_tb = 2'b10;
            tick;
            
            A_tb = 2'b11;
            tick;
        end
    end
endmodule
