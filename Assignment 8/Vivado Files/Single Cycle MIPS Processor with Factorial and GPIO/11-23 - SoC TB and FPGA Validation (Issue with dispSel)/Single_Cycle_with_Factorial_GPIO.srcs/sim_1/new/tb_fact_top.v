`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2019 03:28:21 AM
// Design Name: 
// Module Name: tb_fact_top
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


module tb_fact_top;
    reg     [1:0]   A_tb;
    reg             WE_tb;
    reg     [3:0]   WD_tb;
    reg             Rst_tb;
    reg             Clk_tb;
    wire    [31:0]  RD_tb;
    integer i;

    task tick;
        begin
            Clk_tb = 0; #1;
            Clk_tb = 1; #1;
        end   
    endtask
    
    fact_top DUT1 (
        .A(A_tb),
        .WE(WE_tb),
        .WD(WD_tb),
        .Rst(Rst_tb),
        .Clk(Clk_tb),
        .RD(RD_tb)
    );

    initial begin
        // Reset fact_top module
        Rst_tb = 1;
        tick;
        Rst_tb = 0;
       
        for (i=0; i<14; i=i+1) begin
            // Load n and assert WE
            WD_tb = i;
            WE_tb = 1;
            A_tb = 2'b00;
            tick;
            
            // Give go signal
            WD_tb = 1;
            A_tb = 2'b01;
            tick;
            
            // Monitor Control Output (Done, Err)
            A_tb = 2'b10;
            tick;
            while (RD_tb == 0) begin
                tick;
            end
            
            // Examine result if Done = 1
            if(RD_tb == 1) begin       
                // Examine Result
                A_tb = 2'b11;
                tick;
            end else if(RD_tb == 2) begin
                $display("Error bit triggered for n = %d", i);
                tick;
            end
            
            // Reset factorial module
            Rst_tb = 0;
            WD_tb = 0;
            A_tb = 0;
            tick;
        end
    end
endmodule
