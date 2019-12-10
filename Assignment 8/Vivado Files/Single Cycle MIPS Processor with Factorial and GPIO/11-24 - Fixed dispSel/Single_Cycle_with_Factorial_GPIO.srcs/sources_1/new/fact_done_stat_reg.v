`timescale 1ns / 1ps

module fact_done_stat_reg(
        input           Clk, Rst, GoPulseCmb, Done,
        output  reg     ResDone
    );
    
    always @ (posedge Clk, posedge Rst) 
    begin
        if (Rst)
            ResDone <= 1'b0;
        else
            ResDone <= (~GoPulseCmb) & (Done | ResDone);
    end
endmodule
