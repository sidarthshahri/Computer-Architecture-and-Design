`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2019 03:44:40 AM
// Design Name: 
// Module Name: forwarding_logic
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


module forwarding_logic(
        input   wire            we_regM,
        input   wire    [4:0]   rsE,        // instrE [25:21]
        input   wire    [4:0]   rtE,        // instrE [20:16]
        input   wire    [4:0]   rf_waM,
        input   wire    [4:0]   rf_waW,
        input   wire            we_regW,
        
        output  reg    [1:0]   ForwardAE,
        output  reg    [1:0]   ForwardBE
    );
    
    always @ (*) begin
        // ForwardAE
        if(we_regM && (rsE != 0) && (rf_waM == rsE))
            ForwardAE = 10;
        else if(we_regW && (rsE != 0) && (rf_waW == rsE))
            ForwardAE = 01;
        else
            ForwardAE = 00;
        
        // ForwardBE
        if(we_regM && (rtE != 0) && (rf_waM == rtE))
            ForwardBE = 10;
        else if(we_regW && (rtE != 0) && (rf_waW == rtE))
            ForwardBE = 01;
        else
            ForwardBE = 00;       
    end
endmodule
