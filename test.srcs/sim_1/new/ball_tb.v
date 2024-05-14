`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2024 12:52:14 AM
// Design Name: 
// Module Name: ball_tb
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


module ball_tb();
    reg clk_d;
    reg video_on;
    reg [3:0] x_data;
    reg [3:0] y_data;
    red_dot ball_inst (
        .clk_d(clk_d),
        .video_on(video_on),
        .x_data(x_data),
        .y_data(y_data),
        .red(),
        .green(),
        .blue()
    );

    initial begin
        clk_d = 1'b0;
        video_on = 1'b1;
        x_data = 4'd5; // example input for x_data
        y_data = 4'd0; // example input for y_data
        #100; // wait for 100 time units
        x_data = 4'd3; // change input for x_data
        y_data = 4'd5; // change input for y_data
        #100; // wait for 100 time units
        $finish; // finish the simulation
    end

    always #5 clk_d <= ~clk_d; // clock generator
endmodule