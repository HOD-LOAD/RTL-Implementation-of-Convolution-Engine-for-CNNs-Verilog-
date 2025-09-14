`timescale 1ns/1ps

module tb_line_buffer;

    reg clk, rst;
    reg pixel_valid;
    reg [7:0] pixel_in;
    wire window_valid;
    wire [71:0] window_out; // flattened 9 pixels

    // split into 9 pixels
    wire [7:0] win0, win1, win2,
               win3, win4, win5,
               win6, win7, win8;

    assign {win0, win1, win2,
            win3, win4, win5,
            win6, win7, win8} = window_out;

    line_buffer uut (
        .clk(clk),
        .rst(rst),
        .pixel_valid(pixel_valid),
        .pixel_in(pixel_in),
        .window_valid(window_valid),
        .window_out(window_out)
    );

    // clock
    always #5 clk = ~clk;

    integer i;
    reg [7:0] image[0:15]; // 4x4 image

    initial begin
        clk = 0; rst = 1; pixel_valid = 0; pixel_in = 0;
        #10 rst = 0;

        // fill test image
        for (i = 0; i < 16; i = i + 1) image[i] = i;

        // feed pixels
        for (i = 0; i < 16; i = i + 1) begin
            @(posedge clk);
            pixel_in    <= image[i];
            pixel_valid <= 1;
        end

        @(posedge clk);
        pixel_valid <= 0;
        #50 $finish;
    end

    // monitor
    always @(posedge clk) begin
    if (pixel_valid)
        $display("Feeding pixel %0d at time %0t", pixel_in, $time);

    if (conv_valid)
        $display("Conv output = %0d at time %0t", conv_out, $time);
end


    initial begin
        $dumpfile("line_buffer.vcd");
        $dumpvars(0, tb_line_buffer);
    end
endmodule
