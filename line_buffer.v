`timescale 1ns/1ps

module line_buffer #(
    parameter IMG_WIDTH = 8
)(
    input  wire        clk,
    input  wire        rst,
    input  wire        pixel_valid,
    input  wire [7:0]  pixel_in,
    output reg         window_valid,
    output reg [71:0]  window_out   // 9 pixels × 8 bits = 72 bits
);

    reg [7:0] line0[0:IMG_WIDTH-1];
    reg [7:0] line1[0:IMG_WIDTH-1];

    // keep previous two pixels of current row to form bottom row
    reg [7:0] prev_pixel1; // previous pixel (col-1)
    reg [7:0] prev_pixel2; // previous previous (col-2)

    integer col;
    integer row;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            col <= 0;
            row <= 0;
            window_valid <= 0;
            prev_pixel1 <= 0;
            prev_pixel2 <= 0;
            window_out <= 72'd0;
        end else if (pixel_valid) begin
            // update previous pixels (shift)
            prev_pixel2 <= prev_pixel1;
            prev_pixel1 <= pixel_in;

            // shift lines: line0 <= line1, line1 <= pixel_in
            line0[col] <= line1[col];
            line1[col] <= pixel_in;

            // update column/row counters
            if (col == IMG_WIDTH - 1) begin
                col <= 0;
                row <= row + 1;
            end else begin
                col <= col + 1;
            end

            // output 3x3 window when we have >= 2 previous rows and >= 2 previous cols
            if (row >= 2 && col >= 2) begin
                window_valid <= 1;
                window_out <= {
                    line0[col-2], line0[col-1], line0[col],
                    line1[col-2], line1[col-1], line1[col],
                    prev_pixel2,  prev_pixel1,  pixel_in
                };
            end else begin
                window_valid <= 0;
            end
        end
    end
endmodule
