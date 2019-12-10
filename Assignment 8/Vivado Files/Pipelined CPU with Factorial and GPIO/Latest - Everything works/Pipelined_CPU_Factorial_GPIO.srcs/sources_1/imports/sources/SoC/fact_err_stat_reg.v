`timescale 1ns / 1ps

module fact_err_stat_reg(
        input           Clk, Rst, GoPulseCmb, Err,
        output  reg     ResErr
    );
    
    always @ (posedge Clk, posedge Rst) 
    begin
        if (Rst)
            ResErr <= 1'b0;
        else
            ResErr <= (~GoPulseCmb) & (Err | ResErr);
    end
endmodule
