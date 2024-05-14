`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2024 10:47:06 PM
// Design Name: 
// Module Name: toplevel
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


module toplevel(
    input clk,
    input button,
    input start,
    input reset,
    input [3:0] Vrx,
    input [3:0] Vry,
    output h_sync,
    output v_sync,
    output [3:0] red,
    output [3:0] green,
    output [3:0] blue
    );
    wire [9:0] x_loc; wire [9:0] y_loc;
    wire [9:0] h_count; wire [9:0] v_count;
    wire trig_v;
 

    //wire [3:0] score;
    wire but_out;
    wire start_out;
    wire reset_out;
    
    clk_div c3 (clk, clk_d);

    h_counter h3 (clk_d, h_count, trig_v);
    v_counter v1_pls_workaaa (clk_d, trig_v, v_count);
    vga_sync vg (h_count, v_count, h_sync, v_sync, video_on, x_loc, y_loc);
    debouncer but (button, clk, but_out);
    debouncer but2 (start, clk, start_out);
    debouncer butd (reset, clk, reset_out);
    //score_box sc_inc (clk, but_out, score);
    red_dot pix (clk, x_loc, y_loc, Vrx, Vry, video_on, but_out, start_out, reset_out, red, green, blue);
    
//    score_box_pix score_dis (score, clk_d, x_loc, y_loc, video_on, red, green, blue); 
    
endmodule
