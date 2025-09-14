`timescale 1ns/1ps

module tb_conv_top;
    reg clk;
    reg rst;
    reg pixel_valid;
    reg [7:0] pixel_in;
    reg [71:0] kernel_flat;  // <-- 72-bit kernel
    wire signed [15:0] conv_out;
    wire conv_valid;

    integer i, fd;

    // DUT
    conv_top uut (
        .clk(clk),
        .rst(rst),
        .pixel_valid(pixel_valid),
        .pixel_in(pixel_in),
        .kernel_in(kernel_flat),   // <-- MUST connect here
        .conv_out(conv_out),
        .conv_valid(conv_valid)
    );

    // clock
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        pixel_valid = 0;
        pixel_in = 0;
        kernel_flat = {
            8'shFF, 8'sh00, 8'sh01,
            8'shFE, 8'sh00, 8'sh02,
            8'shFF, 8'sh00, 8'sh01
        };

        #20 rst = 0;

        fd = $fopen("verilog_out.txt","w");
        if (fd == 0) begin
            $display("ERROR: cannot open verilog_out.txt");
            $finish;
        end

        // Feed 8x8 image
        for (i = 0; i < 64; i = i + 1) begin
            pixel_valid = 1;
            pixel_in = i[7:0];
            #10;
        end

        pixel_valid = 0;
        #300;
        $fclose(fd);
        $finish;
    end

    always @(posedge clk) begin
        if (conv_valid) begin
            $display("Conv output: %0d at time %0t", $signed(conv_out), $time);
            $fwrite(fd, "%0d\n", $signed(conv_out));
        end
    end
endmodule
