`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/05/2019 05:22:15 PM
// Design Name: 
// Module Name: CU
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


/* Source Code for the Building Blocks Used */
//NEW********************
module CU(
    input go,
    input clk,
    input GT,
    input DP_error,
    output reg load_cnt,
    output reg en,
    output reg load_reg,
    output reg sel1,
    output reg sel2,
    output reg done,
    output reg CU_error
);

integer state0 = 3'b000;
integer state1 = 3'b001;
integer state2 = 3'b010;
integer state3 = 3'b011;
integer state4 = 3'b100;
integer state5 = 3'b101;

reg [2:0] cs = 3'b000;
reg [2:0] ns;

//reg [6:0] cw;
//always@(cw){load_cnt, en, load_reg, sel1, sel2, done, CU_error} = cw;
// cw stands for control word. This control word refers to each output bit sent by the CU to the DP

always@(posedge clk) 
    cs <= ns;

always@(*) begin 
    case (cs) 
        state0: begin 
                    done = 0;
                    CU_error = 0;
                    load_cnt = 0;
                    en = 0;
                    load_reg = 0;
                    sel1 = 0;
                    sel2 = 0;
                    if(!go) 
                        ns = state0;
                    else 
                        ns = state1;
                end
        state1: begin 
                    done = 0;
                    CU_error = 0;
                    load_cnt = 1;
                    en = 1;
                    load_reg = 1;
                    sel1 = 0;
                    sel2 = 0;
                    if(DP_error) 
                        ns = state5;
                    else 
                        ns = state2;
                end
        state2: begin
                    done = 0;
                    CU_error = 0;
                    load_cnt = 0;
                    en = 0;
                    load_reg = 0;  // updated
                    sel1 = 0;   //updated
                    sel2 = 0;
                    if(GT) 
                        ns = state3;
                    else 
                        ns = state4;
                end
        state3: begin
                    done = 0;
                    CU_error = 0;
                    load_cnt = 0;
                    en = 1;
                    load_reg = 1;
                    sel1 = 1;
                    sel2 = 0;
                    ns = state2;
                end
        state4: begin
                    done = 1;
                    CU_error = 0;
                    load_cnt = 0;
                    en = 0;
                    load_reg = 0;
                    sel1 = 0;
                    sel2 = 1;
                    ns = state0;     
                end
        state5: begin
                    done = 0;
                    CU_error = 1;
                    load_cnt = 0;
                    en = 0;
                    load_reg = 0;
                    sel1 = 0;
                    sel2 = 0;
                    ns = state0;     
                end
         default: begin
                    done = 0;
                    CU_error = 1;
                    load_cnt = 0;
                    en = 0;
                    load_reg = 0;
                    sel1 = 0;
                    sel2 = 0;
                    ns = state0;
                end
    
    endcase
    end
endmodule

