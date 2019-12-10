module mips_fpga (
        input  wire       clk,
        input  wire       rst,
        input  wire       button,
        input  wire [8:0] switches,
        output wire       we_dm,
        output wire [3:0] LEDSEL,
        output wire [7:0] LEDOUT
    );

    reg  [15:0] reg_hex;
    wire        clk_sec;
    wire        clk_5KHz;
    wire        clk_pb;

    wire [7:0]  digit0;
    wire [7:0]  digit1;
    wire [7:0]  digit2;
    wire [7:0]  digit3;

    wire [31:0] pc_current;
    wire [31:0] instr;
    wire [31:0] alu_out;
    wire [31:0] wd_dm;
    wire [31:0] rd_dm;
    wire [31:0] dispData;

    clk_gen clk_gen (
            .clk100MHz          (clk),
            .rst                (rst),
            .clk_4sec           (clk_sec),
            .clk_5KHz           (clk_5KHz)
        );

    button_debouncer bd (
            .clk                (clk_5KHz),
            .button             (button),
            .debounced_button   (clk_pb)
        );

    mips_top mips_top (
            .clk                (clk_pb),
            .rst                (rst),
            .ra3                (switches[4:0]),
            .we_dm              (we_dm),
            .pc_current         (pc_current),
            .instr              (instr),
            .alu_out            (alu_out),
            .wd_dm              (wd_dm),
            .rd_dm              (rd_dm),
            .rd3                (dispData)
        );

    /*
    switches[4:0] are used as the 3rd read address (ra3) of the RF,
    dispData is the register contents from the RF's 3rd read port (rd3).
    */

    hex_to_7seg hex3 (
            .HEX                (reg_hex[15:12]),
            .s                  (digit3)
        );

    hex_to_7seg hex2 (
            .HEX                (reg_hex[11:8]),
            .s                  (digit2)
        );

    hex_to_7seg hex1 (
            .HEX                (reg_hex[7:4]),
            .s                  (digit1)
        );

    hex_to_7seg hex0 (
            .HEX                (reg_hex[3:0]),
            .s                  (digit0)
        );

    led_mux led_mux (
            .clk                (clk_5KHz),
            .rst                (rst),
            .LED3               (digit3),
            .LED2               (digit2),
            .LED1               (digit1),
            .LED0               (digit0),
            .LEDSEL             (LEDSEL),
            .LEDOUT             (LEDOUT)
        );
    
    /*
    switches[8:5] = 0000 : Display lower  half word of register selected by switches[4:0]
    switches[8:5] = 0001 : Display higher half word of register selected by switches[4:0]
    switches[8:5] = 0010 : Display lower  half word of 'instr'
    switches[8:5] = 0011 : Display higher half word of 'instr'
    switches[8:5] = 0100 : Display lower  half word of 'alu_out'
    switches[8:5] = 0101 : Display higher half word of 'alu_out'
    switches[8:5] = 0110 : Display lower  half word of 'wd_dm'
    switches[8:5] = 0111 : Display higher half word of 'wd_dm'

    switches[8:5] = 1XX0 : Display lower  half word of 'pc_current'
    switches[8:5] = 1XX1 : Display higher half word of 'pc_current'
    */
    always @ (posedge clk) begin
        case ({switches[8:5]})
            4'b0000: reg_hex = dispData[15:0];
            4'b0001: reg_hex = dispData[31:16];
            4'b0010: reg_hex = instr[15:0];
            4'b0011: reg_hex = instr[31:16];
            4'b0100: reg_hex = alu_out[15:0];
            4'b0101: reg_hex = alu_out[31:16];
            4'b0110: reg_hex = wd_dm[15:0];
            4'b1000: reg_hex = pc_current[15:0];
            4'b1001: reg_hex = pc_current[31:16];
            default: reg_hex = pc_current[15:0];
        endcase
    end

endmodule
