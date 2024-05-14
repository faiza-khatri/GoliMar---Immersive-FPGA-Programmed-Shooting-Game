`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/10/2024 09:26:49 PM
// Design Name: 
// Module Name: score_box_pix
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


module score_box_pix(

input [3:0] score,
input clk_d, // pixel clock 
input [9:0] pixel_x, //location of pixel x
input [9:0] pixel_y, //location of pixel y
input video_on, // determines when display is on
output reg [3:0] red, //instantiating red, blue ,green
output reg [3:0] green,
output reg [3:0] blue
);



parameter [9:0] a_x_start = 10'd518, a_x_end = 10'd550, a_y_start = 10'd35, a_y_end = 10'd44;
parameter [9:0] b_x_start = 10'd541, b_x_end = 10'd550, b_y_start = 10'd44, b_y_end = 10'd66;
parameter [9:0] c_x_start = 10'd541, c_x_end = 10'd550, c_y_start = 10'd75, c_y_end = 10'd97;
parameter [9:0] d_x_start = 10'd518, d_x_end = 10'd550, d_y_start = 10'd97, d_y_end = 10'd106;
parameter [9:0] e_x_start = 10'd518, e_x_end = 10'd527, e_y_start = 10'd75, e_y_end = 10'd97;
parameter [9:0] f_x_start = 10'd518, f_x_end = 10'd527, f_y_start = 10'd44, f_y_end = 10'd66;
parameter [9:0] g_x_start = 10'd518, g_x_end = 10'd550, g_y_start = 10'd66, g_y_end = 10'd75;


always @(posedge clk_d) begin
    if (video_on == 1) begin
//        red <= 4'h0; green <= 4'h0; blue <= 4'h0;

        // Check which pixels to light up based on the score
        case(score)
            0: begin // Pixels for a, b, c, d, e, f
    if ((((pixel_x >= a_x_start) && (pixel_x <= a_x_end)) && ((pixel_y >= a_y_start) && (pixel_y <= a_y_end)))||
        (((pixel_x >= b_x_start) && (pixel_x <= b_x_end)) && ((pixel_y >= b_y_start) && (pixel_y <= b_y_end)))||
        (((pixel_x >= c_x_start) && (pixel_x <= c_x_end)) && ((pixel_y >= c_y_start) && (pixel_y <= c_y_end)))||
        (((pixel_x >= d_x_start) && (pixel_x <= d_x_end)) && ((pixel_y >= d_y_start) && (pixel_y <= d_y_end)))||
        (((pixel_x >= e_x_start) && (pixel_x <= e_x_end)) && ((pixel_y >= e_y_start) && (pixel_y <= e_y_end)))||
        (((pixel_x >= f_x_start) && (pixel_x <= f_x_end)) && ((pixel_y >= f_y_start) && (pixel_y <= f_y_end))))
     begin
        red <= 4'hF; green <= 4'h0; blue <= 4'hF;
    end
end

    //for one
                1: begin 
                if (((pixel_x >= b_x_start) && (pixel_x <= b_x_end)) && ((pixel_y >= b_y_start) && (pixel_y <= b_y_end)) || (((pixel_x >= c_x_start) && (pixel_x <= c_x_end)) && ((pixel_y >= c_y_start) && (pixel_y <= c_y_end)))) begin
                    red <= 4'hF; green <= 4'h0; blue <= 4'hF;
                end
                end
                
   // for two
                 2: begin 
                if ((((pixel_x >= a_x_start) && (pixel_x <= a_x_end)) && ((pixel_y >= a_y_start) && (pixel_y <= a_y_end))) ||
                 (((pixel_x >= b_x_start) && (pixel_x <= b_x_end)) && ((pixel_y >= b_y_start) && (pixel_y <= b_y_end)))||
                 (((pixel_x >= g_x_start) && (pixel_x <= g_x_end)) && ((pixel_y >= g_y_start) && (pixel_y <= g_y_end)))||
                 (((pixel_x >= d_x_start) && (pixel_x <= d_x_end)) && ((pixel_y >= d_y_start) && (pixel_y <= d_y_end)))||
                 (((pixel_x >= e_x_start) && (pixel_x <= e_x_end)) && ((pixel_y >= e_y_start) && (pixel_y <= e_y_end))))
                 begin
                    red <= 4'hF; green <= 4'h0; blue <= 4'hF;
                end
                end
               
                    
    //for 3
                 3: begin 
                if ((((pixel_x >= a_x_start) && (pixel_x <= a_x_end)) && ((pixel_y >= a_y_start) && (pixel_y <= a_y_end))) ||
                 (((pixel_x >= b_x_start) && (pixel_x <= b_x_end)) && ((pixel_y >= b_y_start) && (pixel_y <= b_y_end)))||
                 (((pixel_x >= c_x_start) && (pixel_x <= c_x_end)) && ((pixel_y >= c_y_start) && (pixel_y <= c_y_end)))||
                 (((pixel_x >= d_x_start) && (pixel_x <= d_x_end)) && ((pixel_y >= d_y_start) && (pixel_y <= d_y_end)))||
                 (((pixel_x >= g_x_start) && (pixel_x <= g_x_end)) && ((pixel_y >= g_y_start) && (pixel_y <= g_y_end))))
                 begin
                    red <= 4'hF; green <= 4'h0; blue <= 4'hF;
                end
                end

     //for 4
                4: begin // Pixels for b, c, f, g
    if ((((pixel_x >= b_x_start) && (pixel_x <= b_x_end)) && ((pixel_y >= b_y_start) && (pixel_y <= b_y_end)))||
        (((pixel_x >= c_x_start) && (pixel_x <= c_x_end)) && ((pixel_y >= c_y_start) && (pixel_y <= c_y_end)))||
        (((pixel_x >= f_x_start) && (pixel_x <= f_x_end)) && ((pixel_y >= f_y_start) && (pixel_y <= f_y_end)))||
        (((pixel_x >= g_x_start) && (pixel_x <= g_x_end)) && ((pixel_y >= g_y_start) && (pixel_y <= g_y_end))))
     begin
        red <= 4'hF; green <= 4'h0; blue <= 4'hF;
    end
end

      //for 5
                5: begin 
                if ((((pixel_x >= a_x_start) && (pixel_x <= a_x_end)) && ((pixel_y >= a_y_start) && (pixel_y <= a_y_end)))||
                   (((pixel_x >= c_x_start) && (pixel_x <= c_x_end)) && ((pixel_y >= c_y_start) && (pixel_y <= c_y_end)))||
                   (((pixel_x >= d_x_start) && (pixel_x <= d_x_end)) && ((pixel_y >= d_y_start) && (pixel_y <= d_y_end)))||
                   (((pixel_x >= g_x_start) && (pixel_x <= g_x_end)) && ((pixel_y >= g_y_start) && (pixel_y <= g_y_end)))||
                   (((pixel_x >= f_x_start) && (pixel_x <= f_x_end)) && ((pixel_y >= f_y_start) && (pixel_y <= f_y_end))))
                 begin
                    red <= 4'hF; green <= 4'h0; blue <= 4'hF;
                end
                end
         //for 6 a,c,d,e,f,g
                //for 6
6: begin 
    if ((((pixel_x >= a_x_start) && (pixel_x <= a_x_end)) && ((pixel_y >= a_y_start) && (pixel_y <= a_y_end)))||
        (((pixel_x >= c_x_start) && (pixel_x <= c_x_end)) && ((pixel_y >= c_y_start) && (pixel_y <= c_y_end)))||
        (((pixel_x >= d_x_start) && (pixel_x <= d_x_end)) && ((pixel_y >= d_y_start) && (pixel_y <= d_y_end)))||
        (((pixel_x >= e_x_start) && (pixel_x <= e_x_end)) && ((pixel_y >= e_y_start) && (pixel_y <= e_y_end)))||
        (((pixel_x >= f_x_start) && (pixel_x <= f_x_end)) && ((pixel_y >= f_y_start) && (pixel_y <= f_y_end)))||
        (((pixel_x >= g_x_start) && (pixel_x <= g_x_end)) && ((pixel_y >= g_y_start) && (pixel_y <= g_y_end))))
     begin
        red <= 4'hF; green <= 4'h0; blue <= 4'hF;
    end
end
       7: begin // Pixels for a, b, c
    if ((((pixel_x >= a_x_start) && (pixel_x <= a_x_end)) && ((pixel_y >= a_y_start) && (pixel_y <= a_y_end)))||
        (((pixel_x >= b_x_start) && (pixel_x <= b_x_end)) && ((pixel_y >= b_y_start) && (pixel_y <= b_y_end)))||
        (((pixel_x >= c_x_start) && (pixel_x <= c_x_end)) && ((pixel_y >= c_y_start) && (pixel_y <= c_y_end))))
     begin
        red <= 4'hF; green <= 4'h0; blue <= 4'hF;
    end
end

         //for 8
   8: begin 
    if ((((pixel_x >= a_x_start) && (pixel_x <= a_x_end)) && ((pixel_y >= a_y_start) && (pixel_y <= a_y_end)))||
        (((pixel_x >= b_x_start) && (pixel_x <= b_x_end)) && ((pixel_y >= b_y_start) && (pixel_y <= b_y_end)))||
        (((pixel_x >= c_x_start) && (pixel_x <= c_x_end)) && ((pixel_y >= c_y_start) && (pixel_y <= c_y_end)))||
        (((pixel_x >= d_x_start) && (pixel_x <= d_x_end)) && ((pixel_y >= d_y_start) && (pixel_y <= d_y_end)))||
        (((pixel_x >= e_x_start) && (pixel_x <= e_x_end)) && ((pixel_y >= e_y_start) && (pixel_y <= e_y_end)))||
        (((pixel_x >= f_x_start) && (pixel_x <= f_x_end)) && ((pixel_y >= f_y_start) && (pixel_y <= f_y_end)))||
        (((pixel_x >= g_x_start) && (pixel_x <= g_x_end)) && ((pixel_y >= g_y_start) && (pixel_y <= g_y_end))))
     begin
        red <= 4'hF; green <= 4'h0; blue <= 4'hF;
    end
end

            // for 9
9: begin 
    if ((((pixel_x >= a_x_start) && (pixel_x <= a_x_end)) && ((pixel_y >= a_y_start) && (pixel_y <= a_y_end)))||
        (((pixel_x >= b_x_start) && (pixel_x <= b_x_end)) && ((pixel_y >= b_y_start) && (pixel_y <= b_y_end)))||
        (((pixel_x >= c_x_start) && (pixel_x <= c_x_end)) && ((pixel_y >= c_y_start) && (pixel_y <= c_y_end)))||
        (((pixel_x >= d_x_start) && (pixel_x <= d_x_end)) && ((pixel_y >= d_y_start) && (pixel_y <= d_y_end)))||
        (((pixel_x >= f_x_start) && (pixel_x <= f_x_end)) && ((pixel_y >= f_y_start) && (pixel_y <= f_y_end)))||
        (((pixel_x >= g_x_start) && (pixel_x <= g_x_end)) && ((pixel_y >= g_y_start) && (pixel_y <= g_y_end))))
     
     begin
        red <= 4'hF; green <= 4'h0 ; blue <= 4'hF;
    end
end

        endcase
    end
end








endmodule