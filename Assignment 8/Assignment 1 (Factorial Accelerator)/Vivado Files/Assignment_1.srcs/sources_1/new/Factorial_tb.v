`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/06/2019 03:19:07 PM
// Design Name: 
// Module Name: Factorial_tb
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

module Factorial_tb;
reg [3:0] n;
reg go, clk;
wire done, error;
wire[31:0] product;

task tick;
    begin
        #1 clk = 0;
        #1 clk = 1;
    end   
endtask

Factorial DUT0(.n(n), .go(go), .clk(clk), .done(done),.error(error), .product(product));
integer i = 0;
integer j = 0;
integer x = 0;
integer k = 0;
integer calc_product = 0;

initial begin
    for (i = 14; i > 0; i = i - 1) begin
        n = i;
        go = 1;
        x = (2*n)+2;    // Calculates how many clock cycles to find n!
        calc_product = 1;
       
        // Calculates actual factorial value       
        for (k = i; k > 0; k = k - 1 ) begin
           calc_product = k*calc_product;
        end
        
        // Calculates factorial value in design    
        for (j = 1; j < x; j = j + 1) begin
            tick; 
        end
        
        if ( product == calc_product) 
            $display("Input: %d, Calc_prod: %d, prod: %d. Testbench successful!", n, calc_product, product);
        else
            $display("Input: %d, Calc_prod: %d, prod: %d. Testbench error!", n, calc_product, product);
        
        tick;   // Advance clock
    end 
end
endmodule
