`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/08/2019 02:28:53 PM
// Design Name: 
// Module Name: DU_tb
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


module CU_tb;
    reg go, clk, GT, DP_error;
    wire load_cnt, en, load_reg, sel1, sel2, done, CU_error;
   

    task tick;
    begin
        #5
        clk = !clk;
        #5
        clk = !clk;
    end
    endtask
    
    initial begin
        $display("Start DP Test");
        //state 0
        GT = 0;
        DP_error = 0;
        clk = 0;
        go = 1;
        
        tick; //goes to state 1
        
        DP_error = 1;
        
        tick; //goes to state 5
        DP_error = 0;
        tick; //goes to state 0
        tick;
        tick; // goes to state 1
        
     
           GT = 1;
        
        tick; //goes to state 2
        
     
        
        tick; //goes to state 3
      
        GT = 0;
              
        
        tick; //goes to state 2

        
        tick;//goes to state 4
        
        go = 0;
        
        tick; //goes to state 0
        
  
      
        
        if(done == 1)begin
        $display("Finished CU Test");
        end
    end
    
    CU DUT(
    .go(go),
    .clk(clk),
    .GT(GT),
    .DP_error(DP_error),
    .load_cnt(load_cnt),
    .en(en),
    .load_reg(load_reg),
    .sel1(sel1),
    .sel2(sel2),
    .done(done),
    .CU_error(CU_error)
    );
   
   
endmodule
