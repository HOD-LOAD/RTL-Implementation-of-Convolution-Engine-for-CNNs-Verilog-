`timescale 1ns/1ps

module conv_core(
    input  wire        clk,
    input  wire        rst,
    input  wire        window_valid,
    input  wire [71:0] window_in,   // 9 pixels, packed MSB->LSB
    input  wire [71:0] kernel_in,   // 9 weights, packed
    output reg signed [15:0] conv_out,   // <-- make signed
    output reg         conv_valid
);

    integer i;
    reg signed [15:0] sum;
    reg signed [7:0]  pix;
    reg signed [7:0]  wgt;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            conv_out   <= 0;
            conv_valid <= 0;
        end else if (window_valid) begin
            sum = 0;
            for (i = 0; i < 9; i = i + 1) begin
                pix = $signed(window_in[(71-8*i) -: 8]);
                wgt = $signed(kernel_in[(71-8*i) -: 8]);
                sum = sum + $signed(pix) * $signed(wgt);
            end
            conv_out   <= sum;
            conv_valid <= 1;
        end else begin
            conv_valid <= 0;
        end
    end
endmodule
