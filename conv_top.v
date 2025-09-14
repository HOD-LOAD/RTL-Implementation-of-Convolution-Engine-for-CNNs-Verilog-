`timescale 1ns/1ps

module conv_top (
    input  wire        clk,
    input  wire        rst,
    input  wire        pixel_valid,
    input  wire [7:0]  pixel_in,
    input  wire [71:0] kernel_in,     // <-- must be 72 bits
    output wire signed [15:0] conv_out,
    output wire        conv_valid
);

    wire [71:0] window_out;
    wire        window_valid;

    // Line buffer generates 3x3 window (9*8 = 72 bits)
    line_buffer u_line_buffer (
        .clk(clk),
        .rst(rst),
        .pixel_valid(pixel_valid),
        .pixel_in(pixel_in),
        .window_out(window_out),
        .window_valid(window_valid)
    );

    // Convolution core
    conv_core u_core (
        .clk(clk),
        .rst(rst),
        .window_valid(window_valid),
        .window_in(window_out),   // <-- pass full 72-bit bus
        .kernel_in(kernel_in),    // <-- pass full 72-bit bus
        .conv_out(conv_out),
        .conv_valid(conv_valid)
    );

endmodule
