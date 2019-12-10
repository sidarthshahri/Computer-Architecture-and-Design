module DP_tb;
    reg [3:0] n;
    reg load_cnt, en, sel1, sel2, load_reg, clk;
    wire Error, GT;
    wire [31:0] product;
    
    DP DUT(
        .n(n),
        .load_cnt(load_cnt),
        .en(en),
        .sel1(sel1),
        .sel2(sel2),
        .load_reg(load_reg),
        .clk(clk),
        .Error(Error),
        .GT(GT),
        .product(product)
    );
    
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
        // S0
        load_cnt = 0;
        en = 0;
        sel1 = 0;
        sel2 = 0;
        load_reg = 0;
        clk = 0;
        n = 15;
        
        tick; // S0 -> S1
        
        // S1
        load_cnt = 1;
        en = 1;
        sel1 = 0;
        sel2 = 0;
        load_reg = 1;
        
        tick; // S1 -> S5
        
        // S5
        load_cnt = 0;
        en = 0;
        sel1 = 0;
        sel2 = 0;
        load_reg = 0;
        
        tick; // S5 -> S0
        
        // S0 
        load_cnt = 0;
        en = 0;
        sel1 = 0;
        sel2 = 0;
        load_reg = 0;
        clk = 0;
        n = 4;
        
        tick;   // S0 -> S1
        
        // S1
        load_cnt = 1;
        en = 1;
        sel1 = 0;
        sel2 = 0;
        load_reg = 1;
        
        tick; // S1 -> S2
        
        // S2
        load_cnt = 0;
        en = 0;    // 1?
        sel1 = 0;  // 1?
        sel2 = 0;
        load_reg = 0;
        
        tick; // S2 -> S3
        
        // S3
        load_cnt = 0;
        en = 1;
        sel1 = 1;
        sel2 = 0;
        load_reg = 1;
        
        tick; // S3 -> S2

        // S2
        load_cnt = 0;
        en = 0;     // 1?
        sel1 = 0;   // 1? 
        sel2 = 0;
        load_reg = 0;
        
        tick; // S2 -> S3
        
        // S3
        load_cnt = 0;
        en = 1;
        sel1 = 1;
        sel2 = 0;
        load_reg = 1;
        
        tick; // S3 -> S2
        
        // S2
        load_cnt = 0;
        en = 0;
        sel1 = 0;
        sel2 = 0;
        load_reg = 0;
        
        tick; // S2 -> S3
        
        // S3
        load_cnt = 0;
        en = 1;
        sel1 = 1;
        sel2 = 0;
        load_reg = 1;
        
        tick; // S3 -> S2
        
        // S2
        load_cnt = 0;
        en = 0;
        sel1 = 0;
        sel2 = 0;
        load_reg = 0;
        
        tick; // S2 -> S4   
        
        // S4
        load_cnt = 0;
        en = 0;
        sel1 = 0;
        sel2 = 1;
        load_reg = 0;
        
        tick; // S4 -> S0
        
        // S0
        load_cnt = 0;
        en = 0;
        sel1 = 0;
        sel2 = 1;
        load_reg = 0;
        
        $display("Finished DP Test");
    end
  
endmodule