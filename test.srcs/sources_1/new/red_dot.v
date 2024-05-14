`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2024 10:37:58 PM
// Design Name: 
// Module Name: red_dot
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

module red_dot(
    input clk_d, //pixel clock
    input [9:0] pixel_x,
    input [9:0] pixel_y,
    input [3:0] x_data,
    input [3:0] y_data,
    input video_on,
//    input [3:0] score,
    input d_inc,
    input start,
    input reset,
   
    output reg [3:0]red = 0, //instantiating
    output reg [3:0]green = 0,
    output reg [3:0] blue = 0
    );
    parameter circle_radius = 10;
    parameter circle_centre_x = 320;
    parameter circle_centre_y = 240;
    
    reg [19:0] distance_sq;
    reg [9:0] x_add = 10'd320;
    reg [9:0] y_add = 10'd240;
    
    reg [32:0] delay1 = 0;
    reg [32:0] delay2 = 0;
    reg [32:0] delay3 = 0;
    reg [32:0] delay4 = 0;
    
    reg [3:0] score =0;
    
    // for score purposes
    parameter [9:0] a_x_start = 10'd560, a_x_end = 10'd592, a_y_start = 10'd25, a_y_end = 10'd34;
    parameter [9:0] b_x_start = 10'd583, b_x_end = 10'd592, b_y_start = 10'd34, b_y_end = 10'd56;
    parameter [9:0] c_x_start = 10'd583, c_x_end = 10'd592, c_y_start = 10'd65, c_y_end = 10'd87;
    parameter [9:0] d_x_start = 10'd560, d_x_end = 10'd592, d_y_start = 10'd87, d_y_end = 10'd96;
    parameter [9:0] e_x_start = 10'd560, e_x_end = 10'd569, e_y_start = 10'd65, e_y_end = 10'd87;
    parameter [9:0] f_x_start = 10'd560, f_x_end = 10'd569, f_y_start = 10'd34, f_y_end = 10'd56;
    parameter [9:0] g_x_start = 10'd560, g_x_end = 10'd592, g_y_start = 10'd56, g_y_end = 10'd65;
    
    
    parameter [9:0] one_x_s = 10'd260, one_x_e = 10'd284, one_y_s = 10'd180, one_y_e = 10'd204;
parameter [9:0] two_x_s = 10'd284, two_x_e = 10'd308, two_y_s = 10'd180, two_y_e = 10'd204;
parameter [9:0] three_x_s = 10'd308, three_x_e = 10'd332, three_y_s = 10'd180, three_y_e = 10'd204;
parameter [9:0] four_x_s = 10'd332, four_x_e = 10'd356, four_y_s = 10'd180, four_y_e = 10'd204;
parameter [9:0] five_x_s = 10'd356, five_x_e = 10'd380, five_y_s = 10'd180, five_y_e = 10'd204;
parameter [9:0] six_x_s = 10'd260, six_x_e = 10'd284, six_y_s = 10'd204, six_y_e = 10'd228;
parameter [9:0] seven_x_s = 10'd284, seven_x_e = 10'd308, seven_y_s = 10'd204, seven_y_e = 10'd228;
parameter [9:0] eight_x_s = 10'd308, eight_x_e = 10'd332, eight_y_s = 10'd204, eight_y_e = 10'd228;
parameter [9:0] nine_x_s = 10'd332, nine_x_e = 10'd356, nine_y_s = 10'd204, nine_y_e = 10'd228;
parameter [9:0] ten_x_s = 10'd356, ten_x_e = 10'd380, ten_y_s = 10'd204, ten_y_e = 10'd228;
parameter [9:0] eleven_x_s = 10'd260, eleven_x_e = 10'd284, eleven_y_s = 10'd228, eleven_y_e = 10'd252;
parameter [9:0] twelve_x_s = 10'd284, twelve_x_e = 10'd308, twelve_y_s = 10'd228, twelve_y_e = 10'd252;

parameter [9:0] thirteen_x_s = 10'd308, thirteen_x_e = 10'd332, thirteen_y_s = 10'd228, thirteen_y_e = 10'd252;
parameter [9:0] fourteen_x_s = 10'd332, fourteen_x_e = 10'd356, fourteen_y_s = 10'd228, fourteen_y_e = 10'd252;
parameter [9:0] fifteen_x_s = 10'd356, fifteen_x_e = 10'd380, fifteen_y_s = 10'd228, fifteen_y_e = 10'd252;
parameter [9:0] sixteen_x_s = 10'd260, sixteen_x_e = 10'd284, sixteen_y_s = 10'd252, sixteen_y_e = 10'd276;
parameter [9:0] seventeen_x_s = 10'd284, seventeen_x_e = 10'd308, seventeen_y_s = 10'd252, seventeen_y_e = 10'd276;
parameter [9:0] eighteen_x_s = 10'd308, eighteen_x_e = 10'd332, eighteen_y_s = 10'd252, eighteen_y_e = 10'd276;
parameter [9:0] nineteen_x_s = 10'd332, nineteen_x_e = 10'd356, nineteen_y_s = 10'd252, nineteen_y_e = 10'd276;
parameter [9:0] twenty_x_s = 10'd356, twenty_x_e = 10'd380, twenty_y_s = 10'd252, twenty_y_e = 10'd276;

parameter [9:0] twentyone_x_s = 10'd260, twentyone_x_e = 10'd284, twentyone_y_s = 10'd276, twentyone_y_e = 10'd300;
parameter [9:0] twentytwo_x_s = 10'd284, twentytwo_x_e = 10'd308, twentytwo_y_s = 10'd276, twentytwo_y_e = 10'd300;
parameter [9:0] twentythree_x_s = 10'd308, twentythree_x_e = 10'd332, twentythree_y_s = 10'd276, twentythree_y_e = 10'd300;
parameter [9:0] twentyfour_x_s = 10'd332, twentyfour_x_e = 10'd356, twentyfour_y_s = 10'd276, twentyfour_y_e = 10'd300;
parameter [9:0] twentyfive_x_s = 10'd356, twentyfive_x_e = 10'd380, twentyfive_y_s = 10'd276, twentyfive_y_e = 10'd300;

parameter enemy_x=88;
parameter enemy_y=229;
parameter friend_x=514;
parameter friend_y=229;

    
    always @(posedge clk_d) 
    begin
//    if (reset==1) begin
//    x_add <= 10'd320;
//    y_add <= 10'd240;
//    delay1 <= 0;
//    delay2 <= 0;
//    delay3 <= 0;
//    delay4 <= 0;
//    score <= 0;
//    counter<=0;
//    enemy1 <= 1;
//    end
    if ((x_data) > 10'd6) begin
        if ((x_add < 10'd510 && y_add < 10'd120) || (x_add <10'd630 && y_add >= 10'd120))begin
        if (delay1 == 32'd2000000) begin
        delay1 = 0; 
        x_add = x_add + 3'd5;
        end
        else begin
        delay1 = delay1 + 1'd1;
        end
        end
    end

    else if ((x_data) < 10'd2) begin
        
        if (x_add > 10'd10) begin
            if (delay2 == 32'd2000000) begin
            delay2 = 32'd0; 
            x_add = x_add - 3'd5;
            end
            else begin
            delay2 = delay2 + 1'd1;
            end
            end
    end
    else if ((y_data) > 10'd7) begin
        if ((y_add > 10'd10 && x_add < 10'd510) || (y_add > 10'd110 && x_add >= 10'd510)) begin
       
        if (delay3 == 32'd2000000) begin
        delay3 = 32'd0; 
        y_add = y_add - 3'd5;
        end
        else begin
        delay3 = delay3 + 1'd1;
        end
        end
    end
    else if ((y_data) < 10'd2) begin
        if (y_add < 10'd470 ) begin
        if (delay4 == 32'd2000000) begin
        delay4 = 32'd0; 
        y_add = y_add + 3'd5;
        end
        else begin
        delay4 = delay4 + 1'd1;
        end
        end
    end
   end 
   integer  b=1000; //x
integer q=1000; //y

parameter clk_freq=100000000;
reg[31:0]counter=0;
reg enemy1=1;
reg[8:0] enemy;
reg target1;
reg game_over = 0;
reg game_start = 0;

always @(posedge clk_d) begin
if (start==1)
game_start <= 1;
end



always @(posedge clk_d) begin

if(counter>=clk_freq*2)begin
enemy1=~enemy1;
b<=(b*5+59857)%501;
q<=(q*3+598857)%300;
counter<=0;
end
else begin
counter<=counter+1;
end
enemy[1]<=((((pixel_x <= b+52) && (pixel_x >=b))&&((pixel_y <=q+8) && (pixel_y >=q))) ||
                (((pixel_x <= b+8) && (pixel_x >=b))&&((pixel_y <=q+39) && (pixel_y >=q))) || 
                (((pixel_x <= b+52) && (pixel_x >=b+44))&&((pixel_y <=q+39) && (pixel_y >=q))) ||
                (((pixel_x <= b+52) && (pixel_x >=b))&&((pixel_y <=q+39) && (pixel_y >=q+31))) ||
                (((pixel_x <= b+23) && (pixel_x >=b+15))&&((pixel_y <=q+23) && (pixel_y >=q+15)))||
                (((pixel_x <= b+38) && (pixel_x >=b+30))&&((pixel_y <=q+23) && (pixel_y >=q+15))) ||
                (((pixel_x <= b+42) && (pixel_x >=b+10))&&((pixel_y <=q+41) && (pixel_y >=q+33))) ||
                (((pixel_x <= b+18) && (pixel_x >=b+10))&&((pixel_y <=q+72) && (pixel_y >=q+33))) ||
                (((pixel_x <= b+42) && (pixel_x >=b+34))&&((pixel_y <=q+72) && (pixel_y >=q+33))) ||
                (((pixel_x <= b+42) && (pixel_x >=b+10))&&((pixel_y <=q+72) && (pixel_y >=q+64))) ||
                (((pixel_x <= b+9) && (pixel_x >=b))&&((pixel_y <=q+60) && (pixel_y >=q+51))) ||
                (((pixel_x <= b+52) && (pixel_x >=b+43))&&((pixel_y <=q+60) && (pixel_y >=q+51))) ||
                (((pixel_x <= b+24) && (pixel_x >=b+15))&&((pixel_y <=q+88) && (pixel_y >=q+73))) ||
                (((pixel_x <=b+38) && (pixel_x >=b+29))&&((pixel_y <=q+88) && (pixel_y >=q+73))) );
                
  

//if ((((x_add <= b+52) && (x_add >= b)) || 
//(((x_add+1) <= b+52) && ((x_add+1) >= b)) || 
//(((x_add+2) <= b+52) && ((x_add+2) >= b)) || 
//(((x_add+3) <= b+52) && ((x_add+3) >= b)) || 
//(((x_add+4) <= b+52) && ((x_add+4) >= b)) || 
//(((x_add+5) <= b+52) && ((x_add+5) >= b)) ||
//(((x_add+6) <= b+52) && ((x_add+6) >= b)) || 
//(((x_add+7) <= b+52) && ((x_add+7) >= b)) || 
//(((x_add+8) <= b+52) && ((x_add+8) >= b)) || 
//(((x_add+9) <= b+52) && ((x_add+9) >= b)) || 
//(((x_add+10) <= b+52) && ((x_add+10) >= b))) && 
//((((y_add <= q+8) && (y_add>= q)) || 
//(((y_add+1)<= q+8) && ((y_add+1) >= q)) || 
//(((y_add+2)<= q+8) && ((y_add+2) >= q)) || 
//(((y_add+3)<= q+8) && ((y_add+3) >= q)) || 
//(((y_add+4)<= q+8) && ((y_add+4) >= q)) ||  
//(((y_add+5)<= q+8) && ((y_add+5) >= q)) ||
//(((y_add+6)<= q+8) && ((y_add+6) >= q)) || 
//(((y_add+7)<= q+8) && ((y_add+7) >= q)) || 
//(((y_add+8)<= q+8) && ((y_add+8) >= q)) ||
//(((y_add+9)<= q+8) && ((y_add+9) >= q)) || 
//(((y_add+10)<= q+8) && ((y_add+10) >= q)))))
end
always @(posedge clk_d) begin
if (x_add <= b+52 && x_add >= b && y_add <= q+88 && y_add >= q)
target1=1;
else
target1=0;
end
//reg delay_game_start = 32'd0;
// for target setting
always @(posedge d_inc) begin
if (score <4'd9 && target1==1 && enemy1 == 1) begin
    score <= score + 1;
        end
else if (score <4'd9 && target1==1 && enemy1 == 0 ) begin    
game_over <= 1;
//if (delay_game_start == 100000000) begin
//game_over = 0;
//game_start = 0;
//score = 0;
//end
//else begin
//delay_game_start = delay_game_start + 1; 
//end
end



end


   always @(posedge clk_d) begin 
    // Determine if the pixel is within the circle and set the color accordingly
    red <= video_on? 4'hF: 4'h0; blue <= video_on?4'hF: 4'h0; green <= video_on? 4'hF: 4'h0;
    if (video_on) begin
    if (game_start==0) begin
    if (((pixel_x >= 526) && (pixel_x <= 599)) && ((pixel_y >= 52) && (pixel_y <= 61))) begin
red <= 4'h0; green <= 4'h0; blue <= 4'hF;
end
else if (((pixel_x >= 526) && (pixel_x <= 599)) && ((pixel_y >= 68) && (pixel_y <= 76))) begin
red <= 4'h0; green <= 4'h0; blue <= 4'hF;
end
else if (((pixel_x >= 526) && (pixel_x <= 535)) && ((pixel_y >= 73) && (pixel_y <= 118))) begin
red <= 4'h0; green <= 4'h0; blue <= 4'hF;
end
else if (((pixel_x >= 478) && (pixel_x <= 528)) && ((pixel_y >= 110) && (pixel_y <= 118))) begin
red <= 4'h0; green <= 4'h0; blue <= 4'hF;
end
else if (((pixel_x >= 478) && (pixel_x <= 486)) && ((pixel_y >= 87) && (pixel_y <= 111))) begin
red <= 4'h0; green <= 4'h0; blue <= 4'hF;
end
else if (((pixel_x >= 478) && (pixel_x <= 504)) && ((pixel_y >= 86) && (pixel_y <= 93))) begin
red <= 4'h0; green <= 4'h0; blue <= 4'hF;
end
else if (((pixel_x >= 498) && (pixel_x <= 507)) && ((pixel_y >= 86) && (pixel_y <= 142))) begin
red <= 4'h0; green <= 4'h0; blue <= 4'hF;
end
else if (((pixel_x >= 478) && (pixel_x <= 500)) && ((pixel_y >= 135) && (pixel_y <= 142))) begin
red <= 4'h0; green <= 4'h0; blue <= 4'hF;
end
else if (((pixel_x >= 453) && (pixel_x <= 463)) && ((pixel_y >= 49) && (pixel_y <= 119))) begin
red <= 4'h0; green <= 4'h0; blue <= 4'hF;
end
else if (((pixel_x >= 430) && (pixel_x <= 455)) && ((pixel_y >= 111) && (pixel_y <= 119))) begin
red <= 4'h0; green <= 4'h0; blue <= 4'hF;
end
else if (((pixel_x >= 430) && (pixel_x <= 438)) && ((pixel_y >= 104) && (pixel_y <= 112))) begin
red <= 4'h0; green <= 4'h0; blue <= 4'hF;
end
else if (((pixel_x >= 418) && (pixel_x <= 438)) && ((pixel_y >= 97) && (pixel_y <= 106))) begin
red <= 4'h0; green <= 4'h0; blue <= 4'hF;
end
else if (((pixel_x >= 413) && (pixel_x <= 421)) && ((pixel_y >= 97) && (pixel_y <= 139))) begin
red <= 4'h0; green <= 4'h0; blue <= 4'hF;
end
else if (((pixel_x >= 382) && (pixel_x <= 414)) && ((pixel_y >= 131) && (pixel_y <= 139))) begin
red <= 4'h0; green <= 4'h0; blue <= 4'hF;
end
else if (((pixel_x >= 382) && (pixel_x <= 390)) && ((pixel_y >= 108) && (pixel_y <= 132))) begin
red <= 4'h0; green <= 4'h0; blue <= 4'hF;
end
else if (((pixel_x >= 315) && (pixel_x <= 342)) && ((pixel_y >= 133) && (pixel_y <= 141))) begin
red <= 4'h0; green <= 4'h0; blue <= 4'hF;
end
else if (((pixel_x >= 336) && (pixel_x <= 345)) && ((pixel_y >= 109) && (pixel_y <= 141))) begin
red <= 4'h0; green <= 4'h0; blue <= 4'hF;
end
else if (((pixel_x >= 314) && (pixel_x <= 345)) && ((pixel_y >= 107) && (pixel_y <= 115))) begin
red <= 4'h0; green <= 4'h0; blue <= 4'hF;
end
else if (((pixel_x >= 314) && (pixel_x <= 323)) && ((pixel_y >= 107) && (pixel_y <= 141))) begin
red <= 4'h0; green <= 4'h0; blue <= 4'hF;
end
else if (((pixel_x >= 283) && (pixel_x <= 319)) && ((pixel_y >= 132) && (pixel_y <= 141))) begin
red <= 4'h0; green <= 4'h0; blue <= 4'hF;
end
else if (((pixel_x >= 277) && (pixel_x <= 287)) && ((pixel_y >= 55) && (pixel_y <= 141))) begin
red <= 4'h0; green <= 4'h0; blue <= 4'hF;
end
else if (((pixel_x >= 277) && (pixel_x <= 287)) && ((pixel_y >= 50) && (pixel_y <= 58))) begin
red <= 4'h0; green <= 4'h0; blue <= 4'hF;
end
else if (((pixel_x >= 257) && (pixel_x <= 269)) && ((pixel_y >= 129) && (pixel_y <= 141))) begin
red <= 4'h0; green <= 4'h0; blue <= 4'hF;
end
else if (((pixel_x >= 254) && (pixel_x <= 265)) && ((pixel_y >= 137) && (pixel_y <= 164))) begin
red <= 4'h0; green <= 4'h0; blue <= 4'hF;
end
else if (((pixel_x >= 250) && (pixel_x <= 261)) && ((pixel_y >= 160) && (pixel_y <= 172))) begin
red <= 4'h0; green <= 4'h0; blue <= 4'hF;
end
else if (((pixel_x >= 246) && (pixel_x <= 257)) && ((pixel_y >= 169) && (pixel_y <= 180))) begin
red <= 4'h0; green <= 4'h0; blue <= 4'hF;
end
else if (((pixel_x >= 242) && (pixel_x <= 253)) && ((pixel_y >= 177) && (pixel_y <= 187))) begin
red <= 4'h0; green <= 4'h0; blue <= 4'hF;
end
else if (((pixel_x >= 238) && (pixel_x <= 248)) && ((pixel_y >= 184) && (pixel_y <= 195))) begin
red <= 4'h0; green <= 4'h0; blue <= 4'hF;
end
else if (((pixel_x >= 258) && (pixel_x <= 269)) && ((pixel_y >= 119) && (pixel_y <= 132))) begin
red <= 4'h0; green <= 4'h0; blue <= 4'hF;
end
else if (((pixel_x >= 182) && (pixel_x <= 190)) && ((pixel_y >= 355) && (pixel_y <= 403))) begin
red <= 4'hF; green <= 4'hF; blue <= 4'h0;
end
else if (((pixel_x >= 184) && (pixel_x <= 214)) && ((pixel_y >= 355) && (pixel_y <= 364))) begin
red <= 4'hF; green <= 4'hF; blue <= 4'h0;
end
else if (((pixel_x >= 208) && (pixel_x <= 214)) && ((pixel_y >= 356) && (pixel_y <= 382))) begin
red <= 4'hF; green <= 4'hF; blue <= 4'h0;
end
else if (((pixel_x >= 185) && (pixel_x <= 214)) && ((pixel_y >= 376) && (pixel_y <= 385))) begin
red <= 4'hF; green <= 4'hF; blue <= 4'h0;
end
else if (((pixel_x >= 219) && (pixel_x <= 226)) && ((pixel_y >= 372) && (pixel_y <= 404))) begin
red <= 4'hF; green <= 4'hF; blue <= 4'h0;
end
else if (((pixel_x >= 219) && (pixel_x <= 244)) && ((pixel_y >= 371) && (pixel_y <= 377))) begin
red <= 4'hF; green <= 4'hF; blue <= 4'h0;
end
else if (((pixel_x >= 239) && (pixel_x <= 244)) && ((pixel_y >= 371) && (pixel_y <= 391))) begin
red <= 4'hF; green <= 4'hF; blue <= 4'h0;
end
else if (((pixel_x >= 222) && (pixel_x <= 244)) && ((pixel_y >= 387) && (pixel_y <= 392))) begin
red <= 4'hF; green <= 4'hF; blue <= 4'h0;
end
else if (((pixel_x >= 236) && (pixel_x <= 241)) && ((pixel_y >= 390) && (pixel_y <= 404))) begin
red <= 4'hF; green <= 4'hF; blue <= 4'h0;
end
else if (((pixel_x >= 248) && (pixel_x <= 254)) && ((pixel_y >= 371) && (pixel_y <= 404))) begin
red <= 4'hF; green <= 4'hF; blue <= 4'h0;
end
else if (((pixel_x >= 249) && (pixel_x <= 270)) && ((pixel_y >= 371) && (pixel_y <= 377))) begin
red <= 4'hF; green <= 4'hF; blue <= 4'h0;
end
else if (((pixel_x >= 250) && (pixel_x <= 263)) && ((pixel_y >= 385) && (pixel_y <= 391))) begin
red <= 4'hF; green <= 4'hF; blue <= 4'h0;
end
else if (((pixel_x >= 251) && (pixel_x <= 270)) && ((pixel_y >= 398) && (pixel_y <= 404))) begin
red <= 4'hF; green <= 4'hF; blue <= 4'h0;
end
else if (((pixel_x >= 275) && (pixel_x <= 297)) && ((pixel_y >= 371) && (pixel_y <= 377))) begin
red <= 4'hF; green <= 4'hF; blue <= 4'h0;
end
else if (((pixel_x >= 301) && (pixel_x <= 322)) && ((pixel_y >= 371) && (pixel_y <= 377))) begin
red <= 4'hF; green <= 4'hF; blue <= 4'h0;
end
else if (((pixel_x >= 275) && (pixel_x <= 280)) && ((pixel_y >= 373) && (pixel_y <= 387))) begin
red <= 4'hF; green <= 4'hF; blue <= 4'h0;
end
else if (((pixel_x >= 275) && (pixel_x <= 297)) && ((pixel_y >= 385) && (pixel_y <= 391))) begin
red <= 4'hF; green <= 4'hF; blue <= 4'h0;
end
else if (((pixel_x >= 291) && (pixel_x <= 297)) && ((pixel_y >= 388) && (pixel_y <= 405))) begin
red <= 4'hF; green <= 4'hF; blue <= 4'h0;
end
else if (((pixel_x >= 275) && (pixel_x <= 292)) && ((pixel_y >= 399) && (pixel_y <= 405))) begin
red <= 4'hF; green <= 4'hF; blue <= 4'h0;
end
else if (((pixel_x >= 301) && (pixel_x <= 307)) && ((pixel_y >= 375) && (pixel_y <= 392))) begin
red <= 4'hF; green <= 4'hF; blue <= 4'h0;
end
else if (((pixel_x >= 303) && (pixel_x <= 322)) && ((pixel_y >= 387) && (pixel_y <= 392))) begin
red <= 4'hF; green <= 4'hF; blue <= 4'h0;
end
else if (((pixel_x >= 316) && (pixel_x <= 322)) && ((pixel_y >= 390) && (pixel_y <= 406))) begin
red <= 4'hF; green <= 4'hF; blue <= 4'h0;
end
else if (((pixel_x >= 300) && (pixel_x <= 319)) && ((pixel_y >= 400) && (pixel_y <= 406))) begin
red <= 4'hF; green <= 4'hF; blue <= 4'h0;
end
else if (((pixel_x >= 356) && (pixel_x <= 396)) && ((pixel_y >= 350) && (pixel_y <= 358))) begin
red <= 4'hF; green <= 4'hF; blue <= 4'h0;
end
else if (((pixel_x >= 356) && (pixel_x <= 364)) && ((pixel_y >= 355) && (pixel_y <= 377))) begin
red <= 4'hF; green <= 4'hF; blue <= 4'h0;
end
else if (((pixel_x >= 356) && (pixel_x <= 396)) && ((pixel_y >= 375) && (pixel_y <= 383))) begin
red <= 4'hF; green <= 4'hF; blue <= 4'h0;
end
else if (((pixel_x >= 389) && (pixel_x <= 396)) && ((pixel_y >= 381) && (pixel_y <= 408))) begin
red <= 4'hF; green <= 4'hF; blue <= 4'h0;
end
else if (((pixel_x >= 355) && (pixel_x <= 391)) && ((pixel_y >= 397) && (pixel_y <= 408))) begin
red <= 4'hF; green <= 4'hF; blue <= 4'h0;
end
else if (((pixel_x >= 402) && (pixel_x <= 442)) && ((pixel_y >= 369) && (pixel_y <= 377))) begin
red <= 4'hF; green <= 4'hF; blue <= 4'h0;
end
else if (((pixel_x >= 418) && (pixel_x <= 425)) && ((pixel_y >= 375) && (pixel_y <= 409))) begin
red <= 4'hF; green <= 4'hF; blue <= 4'h0;
end
else if (((pixel_x >= 447) && (pixel_x <= 455)) && ((pixel_y >= 369) && (pixel_y <= 410))) begin
red <= 4'hF; green <= 4'hF; blue <= 4'h0;
end
else if (((pixel_x >= 449) && (pixel_x <= 476)) && ((pixel_y >= 369) && (pixel_y <= 377))) begin
red <= 4'hF; green <= 4'hF; blue <= 4'h0;
end
else if (((pixel_x >= 469) && (pixel_x <= 476)) && ((pixel_y >= 374) && (pixel_y <= 411))) begin
red <= 4'hF; green <= 4'hF; blue <= 4'h0;
end
else if (((pixel_x >= 451) && (pixel_x <= 471)) && ((pixel_y >= 389) && (pixel_y <= 396))) begin
red <= 4'hF; green <= 4'hF; blue <= 4'h0;
end
else if (((pixel_x >= 483) && (pixel_x <= 490)) && ((pixel_y >= 369) && (pixel_y <= 411))) begin
red <= 4'hF; green <= 4'hF; blue <= 4'h0;
end
else if (((pixel_x >= 486) && (pixel_x <= 512)) && ((pixel_y >= 369) && (pixel_y <= 376))) begin
red <= 4'hF; green <= 4'hF; blue <= 4'h0;
end
else if (((pixel_x >= 506) && (pixel_x <= 512)) && ((pixel_y >= 370) && (pixel_y <= 392))) begin
red <= 4'hF; green <= 4'hF; blue <= 4'h0;
end
else if (((pixel_x >= 485) && (pixel_x <= 509)) && ((pixel_y >= 386) && (pixel_y <= 392))) begin
red <= 4'hF; green <= 4'hF; blue <= 4'h0;
end
else if (((pixel_x >= 502) && (pixel_x <= 508)) && ((pixel_y >= 390) && (pixel_y <= 411))) begin
red <= 4'hF; green <= 4'hF; blue <= 4'h0;
end
else if (((pixel_x >= 517) && (pixel_x <= 548)) && ((pixel_y >= 369) && (pixel_y <= 375))) begin
red <= 4'hF; green <= 4'hF; blue <= 4'h0;
end
else if (((pixel_x >= 529) && (pixel_x <= 537)) && ((pixel_y >= 373) && (pixel_y <= 411))) begin
red <= 4'hF; green <= 4'hF; blue <= 4'h0;
end
else if (((pixel_x >= 105) && (pixel_x <= 179)) && ((pixel_y >= 77) && (pixel_y <= 98))) begin
red <= 4'hF; green <= 4'h0; blue <= 4'h0;
end
else if ((pixel_x - 105)**2 + (pixel_y - 88)**2 <= 10**2) begin
red <= 4'hF; green <= 4'h0; blue <= 4'h0;
end
else if ((pixel_x - 176)**2 + (pixel_y - 87)**2 <= 6**2) begin
red <= 4'hF; green <= 4'h0; blue <= 4'h0;
end
//enemy
else if ((((pixel_x <= enemy_x+52) && (pixel_x >=enemy_x))&&((pixel_y <=enemy_y+8) && (pixel_y >=enemy_y))) ||
                (((pixel_x <= enemy_x+8) && (pixel_x >=enemy_x))&&((pixel_y <=enemy_y+39) && (pixel_y >=enemy_y))) || 
                (((pixel_x <= enemy_x+52) && (pixel_x >=enemy_x+44))&&((pixel_y <=enemy_y+39) && (pixel_y >=enemy_y))) ||
                (((pixel_x <= enemy_x+52) && (pixel_x >=enemy_x))&&((pixel_y <=enemy_y+39) && (pixel_y >=enemy_y+31))) ||
                (((pixel_x <= enemy_x+23) && (pixel_x >=enemy_x+15))&&((pixel_y <=enemy_y+23) && (pixel_y >=enemy_y+15)))||
                (((pixel_x <= enemy_x+38) && (pixel_x >=enemy_x+30))&&((pixel_y <=enemy_y+23) && (pixel_y >=enemy_y+15))) ||
                (((pixel_x <= enemy_x+42) && (pixel_x >=enemy_x+10))&&((pixel_y <=enemy_y+41) && (pixel_y >=enemy_y+33))) ||
                (((pixel_x <= enemy_x+18) && (pixel_x >=enemy_x+10))&&((pixel_y <=enemy_y+72) && (pixel_y >=enemy_y+33))) ||
                (((pixel_x <= enemy_x+42) && (pixel_x >=enemy_x+34))&&((pixel_y <=enemy_y+72) && (pixel_y >=enemy_y+33))) ||
                (((pixel_x <= enemy_x+42) && (pixel_x >=enemy_x+10))&&((pixel_y <=enemy_y+72) && (pixel_y >=enemy_y+64))) ||
                (((pixel_x <= enemy_x+9) && (pixel_x >=enemy_x))&&((pixel_y <=enemy_y+60) && (pixel_y >=enemy_y+51))) ||
                (((pixel_x <= enemy_x+52) && (pixel_x >=enemy_x+43))&&((pixel_y <=enemy_y+60) && (pixel_y >=enemy_y+51))) ||
                (((pixel_x <= enemy_x+24) && (pixel_x >=enemy_x+15))&&((pixel_y <=enemy_y+88) && (pixel_y >=enemy_y+73))) ||
                (((pixel_x <=enemy_x+38) && (pixel_x >=enemy_x+29))&&((pixel_y <=enemy_y+88) && (pixel_y >=enemy_y+73))) ) begin
 
red <= 4'h2; green <= 4'h2; blue <= 4'h7;
 end
//friend
else if ((((pixel_x <= friend_x+52) && (pixel_x >=friend_x))&&((pixel_y <=friend_y+8) && (pixel_y >=friend_y))) ||
                (((pixel_x <= friend_x+8) && (pixel_x >=friend_x))&&((pixel_y <=friend_y+39) && (pixel_y >=friend_y))) || 
                (((pixel_x <= friend_x+52) && (pixel_x >=friend_x+44))&&((pixel_y <=friend_y+39) && (pixel_y >=friend_y))) ||
                (((pixel_x <= friend_x+52) && (pixel_x >=friend_x))&&((pixel_y <=friend_y+39) && (pixel_y >=friend_y+31))) ||
                (((pixel_x <= friend_x+23) && (pixel_x >=friend_x+15))&&((pixel_y <=friend_y+23) && (pixel_y >=friend_y+15)))||
                (((pixel_x <= friend_x+38) && (pixel_x >=friend_x+30))&&((pixel_y <=friend_y+23) && (pixel_y >=friend_y+15))) ||
                (((pixel_x <= friend_x+42) && (pixel_x >=friend_x+10))&&((pixel_y <=friend_y+41) && (pixel_y >=friend_y+33))) ||
                (((pixel_x <= friend_x+18) && (pixel_x >=friend_x+10))&&((pixel_y <=friend_y+72) && (pixel_y >=friend_y+33))) ||
                (((pixel_x <= friend_x+42) && (pixel_x >=friend_x+34))&&((pixel_y <=friend_y+72) && (pixel_y >=friend_y+33))) ||
                (((pixel_x <= friend_x+42) && (pixel_x >=friend_x+10))&&((pixel_y <=friend_y+72) && (pixel_y >=friend_y+64))) ||
                (((pixel_x <= friend_x+9) && (pixel_x >=friend_x))&&((pixel_y <=friend_y+60) && (pixel_y >=friend_y+51))) ||
                (((pixel_x <= friend_x+52) && (pixel_x >=friend_x+43))&&((pixel_y <=friend_y+60) && (pixel_y >=friend_y+51))) ||
                (((pixel_x <= friend_x+24) && (pixel_x >=friend_x+15))&&((pixel_y <=friend_y+88) && (pixel_y >=friend_y+73))) ||
                (((pixel_x <=friend_x+38) && (pixel_x >=friend_x+29))&&((pixel_y <=friend_y+88) && (pixel_y >=friend_y+73))) ) begin
 
 red <= 4'h2; green <= 4'h7; blue <= 4'h2;
end
//text ENEMY
//E
else  if (((pixel_x >= 75) && (pixel_x <= 76)) && ((pixel_y >= 203) && (pixel_y <= 215))) begin
red <= 4'h2; green <= 4'h7; blue <= 4'h2;
end
else  if (((pixel_x >= 77) && (pixel_x <= 84)) && ((pixel_y >= 201) && (pixel_y <= 202))) begin
red <= 4'h2; green <= 4'h7; blue <= 4'h2;
end
else  if (((pixel_x >= 76) && (pixel_x <= 83)) && ((pixel_y >= 208) && (pixel_y <= 209))) begin
red <= 4'h2; green <= 4'h7; blue <= 4'h2;
end
else  if (((pixel_x >= 77) && (pixel_x <= 84)) && ((pixel_y >= 216) && (pixel_y <= 217))) begin
red <= 4'h2; green <= 4'h7; blue <= 4'h2;
end

//N
else  if (((pixel_x >= 89) && (pixel_x <= 90)) && ((pixel_y >= 201) && (pixel_y <= 217))) begin
red <= 4'h2; green <= 4'h7; blue <= 4'h2;
end
else  if (((pixel_x >= 100) && (pixel_x <= 101)) && ((pixel_y >= 201) && (pixel_y <= 217))) begin
red <= 4'h2; green <= 4'h7; blue <= 4'h2;
end
else  if (((pixel_x >= 90) && (pixel_x <= 93)) && ((pixel_y >= 203) && (pixel_y <= 206))) begin
red <= 4'h2; green <= 4'h7; blue <= 4'h2;
end
else  if (((pixel_x >= 93) && (pixel_x <= 96)) && ((pixel_y >= 206) && (pixel_y <= 209))) begin
red <= 4'h2; green <= 4'h7; blue <= 4'h2;
end
else  if (((pixel_x >= 95) && (pixel_x <= 98)) && ((pixel_y >= 209) && (pixel_y <= 212))) begin
red <= 4'h2; green <= 4'h7; blue <= 4'h2;
end
else  if (((pixel_x >= 97) && (pixel_x <= 100)) && ((pixel_y >= 212) && (pixel_y <= 215))) begin
red <= 4'h2; green <= 4'h7; blue <= 4'h2;
end

//E
else  if (((pixel_x >= 106) && (pixel_x <= 107)) && ((pixel_y >= 203) && (pixel_y <= 215))) begin
red <= 4'h2; green <= 4'h7; blue <= 4'h2;
end
else  if (((pixel_x >= 108) && (pixel_x <= 115)) && ((pixel_y >= 201) && (pixel_y <= 202))) begin
red <= 4'h2; green <= 4'h7; blue <= 4'h2;
end
else  if (((pixel_x >= 107) && (pixel_x <= 114)) && ((pixel_y >= 208) && (pixel_y <= 209))) begin
red <= 4'h2; green <= 4'h7; blue <= 4'h2;
end
else  if (((pixel_x >= 108) && (pixel_x <= 115)) && ((pixel_y >= 216) && (pixel_y <= 217))) begin
red <= 4'h2; green <= 4'h7; blue <= 4'h2;
end

//M
else  if (((pixel_x >= 119) && (pixel_x <= 120)) && ((pixel_y >= 203) && (pixel_y <= 215))) begin
red <= 4'h2; green <= 4'h7; blue <= 4'h2;
end
else  if (((pixel_x >= 132) && (pixel_x <= 133)) && ((pixel_y >= 203) && (pixel_y <= 215))) begin
red <= 4'h2; green <= 4'h7; blue <= 4'h2;
end
else  if (((pixel_x >= 120) && (pixel_x <= 123)) && ((pixel_y >= 201) && (pixel_y <= 204))) begin
red <= 4'h2; green <= 4'h7; blue <= 4'h2;
end
else  if (((pixel_x >= 122) && (pixel_x <= 125)) && ((pixel_y >= 204) && (pixel_y <= 207))) begin
red <= 4'h2; green <= 4'h7; blue <= 4'h2;
end
else  if (((pixel_x >= 125) && (pixel_x <= 128)) && ((pixel_y >= 207) && (pixel_y <= 210))) begin
red <= 4'h2; green <= 4'h7; blue <= 4'h2;
end
else  if (((pixel_x >= 127) && (pixel_x <= 130)) && ((pixel_y >= 204) && (pixel_y <= 207))) begin
red <= 4'h2; green <= 4'h7; blue <= 4'h2;
end
else  if (((pixel_x >= 106) && (pixel_x <= 107)) && ((pixel_y >= 203) && (pixel_y <= 215))) begin
red <= 4'h2; green <= 4'h7; blue <= 4'h2;
end
else  if (((pixel_x >= 129) && (pixel_x <= 132)) && ((pixel_y >= 201) && (pixel_y <= 204))) begin
red <= 4'h2; green <= 4'h7; blue <= 4'h2;
end

//Y
else  if (((pixel_x >= 137) && (pixel_x <= 140)) && ((pixel_y >= 201) && (pixel_y <= 204))) begin
red <= 4'h2; green <= 4'h7; blue <= 4'h2;
end
else  if (((pixel_x >= 139) && (pixel_x <= 142)) && ((pixel_y >= 204) && (pixel_y <= 207))) begin
red <= 4'h2; green <= 4'h7; blue <= 4'h2;
end
else  if (((pixel_x >= 143) && (pixel_x <= 144)) && ((pixel_y >= 208) && (pixel_y <= 217))) begin
red <= 4'h2; green <= 4'h7; blue <= 4'h2;
end
else  if (((pixel_x >= 142) && (pixel_x <= 145)) && ((pixel_y >= 207) && (pixel_y <= 210))) begin
red <= 4'h2; green <= 4'h7; blue <= 4'h2;
end
else  if (((pixel_x >= 145) && (pixel_x <= 148)) && ((pixel_y >= 204) && (pixel_y <= 207))) begin
red <= 4'h2; green <= 4'h7; blue <= 4'h2;
end
else  if (((pixel_x >= 147) && (pixel_x <= 150)) && ((pixel_y >= 201) && (pixel_y <= 204))) begin
red <= 4'h2; green <= 4'h7; blue <= 4'h2;
end



//text FRIEND
//F
else  if (((pixel_x >= 506) && (pixel_x <= 507)) && ((pixel_y >= 203) && (pixel_y <= 215))) begin
red <= 4'h2; green <= 4'h2; blue <= 4'h7;
end
else  if (((pixel_x >= 508) && (pixel_x <= 515)) && ((pixel_y >= 201) && (pixel_y <= 202))) begin
red <= 4'h2; green <= 4'h2; blue <= 4'h7;
end
else  if (((pixel_x >= 506) && (pixel_x <= 513)) && ((pixel_y >= 208) && (pixel_y <= 209))) begin
red <= 4'h2; green <= 4'h2; blue <= 4'h7;end

//R
else  if (((pixel_x >= 527) && (pixel_x <= 528)) && ((pixel_y >= 202) && (pixel_y <= 207))) begin
red <= 4'h2; green <= 4'h2; blue <= 4'h7;end
else  if (((pixel_x >= 518) && (pixel_x <= 519)) && ((pixel_y >= 203) && (pixel_y <= 215))) begin
red <= 4'h2; green <= 4'h2; blue <= 4'h7;end
else  if (((pixel_x >= 520) && (pixel_x <= 527)) && ((pixel_y >= 201) && (pixel_y <= 202))) begin
red <= 4'h2; green <= 4'h2; blue <= 4'h7;end
else  if (((pixel_x >= 520) && (pixel_x <= 527)) && ((pixel_y >= 208) && (pixel_y <= 209))) begin
red <= 4'h2; green <= 4'h2; blue <= 4'h7;end
else  if (((pixel_x >= 527) && (pixel_x <= 528)) && ((pixel_y >= 210) && (pixel_y <= 211))) begin
red <= 4'h2; green <= 4'h2; blue <= 4'h7;end
else  if (((pixel_x >= 528) && (pixel_x <= 529)) && ((pixel_y >= 212) && (pixel_y <= 213))) begin
red <= 4'h2; green <= 4'h2; blue <= 4'h7;end
else  if (((pixel_x >= 529) && (pixel_x <= 530)) && ((pixel_y >= 214) && (pixel_y <= 215))) begin
red <= 4'h2; green <= 4'h2; blue <= 4'h7;end
else  if (((pixel_x >= 530) && (pixel_x <= 531)) && ((pixel_y >= 216) && (pixel_y <= 217))) begin
red <= 4'h2; green <= 4'h2; blue <= 4'h7;end

//I
else  if (((pixel_x >= 534) && (pixel_x <= 535)) && ((pixel_y >= 201) && (pixel_y <= 217))) begin
red <= 4'h2; green <= 4'h2; blue <= 4'h7;end

//E
else  if (((pixel_x >= 540) && (pixel_x <= 541)) && ((pixel_y >= 203) && (pixel_y <= 215))) begin
red <= 4'h2; green <= 4'h2; blue <= 4'h7;end
else  if (((pixel_x >= 542) && (pixel_x <= 549)) && ((pixel_y >= 201) && (pixel_y <= 202))) begin
red <= 4'h2; green <= 4'h2; blue <= 4'h7;end
else  if (((pixel_x >= 541) && (pixel_x <= 548)) && ((pixel_y >= 208) && (pixel_y <= 209))) begin
red <= 4'h2; green <= 4'h2; blue <= 4'h7;end
else  if (((pixel_x >= 542) && (pixel_x <= 549)) && ((pixel_y >= 216) && (pixel_y <= 217))) begin
red <= 4'h2; green <= 4'h2; blue <= 4'h7;end

//N
else  if (((pixel_x >= 554) && (pixel_x <= 555)) && ((pixel_y >= 201) && (pixel_y <= 217))) begin
red <= 4'h2; green <= 4'h2; blue <= 4'h7;end
else  if (((pixel_x >= 566) && (pixel_x <= 567)) && ((pixel_y >= 201) && (pixel_y <= 217))) begin
red <= 4'h2; green <= 4'h2; blue <= 4'h7;end
else  if (((pixel_x >= 555) && (pixel_x <=558)) && ((pixel_y >= 203) && (pixel_y <= 206))) begin
red <= 4'h2; green <= 4'h2; blue <= 4'h7;end
else  if (((pixel_x >= 558) && (pixel_x <= 561)) && ((pixel_y >= 206) && (pixel_y <= 209))) begin
red <= 4'h2; green <= 4'h2; blue <= 4'h7;end
else  if (((pixel_x >= 561) && (pixel_x <= 564)) && ((pixel_y >= 209) && (pixel_y <= 212))) begin
red <= 4'h2; green <= 4'h2; blue <= 4'h7;end
else  if (((pixel_x >= 563) && (pixel_x <= 566)) && ((pixel_y >= 212) && (pixel_y <= 215))) begin
red <= 4'h2; green <= 4'h2; blue <= 4'h7;end

//D
else  if (((pixel_x >= 570) && (pixel_x <= 571)) && ((pixel_y >= 203) && (pixel_y <= 215))) begin
red <= 4'h2; green <= 4'h2; blue <= 4'h7;end
else  if (((pixel_x >= 580) && (pixel_x <= 581)) && ((pixel_y >= 203) && (pixel_y <= 215))) begin
red <= 4'h2; green <= 4'h2; blue <= 4'h7;end
else  if (((pixel_x >= 570) && (pixel_x <= 579)) && ((pixel_y >= 201) && (pixel_y <= 202))) begin
red <= 4'h2; green <= 4'h2; blue <= 4'h7;end
else  if (((pixel_x >= 570) && (pixel_x <= 579)) && ((pixel_y >= 216) && (pixel_y <= 217))) begin
red <= 4'h2; green <= 4'h2; blue <= 4'h7;end

    end
          
          
          
          
          
    else if (game_over==1) begin
   
    if ((((pixel_x <= 450+52) && (pixel_x >=450))&&((pixel_y <=200+8) && (pixel_y >=200))) ||
                (((pixel_x <= 450+8) && (pixel_x >=450))&&((pixel_y <=200+39) && (pixel_y >=200))) || 
                (((pixel_x <= 450+52) && (pixel_x >=450+44))&&((pixel_y <=200+39) && (pixel_y >=200))) ||
                (((pixel_x <= 450+52) && (pixel_x >=450))&&((pixel_y <=200+39) && (pixel_y >=200+31))) ||
                (((pixel_x <= 450+23) && (pixel_x >=450+15))&&((pixel_y <=200+23) && (pixel_y >=200+15)))||
                (((pixel_x <= 450+38) && (pixel_x >=450+30))&&((pixel_y <=200+23) && (pixel_y >=200+15))) ||
                (((pixel_x <= 450+42) && (pixel_x >=450+10))&&((pixel_y <=200+41) && (pixel_y >=200+33))) ||
                (((pixel_x <= 450+18) && (pixel_x >=450+10))&&((pixel_y <=200+72) && (pixel_y >=200+33))) ||
                (((pixel_x <= 450+42) && (pixel_x >=450+34))&&((pixel_y <=200+72) && (pixel_y >=200+33))) ||
                (((pixel_x <= 450+42) && (pixel_x >=450+10))&&((pixel_y <=200+72) && (pixel_y >=200+64))) ||
                (((pixel_x <= 450+9) && (pixel_x >=450))&&((pixel_y <=200+60) && (pixel_y >=200+51))) ||
                (((pixel_x <= 450+52) && (pixel_x >=450+43))&&((pixel_y <=200+60) && (pixel_y >=200+51))) ||
                (((pixel_x <= 450+24) && (pixel_x >=450+15))&&((pixel_y <=200+88) && (pixel_y >=200+73))) ||
                (((pixel_x <=450+38) && (pixel_x >=450+29))&&((pixel_y <=200+88) && (pixel_y >=200+73))) ) begin
           
    red <= 4'h2; green <= 4'h7; blue <= 4'h0;
    end
     else if (pixel_x >= 510 && pixel_y <= 110) begin
    red <= 4'h0; blue <= 4'h0; green <=4'h0;
    end
    if (((pixel_x >= 47) && (pixel_x <= 132)) && ((pixel_y >= 194) && (pixel_y <= 208))) begin
red <= 4'h0; green <= 4'h3; blue <= 4'h0;
end
else if (((pixel_x >= 47) && (pixel_x <= 64)) && ((pixel_y >= 200) && (pixel_y <= 281))) begin
red <= 4'h0; green <= 4'h3; blue <= 4'h0;
end
else if (((pixel_x >= 51) && (pixel_x <= 131)) && ((pixel_y >= 269) && (pixel_y <= 281))) begin
red <= 4'h0; green <= 4'h3; blue <= 4'h0;
end
else if (((pixel_x >= 115) && (pixel_x <= 131)) && ((pixel_y >= 233) && (pixel_y <= 276))) begin
red <= 4'h0; green <= 4'h3; blue <= 4'h0;
end
else if (((pixel_x >= 82) && (pixel_x <= 131)) && ((pixel_y >= 231) && (pixel_y <= 244))) begin
red <= 4'h0; green <= 4'h3; blue <= 4'h0;
end
else if (((pixel_x >= 154) && (pixel_x <= 169)) && ((pixel_y >= 193) && (pixel_y <= 281))) begin
red <= 4'h0; green <= 4'h3; blue <= 4'h0;
end
else if (((pixel_x >= 156) && (pixel_x <= 215)) && ((pixel_y >= 193) && (pixel_y <= 209))) begin
red <= 4'h0; green <= 4'h3; blue <= 4'h0;
end
else if (((pixel_x >= 203) && (pixel_x <= 215)) && ((pixel_y >= 197) && (pixel_y <= 283))) begin
red <= 4'h0; green <= 4'h3; blue <= 4'h0;
end
else if (((pixel_x >= 163) && (pixel_x <= 207)) && ((pixel_y >= 232) && (pixel_y <= 244))) begin
red <= 4'h0; green <= 4'h3; blue <= 4'h0;
end
else if (((pixel_x >= 228) && (pixel_x <= 243)) && ((pixel_y >= 193) && (pixel_y <= 284))) begin
red <= 4'h0; green <= 4'h3; blue <= 4'h0;
end
else if (((pixel_x >= 255) && (pixel_x <= 269)) && ((pixel_y >= 193) && (pixel_y <= 285))) begin
red <= 4'h0; green <= 4'h3; blue <= 4'h0;
end
else if (((pixel_x >= 280) && (pixel_x <= 294)) && ((pixel_y >= 193) && (pixel_y <= 285))) begin
red <= 4'h0; green <= 4'h3; blue <= 4'h0;
end
else if (((pixel_x >= 308) && (pixel_x <= 322)) && ((pixel_y >= 192) && (pixel_y <= 286))) begin
red <= 4'h0; green <= 4'h3; blue <= 4'h0;
end
else if (((pixel_x >= 313) && (pixel_x <= 367)) && ((pixel_y >= 192) && (pixel_y <= 206))) begin
red <= 4'h0; green <= 4'h3; blue <= 4'h0;
end
else if (((pixel_x >= 316) && (pixel_x <= 351)) && ((pixel_y >= 231) && (pixel_y <= 246))) begin
red <= 4'h0; green <= 4'h3; blue <= 4'h0;
end
else if (((pixel_x >= 312) && (pixel_x <= 367)) && ((pixel_y >= 272) && (pixel_y <= 286))) begin
red <= 4'h0; green <= 4'h3; blue <= 4'h0;
end
else if (((pixel_x >= 230) && (pixel_x <= 283)) && ((pixel_y >= 193) && (pixel_y <= 223))) begin
red <= 4'h0; green <= 4'h3; blue <= 4'h0;
end
else if (((pixel_x >= 283) && (pixel_x <= 369)) && ((pixel_y >= 327) && (pixel_y <= 340))) begin
red <= 4'h0; green <= 4'h3; blue <= 4'h0;
end
else if (((pixel_x >= 283) && (pixel_x <= 300)) && ((pixel_y >= 336) && (pixel_y <= 407))) begin
red <= 4'h0; green <= 4'h3; blue <= 4'h0;
end
else if (((pixel_x >= 353) && (pixel_x <= 369)) && ((pixel_y >= 335) && (pixel_y <= 409))) begin
red <= 4'h0; green <= 4'h3; blue <= 4'h0;
end
else if (((pixel_x >= 283) && (pixel_x <= 369)) && ((pixel_y >= 399) && (pixel_y <= 415))) begin
red <= 4'h0; green <= 4'h3; blue <= 4'h0;
end
else if (((pixel_x >= 386) && (pixel_x <= 402)) && ((pixel_y >= 327) && (pixel_y <= 342))) begin
red <= 4'h0; green <= 4'h3; blue <= 4'h0;
end
else if (((pixel_x >= 394) && (pixel_x <= 408)) && ((pixel_y >= 341) && (pixel_y <= 356))) begin
red <= 4'h0; green <= 4'h3; blue <= 4'h0;
end
else if (((pixel_x >= 401) && (pixel_x <= 417)) && ((pixel_y >= 355) && (pixel_y <= 374))) begin
red <= 4'h0; green <= 4'h3; blue <= 4'h0;
end
else if (((pixel_x >= 409) && (pixel_x <= 424)) && ((pixel_y >= 373) && (pixel_y <= 391))) begin
red <= 4'h0; green <= 4'h3; blue <= 4'h0;
end
else if (((pixel_x >= 416) && (pixel_x <= 431)) && ((pixel_y >= 390) && (pixel_y <= 406))) begin
red <= 4'h0; green <= 4'h3; blue <= 4'h0;
end
else if (((pixel_x >= 422) && (pixel_x <= 453)) && ((pixel_y >= 404) && (pixel_y <= 418))) begin
red <= 4'h0; green <= 4'h3; blue <= 4'h0;
end
else if (((pixel_x >= 448) && (pixel_x <= 460)) && ((pixel_y >= 390) && (pixel_y <= 407))) begin
red <= 4'h0; green <= 4'h3; blue <= 4'h0;
end
else if (((pixel_x >= 454) && (pixel_x <= 468)) && ((pixel_y >= 373) && (pixel_y <= 392))) begin
red <= 4'h0; green <= 4'h3; blue <= 4'h0;
end
else if (((pixel_x >= 460) && (pixel_x <= 476)) && ((pixel_y >= 355) && (pixel_y <= 374))) begin
red <= 4'h0; green <= 4'h3; blue <= 4'h0;
end
else if (((pixel_x >= 467) && (pixel_x <= 483)) && ((pixel_y >= 341) && (pixel_y <= 356))) begin
red <= 4'h0; green <= 4'h3; blue <= 4'h0;
end
else if (((pixel_x >= 474) && (pixel_x <= 491)) && ((pixel_y >= 327) && (pixel_y <= 342))) begin
red <= 4'h0; green <= 4'h3; blue <= 4'h0;
end
else if (((pixel_x >= 501) && (pixel_x <= 513)) && ((pixel_y >= 326) && (pixel_y <= 422))) begin
red <= 4'h0; green <= 4'h3; blue <= 4'h0;
end
else if (((pixel_x >= 504) && (pixel_x <= 554)) && ((pixel_y >= 326) && (pixel_y <= 340))) begin
red <= 4'h0; green <= 4'h3; blue <= 4'h0;
end
else if (((pixel_x >= 508) && (pixel_x <= 535)) && ((pixel_y >= 368) && (pixel_y <= 380))) begin
red <= 4'h0; green <= 4'h3; blue <= 4'h0;
end
else if (((pixel_x >= 508) && (pixel_x <= 555)) && ((pixel_y >= 409) && (pixel_y <= 422))) begin
red <= 4'h0; green <= 4'h3; blue <= 4'h0;
end
else if (((pixel_x >= 564) && (pixel_x <= 578)) && ((pixel_y >= 325) && (pixel_y <= 423))) begin
red <= 4'h0; green <= 4'h3; blue <= 4'h0;
end
else if (((pixel_x >= 569) && (pixel_x <= 621)) && ((pixel_y >= 325) && (pixel_y <= 339))) begin
red <= 4'h0; green <= 4'h3; blue <= 4'h0;
end
else if (((pixel_x >= 609) && (pixel_x <= 622)) && ((pixel_y >= 326) && (pixel_y <= 379))) begin
red <= 4'h0; green <= 4'h3; blue <= 4'h0;
end
else if (((pixel_x >= 569) && (pixel_x <= 622)) && ((pixel_y >= 369) && (pixel_y <= 383))) begin
red <= 4'h0; green <= 4'h3; blue <= 4'h0;
end
else if (((pixel_x >= 604) && (pixel_x <= 617)) && ((pixel_y >= 379) && (pixel_y <= 425))) begin
red <= 4'h0; green <= 4'h3; blue <= 4'h0;
end
    else if ((pixel_x >= 472 && pixel_x <= 480 && pixel_y >= 190 && pixel_y <= 200)|| (pixel_x >= 472 && pixel_x <= 540 && pixel_y >= 182 && pixel_y <= 190) || (pixel_x >= 532 && pixel_x <= 540 && pixel_y >= 190 && pixel_y <= 280)) begin 
    red <= 4'h0; blue <= 4'h0; green <=4'h0;
    end
    
    end
    
    
    
   else if ((pixel_x - x_add) ** 2 + (pixel_y - y_add) ** 2 <= circle_radius ** 2) begin
            red <= 4'hF; blue <= 4'h0; green <= 4'h0; // Pixel is inside the circle, set blue color
   end
//   else if ((pixel_y>= 5 && pixel_y <= 6 && ((pixel_x > 540 && pixel_x < 565) || (pixel_x > 565 && pixel_x < 581) || (pixel_x > 581 && pixel_x < 597) || (pixel_x > 597 && pixel_x < 613) || (pixel_x > 613 && pixel_x < 639)))||
//   (pixel_y>= 6 && pixel_y <= 7 && ((pixel_x > 540 && pixel_x < 547) || (pixel_x > 565 && pixel_x < 572) || ((pixel_x > 581 && pixel_x < 588) || (pixel_x > 590 && pixel_x < 597 )) || ((pixel_x > 597 && pixel_x < 604) || (pixel_x > 606 && pixel_x < 613 )) || (pixel_x > 613 && pixel_x < 639))))   
   else if (pixel_x>= 540 && pixel_y<=100) begin
   red <= 4'h0; blue <= 4'h0; green <=4'h0;end
   
   else if ((enemy1==1) && (enemy[1]))begin
red <= 4'h2; green <= 4'h2; blue <= 4'h7;
 end
 else if ((enemy1==0) && (enemy[1]) ) begin
 red <= 4'h2; green <= 4'h7; blue <= 4'h2;
// assign d_inc=0;
 end

   
   
 else if (((pixel_x >= 1) && (pixel_x <= 34)) && ((pixel_y >= 2) && (pixel_y <= 43))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 22) && (pixel_x <= 29)) && ((pixel_y >= 43) && (pixel_y <= 75))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 25) && (pixel_x <= 29)) && ((pixel_y >= 81) && (pixel_y <= 93))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 13) && (pixel_x <= 18)) && ((pixel_y >= 81) && (pixel_y <= 99))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 133) && (pixel_x <= 144)) && ((pixel_y >= 2) && (pixel_y <= 8))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 188) && (pixel_x <= 197)) && ((pixel_y >= 2) && (pixel_y <= 32))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 199) && (pixel_x <= 215)) && ((pixel_y >= 1) && (pixel_y <= 33))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 6) && (pixel_x <= 61)) && ((pixel_y >= 313) && (pixel_y <= 348))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 27) && (pixel_x <= 55)) && ((pixel_y >= 341) && (pixel_y <= 359))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 27) && (pixel_x <= 39)) && ((pixel_y >= 353) && (pixel_y <= 448))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 35) && (pixel_x <= 44)) && ((pixel_y >= 421) && (pixel_y <= 449))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 62) && (pixel_x <= 69)) && ((pixel_y >= 199) && (pixel_y <= 221))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 52) && (pixel_x <= 65)) && ((pixel_y >= 182) && (pixel_y <= 203))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 42) && (pixel_x <= 62)) && ((pixel_y >= 200) && (pixel_y <= 242))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 53) && (pixel_x <= 62)) && ((pixel_y >= 240) && (pixel_y <= 322))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 54) && (pixel_x <= 61)) && ((pixel_y >= 274) && (pixel_y <= 284))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 43) && (pixel_x <= 54)) && ((pixel_y >= 275) && (pixel_y <= 316))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 45) && (pixel_x <= 56)) && ((pixel_y >= 256) && (pixel_y <= 269))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 16) && (pixel_x <= 18)) && ((pixel_y >= 222) && (pixel_y <= 269))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 30) && (pixel_x <= 38)) && ((pixel_y >= 253) && (pixel_y <= 319))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 35) && (pixel_x <= 44)) && ((pixel_y >= 291) && (pixel_y <= 317))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 30) && (pixel_x <= 35)) && ((pixel_y >= 288) && (pixel_y <= 309))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 6) && (pixel_x <= 33)) && ((pixel_y >= 290) && (pixel_y <= 303))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 178) && (pixel_x <= 181)) && ((pixel_y >= 2) && (pixel_y <= 29))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 174) && (pixel_x <= 182)) && ((pixel_y >= 27) && (pixel_y <= 102))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 156) && (pixel_x <= 178)) && ((pixel_y >= 78) && (pixel_y <= 88))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 132) && (pixel_x <= 159)) && ((pixel_y >= 90) && (pixel_y <= 135))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 150) && (pixel_x <= 164)) && ((pixel_y >= 82) && (pixel_y <= 107))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 125) && (pixel_x <= 146)) && ((pixel_y >= 134) && (pixel_y <= 190))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 141) && (pixel_x <= 160)) && ((pixel_y >= 157) && (pixel_y <= 190))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 118) && (pixel_x <= 153)) && ((pixel_y >= 185) && (pixel_y <= 396))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 109) && (pixel_x <= 125)) && ((pixel_y >= 210) && (pixel_y <= 250))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 144) && (pixel_x <= 159)) && ((pixel_y >= 285) && (pixel_y <= 382))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 156) && (pixel_x <= 166)) && ((pixel_y >= 310) && (pixel_y <= 449))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 161) && (pixel_x <= 179)) && ((pixel_y >= 352) && (pixel_y <= 435))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 128) && (pixel_x <= 156)) && ((pixel_y >= 385) && (pixel_y <= 449))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 146) && (pixel_x <= 160)) && ((pixel_y >= 373) && (pixel_y <= 396))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 118) && (pixel_x <= 123)) && ((pixel_y >= 386) && (pixel_y <= 449))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 120) && (pixel_x <= 132)) && ((pixel_y >= 417) && (pixel_y <= 429))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 104) && (pixel_x <= 122)) && ((pixel_y >= 430) && (pixel_y <= 449))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 113) && (pixel_x <= 120)) && ((pixel_y >= 419) && (pixel_y <= 436))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 218) && (pixel_x <= 221)) && ((pixel_y >= 14) && (pixel_y <= 107))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 191) && (pixel_x <= 219)) && ((pixel_y >= 107) && (pixel_y <= 112))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 194) && (pixel_x <= 205)) && ((pixel_y >= 112) && (pixel_y <= 167))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 201) && (pixel_x <= 210)) && ((pixel_y >= 212) && (pixel_y <= 307))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 233) && (pixel_x <= 236)) && ((pixel_y >= 17) && (pixel_y <= 127))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 227) && (pixel_x <= 246)) && ((pixel_y >= 127) && (pixel_y <= 148))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 228) && (pixel_x <= 242)) && ((pixel_y >= 146) && (pixel_y <= 157))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 228) && (pixel_x <= 238)) && ((pixel_y >= 155) && (pixel_y <= 352))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 252) && (pixel_x <= 265)) && ((pixel_y >= 130) && (pixel_y <= 176))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 244) && (pixel_x <= 282)) && ((pixel_y >= 169) && (pixel_y <= 188))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 245) && (pixel_x <= 268)) && ((pixel_y >= 169) && (pixel_y <= 329))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 230) && (pixel_x <= 257)) && ((pixel_y >= 266) && (pixel_y <= 352))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 214) && (pixel_x <= 232)) && ((pixel_y >= 361) && (pixel_y <= 375))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 219) && (pixel_x <= 233)) && ((pixel_y >= 373) && (pixel_y <= 417))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 175) && (pixel_x <= 182)) && ((pixel_y >= 114) && (pixel_y <= 130))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 256) && (pixel_x <= 263)) && ((pixel_y >= 34) && (pixel_y <= 93))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 274) && (pixel_x <= 284)) && ((pixel_y >= 30) && (pixel_y <= 96))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 281) && (pixel_x <= 293)) && ((pixel_y >= 32) && (pixel_y <= 96))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 287) && (pixel_x <= 289)) && ((pixel_y >= 7) && (pixel_y <= 35))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 289) && (pixel_x <= 290)) && ((pixel_y >= 30) && (pixel_y <= 30))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 287) && (pixel_x <= 293)) && ((pixel_y >= 28) && (pixel_y <= 33))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 90) && (pixel_x <= 93)) && ((pixel_y >= 36) && (pixel_y <= 46))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 82) && (pixel_x <= 83)) && ((pixel_y >= 38) && (pixel_y <= 114))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 50) && (pixel_x <= 51)) && ((pixel_y >= 356) && (pixel_y <= 402))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 51) && (pixel_x <= 53)) && ((pixel_y >= 426) && (pixel_y <= 443))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 306) && (pixel_x <= 309)) && ((pixel_y >= 30) && (pixel_y <= 111))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 309) && (pixel_x <= 313)) && ((pixel_y >= 57) && (pixel_y <= 110))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 327) && (pixel_x <= 337)) && ((pixel_y >= 1) && (pixel_y <= 24))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 345) && (pixel_x <= 365)) && ((pixel_y >= 2) && (pixel_y <= 83))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 334) && (pixel_x <= 373)) && ((pixel_y >= 81) && (pixel_y <= 170))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 370) && (pixel_x <= 382)) && ((pixel_y >= 139) && (pixel_y <= 170))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 343) && (pixel_x <= 380)) && ((pixel_y >= 168) && (pixel_y <= 342))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 319) && (pixel_x <= 346)) && ((pixel_y >= 195) && (pixel_y <= 214))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 345) && (pixel_x <= 381)) && ((pixel_y >= 339) && (pixel_y <= 426))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 350) && (pixel_x <= 382)) && ((pixel_y >= 424) && (pixel_y <= 449))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 378) && (pixel_x <= 392)) && ((pixel_y >= 342) && (pixel_y <= 449))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 389) && (pixel_x <= 405)) && ((pixel_y >= 364) && (pixel_y <= 449))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 403) && (pixel_x <= 432)) && ((pixel_y >= 342) && (pixel_y <= 379))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 421) && (pixel_x <= 432)) && ((pixel_y >= 301) && (pixel_y <= 347))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 415) && (pixel_x <= 417)) && ((pixel_y >= 296) && (pixel_y <= 344))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 269) && (pixel_x <= 282)) && ((pixel_y >= 368) && (pixel_y <= 410))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 281) && (pixel_x <= 301)) && ((pixel_y >= 371) && (pixel_y <= 376))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 286) && (pixel_x <= 301)) && ((pixel_y >= 374) && (pixel_y <= 393))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 294) && (pixel_x <= 296)) && ((pixel_y >= 393) && (pixel_y <= 448))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 295) && (pixel_x <= 313)) && ((pixel_y >= 426) && (pixel_y <= 449))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 286) && (pixel_x <= 289)) && ((pixel_y >= 388) && (pixel_y <= 449))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 258) && (pixel_x <= 260)) && ((pixel_y >= 366) && (pixel_y <= 407))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 217) && (pixel_x <= 230)) && ((pixel_y >= 304) && (pixel_y <= 348))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 222) && (pixel_x <= 224)) && ((pixel_y >= 416) && (pixel_y <= 448))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 275) && (pixel_x <= 279)) && ((pixel_y >= 187) && (pixel_y <= 268))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 277) && (pixel_x <= 280)) && ((pixel_y >= 276) && (pixel_y <= 331))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 272) && (pixel_x <= 275)) && ((pixel_y >= 344) && (pixel_y <= 374))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 175) && (pixel_x <= 179)) && ((pixel_y >= 314) && (pixel_y <= 355))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 183) && (pixel_x <= 189)) && ((pixel_y >= 289) && (pixel_y <= 304))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 430) && (pixel_x <= 430)) && ((pixel_y >= 352) && (pixel_y <= 352))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 430) && (pixel_x <= 440)) && ((pixel_y >= 351) && (pixel_y <= 419))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 437) && (pixel_x <= 445)) && ((pixel_y >= 370) && (pixel_y <= 418))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 443) && (pixel_x <= 447)) && ((pixel_y >= 386) && (pixel_y <= 403))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 415) && (pixel_x <= 434)) && ((pixel_y >= 388) && (pixel_y <= 415))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 416) && (pixel_x <= 422)) && ((pixel_y >= 374) && (pixel_y <= 390))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 431) && (pixel_x <= 426)) && ((pixel_y >= 375) && (pixel_y <= 375))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 426) && (pixel_x <= 433)) && ((pixel_y >= 377) && (pixel_y <= 391))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 341) && (pixel_x <= 350)) && ((pixel_y >= 351) && (pixel_y <= 387))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 311) && (pixel_x <= 328)) && ((pixel_y >= 394) && (pixel_y <= 397))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 322) && (pixel_x <= 348)) && ((pixel_y >= 396) && (pixel_y <= 404))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 320) && (pixel_x <= 330)) && ((pixel_y >= 396) && (pixel_y <= 422))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 311) && (pixel_x <= 322)) && ((pixel_y >= 416) && (pixel_y <= 420))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 326) && (pixel_x <= 329)) && ((pixel_y >= 421) && (pixel_y <= 449))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 330) && (pixel_x <= 349)) && ((pixel_y >= 411) && (pixel_y <= 425))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 403) && (pixel_x <= 403)) && ((pixel_y >= 412) && (pixel_y <= 412))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 401) && (pixel_x <= 417)) && ((pixel_y >= 408) && (pixel_y <= 416))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 407) && (pixel_x <= 413)) && ((pixel_y >= 92) && (pixel_y <= 118))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 417) && (pixel_x <= 430)) && ((pixel_y >= 91) && (pixel_y <= 118))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 369) && (pixel_x <= 375)) && ((pixel_y >= 1) && (pixel_y <= 85))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 334) && (pixel_x <= 338)) && ((pixel_y >= 64) && (pixel_y <= 87))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 339) && (pixel_x <= 343)) && ((pixel_y >= 60) && (pixel_y <= 81))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 426) && (pixel_x <= 429)) && ((pixel_y >= 116) && (pixel_y <= 175))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 418) && (pixel_x <= 419)) && ((pixel_y >= 113) && (pixel_y <= 174))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 419) && (pixel_x <= 428)) && ((pixel_y >= 170) && (pixel_y <= 207))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 427) && (pixel_x <= 433)) && ((pixel_y >= 174) && (pixel_y <= 187))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 416) && (pixel_x <= 419)) && ((pixel_y >= 180) && (pixel_y <= 261))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 427) && (pixel_x <= 430)) && ((pixel_y >= 204) && (pixel_y <= 305))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 468) && (pixel_x <= 481)) && ((pixel_y >= 0) && (pixel_y <= 126))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 469) && (pixel_x <= 474)) && ((pixel_y >= 123) && (pixel_y <= 230))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 473) && (pixel_x <= 481)) && ((pixel_y >= 176) && (pixel_y <= 184))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 456) && (pixel_x <= 463)) && ((pixel_y >= 156) && (pixel_y <= 172))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 447) && (pixel_x <= 453)) && ((pixel_y >= 158) && (pixel_y <= 173))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 440) && (pixel_x <= 451)) && ((pixel_y >= 167) && (pixel_y <= 172))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 486) && (pixel_x <= 497)) && ((pixel_y >= 0) && (pixel_y <= 11))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 533) && (pixel_x <= 537)) && ((pixel_y >= 2) && (pixel_y <= 61))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 523) && (pixel_x <= 538)) && ((pixel_y >= 42) && (pixel_y <= 142))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 535) && (pixel_x <= 549)) && ((pixel_y >= 59) && (pixel_y <= 140))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 545) && (pixel_x <= 553)) && ((pixel_y >= 81) && (pixel_y <= 170))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 553) && (pixel_x <= 517)) && ((pixel_y >= 170) && (pixel_y <= 79))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 515) && (pixel_x <= 527)) && ((pixel_y >= 80) && (pixel_y <= 140))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 524) && (pixel_x <= 532)) && ((pixel_y >= 139) && (pixel_y <= 241))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 517) && (pixel_x <= 526)) && ((pixel_y >= 170) && (pixel_y <= 240))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 512) && (pixel_x <= 519)) && ((pixel_y >= 187) && (pixel_y <= 240))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 498) && (pixel_x <= 509)) && ((pixel_y >= 186) && (pixel_y <= 242))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 487) && (pixel_x <= 514)) && ((pixel_y >= 190) && (pixel_y <= 199))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 488) && (pixel_x <= 494)) && ((pixel_y >= 194) && (pixel_y <= 247))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 511) && (pixel_x <= 514)) && ((pixel_y >= 322) && (pixel_y <= 358))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 503) && (pixel_x <= 506)) && ((pixel_y >= 240) && (pixel_y <= 302))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 529) && (pixel_x <= 531)) && ((pixel_y >= 236) && (pixel_y <= 301))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 530) && (pixel_x <= 531)) && ((pixel_y >= 324) && (pixel_y <= 360))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 502) && (pixel_x <= 505)) && ((pixel_y >= 384) && (pixel_y <= 449))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 504) && (pixel_x <= 511)) && ((pixel_y >= 422) && (pixel_y <= 449))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 551) && (pixel_x <= 563)) && ((pixel_y >= 307) && (pixel_y <= 411))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 539) && (pixel_x <= 543)) && ((pixel_y >= 323) && (pixel_y <= 361))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 541) && (pixel_x <= 561)) && ((pixel_y >= 351) && (pixel_y <= 363))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 543) && (pixel_x <= 557)) && ((pixel_y >= 360) && (pixel_y <= 449))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 533) && (pixel_x <= 543)) && ((pixel_y >= 432) && (pixel_y <= 439))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 531) && (pixel_x <= 533)) && ((pixel_y >= 434) && (pixel_y <= 434))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 535) && (pixel_x <= 539)) && ((pixel_y >= 436) && (pixel_y <= 449))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 536) && (pixel_x <= 547)) && ((pixel_y >= 139) && (pixel_y <= 172))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 529) && (pixel_x <= 541)) && ((pixel_y >= 169) && (pixel_y <= 242))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 545) && (pixel_x <= 566)) && ((pixel_y >= 179) && (pixel_y <= 254))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 541) && (pixel_x <= 552)) && ((pixel_y >= 191) && (pixel_y <= 251))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 551) && (pixel_x <= 551)) && ((pixel_y >= 132) && (pixel_y <= 135))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 551) && (pixel_x <= 562)) && ((pixel_y >= 134) && (pixel_y <= 170))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 552) && (pixel_x <= 562)) && ((pixel_y >= 121) && (pixel_y <= 129))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 566) && (pixel_x <= 569)) && ((pixel_y >= 136) && (pixel_y <= 167))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 448) && (pixel_x <= 463)) && ((pixel_y >= 110) && (pixel_y <= 123))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 300) && (pixel_x <= 305)) && ((pixel_y >= 172) && (pixel_y <= 188))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 274) && (pixel_x <= 281)) && ((pixel_y >= 157) && (pixel_y <= 171))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 281) && (pixel_x <= 301)) && ((pixel_y >= 181) && (pixel_y <= 187))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 293) && (pixel_x <= 297)) && ((pixel_y >= 172) && (pixel_y <= 183))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 299) && (pixel_x <= 302)) && ((pixel_y >= 185) && (pixel_y <= 216))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 589) && (pixel_x <= 638)) && ((pixel_y >= 0) && (pixel_y <= 49))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 607) && (pixel_x <= 638)) && ((pixel_y >= 47) && (pixel_y <= 121))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 606) && (pixel_x <= 609)) && ((pixel_y >= 118) && (pixel_y <= 260))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 597) && (pixel_x <= 607)) && ((pixel_y >= 156) && (pixel_y <= 259))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 582) && (pixel_x <= 587)) && ((pixel_y >= 158) && (pixel_y <= 265))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 565) && (pixel_x <= 602)) && ((pixel_y >= 232) && (pixel_y <= 244))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 562) && (pixel_x <= 604)) && ((pixel_y >= 223) && (pixel_y <= 230))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 558) && (pixel_x <= 576)) && ((pixel_y >= 351) && (pixel_y <= 358))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 612) && (pixel_x <= 612)) && ((pixel_y >= 404) && (pixel_y <= 404))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 611) && (pixel_x <= 614)) && ((pixel_y >= 308) && (pixel_y <= 400))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 612) && (pixel_x <= 639)) && ((pixel_y >= 311) && (pixel_y <= 335))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 614) && (pixel_x <= 623)) && ((pixel_y >= 332) && (pixel_y <= 387))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 619) && (pixel_x <= 628)) && ((pixel_y >= 327) && (pixel_y <= 370))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 617) && (pixel_x <= 621)) && ((pixel_y >= 383) && (pixel_y <= 398))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 617) && (pixel_x <= 619)) && ((pixel_y >= 302) && (pixel_y <= 312))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 622) && (pixel_x <= 627)) && ((pixel_y >= 303) && (pixel_y <= 312))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 633) && (pixel_x <= 637)) && ((pixel_y >= 305) && (pixel_y <= 313))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 621) && (pixel_x <= 633)) && ((pixel_y >= 112) && (pixel_y <= 130))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 74) && (pixel_x <= 78)) && ((pixel_y >= 400) && (pixel_y <= 440))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 488) && (pixel_x <= 489)) && ((pixel_y >= 126) && (pixel_y <= 127))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 490) && (pixel_x <= 491)) && ((pixel_y >= 128) && (pixel_y <= 129))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 490) && (pixel_x <= 491)) && ((pixel_y >= 128) && (pixel_y <= 129))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 490) && (pixel_x <= 491)) && ((pixel_y >= 128) && (pixel_y <= 129))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 490) && (pixel_x <= 491)) && ((pixel_y >= 129) && (pixel_y <= 130))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 490) && (pixel_x <= 491)) && ((pixel_y >= 130) && (pixel_y <= 131))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 490) && (pixel_x <= 491)) && ((pixel_y >= 130) && (pixel_y <= 131))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 490) && (pixel_x <= 491)) && ((pixel_y >= 130) && (pixel_y <= 131))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 490) && (pixel_x <= 491)) && ((pixel_y >= 130) && (pixel_y <= 131))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 490) && (pixel_x <= 491)) && ((pixel_y >= 130) && (pixel_y <= 131))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 490) && (pixel_x <= 491)) && ((pixel_y >= 134) && (pixel_y <= 135))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 490) && (pixel_x <= 491)) && ((pixel_y >= 135) && (pixel_y <= 136))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 490) && (pixel_x <= 491)) && ((pixel_y >= 135) && (pixel_y <= 136))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 490) && (pixel_x <= 491)) && ((pixel_y >= 137) && (pixel_y <= 138))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 490) && (pixel_x <= 491)) && ((pixel_y >= 140) && (pixel_y <= 141))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 490) && (pixel_x <= 491)) && ((pixel_y >= 144) && (pixel_y <= 145))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 490) && (pixel_x <= 491)) && ((pixel_y >= 146) && (pixel_y <= 147))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 490) && (pixel_x <= 491)) && ((pixel_y >= 146) && (pixel_y <= 147))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 490) && (pixel_x <= 491)) && ((pixel_y >= 150) && (pixel_y <= 151))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 490) && (pixel_x <= 491)) && ((pixel_y >= 153) && (pixel_y <= 154))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 490) && (pixel_x <= 491)) && ((pixel_y >= 157) && (pixel_y <= 158))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 490) && (pixel_x <= 491)) && ((pixel_y >= 158) && (pixel_y <= 159))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 490) && (pixel_x <= 491)) && ((pixel_y >= 158) && (pixel_y <= 159))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 490) && (pixel_x <= 491)) && ((pixel_y >= 158) && (pixel_y <= 159))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 490) && (pixel_x <= 491)) && ((pixel_y >= 158) && (pixel_y <= 159))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 490) && (pixel_x <= 491)) && ((pixel_y >= 158) && (pixel_y <= 159))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 490) && (pixel_x <= 491)) && ((pixel_y >= 158) && (pixel_y <= 159))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 490) && (pixel_x <= 491)) && ((pixel_y >= 158) && (pixel_y <= 159))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 490) && (pixel_x <= 491)) && ((pixel_y >= 158) && (pixel_y <= 159))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 490) && (pixel_x <= 491)) && ((pixel_y >= 158) && (pixel_y <= 159))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 490) && (pixel_x <= 491)) && ((pixel_y >= 158) && (pixel_y <= 159))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 490) && (pixel_x <= 491)) && ((pixel_y >= 158) && (pixel_y <= 159))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 490) && (pixel_x <= 491)) && ((pixel_y >= 158) && (pixel_y <= 159))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 490) && (pixel_x <= 491)) && ((pixel_y >= 152) && (pixel_y <= 153))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 496) && (pixel_x <= 497)) && ((pixel_y >= 138) && (pixel_y <= 139))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 502) && (pixel_x <= 503)) && ((pixel_y >= 124) && (pixel_y <= 125))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 509) && (pixel_x <= 510)) && ((pixel_y >= 110) && (pixel_y <= 111))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 509) && (pixel_x <= 510)) && ((pixel_y >= 106) && (pixel_y <= 107))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 509) && (pixel_x <= 510)) && ((pixel_y >= 100) && (pixel_y <= 101))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 509) && (pixel_x <= 510)) && ((pixel_y >= 96) && (pixel_y <= 97))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 509) && (pixel_x <= 510)) && ((pixel_y >= 94) && (pixel_y <= 95))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 509) && (pixel_x <= 510)) && ((pixel_y >= 91) && (pixel_y <= 92))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 509) && (pixel_x <= 510)) && ((pixel_y >= 87) && (pixel_y <= 88))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 507) && (pixel_x <= 508)) && ((pixel_y >= 86) && (pixel_y <= 87))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 507) && (pixel_x <= 508)) && ((pixel_y >= 86) && (pixel_y <= 87))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 505) && (pixel_x <= 506)) && ((pixel_y >= 86) && (pixel_y <= 87))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 497) && (pixel_x <= 498)) && ((pixel_y >= 110) && (pixel_y <= 111))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 488) && (pixel_x <= 489)) && ((pixel_y >= 156) && (pixel_y <= 157))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 485) && (pixel_x <= 486)) && ((pixel_y >= 174) && (pixel_y <= 175))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 485) && (pixel_x <= 486)) && ((pixel_y >= 178) && (pixel_y <= 179))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 485) && (pixel_x <= 486)) && ((pixel_y >= 178) && (pixel_y <= 179))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 487) && (pixel_x <= 488)) && ((pixel_y >= 173) && (pixel_y <= 174))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 490) && (pixel_x <= 491)) && ((pixel_y >= 146) && (pixel_y <= 147))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 490) && (pixel_x <= 491)) && ((pixel_y >= 109) && (pixel_y <= 110))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 490) && (pixel_x <= 491)) && ((pixel_y >= 93) && (pixel_y <= 94))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 490) && (pixel_x <= 491)) && ((pixel_y >= 93) && (pixel_y <= 94))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 490) && (pixel_x <= 491)) && ((pixel_y >= 93) && (pixel_y <= 94))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 500) && (pixel_x <= 501)) && ((pixel_y >= 108) && (pixel_y <= 109))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 517) && (pixel_x <= 518)) && ((pixel_y >= 147) && (pixel_y <= 148))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 521) && (pixel_x <= 522)) && ((pixel_y >= 158) && (pixel_y <= 159))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 521) && (pixel_x <= 522)) && ((pixel_y >= 158) && (pixel_y <= 159))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 521) && (pixel_x <= 522)) && ((pixel_y >= 158) && (pixel_y <= 159))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 521) && (pixel_x <= 522)) && ((pixel_y >= 158) && (pixel_y <= 159))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 521) && (pixel_x <= 522)) && ((pixel_y >= 158) && (pixel_y <= 159))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 521) && (pixel_x <= 522)) && ((pixel_y >= 158) && (pixel_y <= 159))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 521) && (pixel_x <= 522)) && ((pixel_y >= 142) && (pixel_y <= 143))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 508) && (pixel_x <= 509)) && ((pixel_y >= 86) && (pixel_y <= 87))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 498) && (pixel_x <= 499)) && ((pixel_y >= 48) && (pixel_y <= 49))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 497) && (pixel_x <= 498)) && ((pixel_y >= 44) && (pixel_y <= 45))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 497) && (pixel_x <= 498)) && ((pixel_y >= 44) && (pixel_y <= 45))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 478) && (pixel_x <= 479)) && ((pixel_y >= 103) && (pixel_y <= 104))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 456) && (pixel_x <= 457)) && ((pixel_y >= 221) && (pixel_y <= 222))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 457) && (pixel_x <= 458)) && ((pixel_y >= 265) && (pixel_y <= 266))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 470) && (pixel_x <= 471)) && ((pixel_y >= 266) && (pixel_y <= 267))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 503) && (pixel_x <= 504)) && ((pixel_y >= 238) && (pixel_y <= 239))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 540) && (pixel_x <= 541)) && ((pixel_y >= 136) && (pixel_y <= 137))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 545) && (pixel_x <= 546)) && ((pixel_y >= 73) && (pixel_y <= 74))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 534) && (pixel_x <= 535)) && ((pixel_y >= 64) && (pixel_y <= 65))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 514) && (pixel_x <= 515)) && ((pixel_y >= 82) && (pixel_y <= 83))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 480) && (pixel_x <= 481)) && ((pixel_y >= 163) && (pixel_y <= 164))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 477) && (pixel_x <= 478)) && ((pixel_y >= 183) && (pixel_y <= 184))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 483) && (pixel_x <= 484)) && ((pixel_y >= 185) && (pixel_y <= 186))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 500) && (pixel_x <= 501)) && ((pixel_y >= 155) && (pixel_y <= 156))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 488) && (pixel_x <= 489)) && ((pixel_y >= 108) && (pixel_y <= 109))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 475) && (pixel_x <= 476)) && ((pixel_y >= 104) && (pixel_y <= 105))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 467) && (pixel_x <= 468)) && ((pixel_y >= 132) && (pixel_y <= 133))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 464) && (pixel_x <= 465)) && ((pixel_y >= 178) && (pixel_y <= 179))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 472) && (pixel_x <= 473)) && ((pixel_y >= 185) && (pixel_y <= 186))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 478) && (pixel_x <= 479)) && ((pixel_y >= 187) && (pixel_y <= 188))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 480) && (pixel_x <= 481)) && ((pixel_y >= 185) && (pixel_y <= 186))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 480) && (pixel_x <= 481)) && ((pixel_y >= 201) && (pixel_y <= 202))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 462) && (pixel_x <= 463)) && ((pixel_y >= 308) && (pixel_y <= 309))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 453) && (pixel_x <= 454)) && ((pixel_y >= 339) && (pixel_y <= 340))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 453) && (pixel_x <= 454)) && ((pixel_y >= 340) && (pixel_y <= 341))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 451) && (pixel_x <= 452)) && ((pixel_y >= 311) && (pixel_y <= 312))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 444) && (pixel_x <= 445)) && ((pixel_y >= 220) && (pixel_y <= 221))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 444) && (pixel_x <= 445)) && ((pixel_y >= 212) && (pixel_y <= 213))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 444) && (pixel_x <= 445)) && ((pixel_y >= 213) && (pixel_y <= 214))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 444) && (pixel_x <= 445)) && ((pixel_y >= 259) && (pixel_y <= 260))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 444) && (pixel_x <= 445)) && ((pixel_y >= 280) && (pixel_y <= 281))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 444) && (pixel_x <= 445)) && ((pixel_y >= 280) && (pixel_y <= 281))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 444) && (pixel_x <= 445)) && ((pixel_y >= 277) && (pixel_y <= 278))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 447) && (pixel_x <= 448)) && ((pixel_y >= 250) && (pixel_y <= 251))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 447) && (pixel_x <= 448)) && ((pixel_y >= 250) && (pixel_y <= 251))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 447) && (pixel_x <= 448)) && ((pixel_y >= 255) && (pixel_y <= 256))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 447) && (pixel_x <= 448)) && ((pixel_y >= 277) && (pixel_y <= 278))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 447) && (pixel_x <= 448)) && ((pixel_y >= 278) && (pixel_y <= 279))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 445) && (pixel_x <= 446)) && ((pixel_y >= 267) && (pixel_y <= 268))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 438) && (pixel_x <= 439)) && ((pixel_y >= 248) && (pixel_y <= 249))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 438) && (pixel_x <= 439)) && ((pixel_y >= 248) && (pixel_y <= 249))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 438) && (pixel_x <= 439)) && ((pixel_y >= 257) && (pixel_y <= 258))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 438) && (pixel_x <= 439)) && ((pixel_y >= 263) && (pixel_y <= 264))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 438) && (pixel_x <= 439)) && ((pixel_y >= 263) && (pixel_y <= 264))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 438) && (pixel_x <= 439)) && ((pixel_y >= 263) && (pixel_y <= 264))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 438) && (pixel_x <= 439)) && ((pixel_y >= 257) && (pixel_y <= 258))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 438) && (pixel_x <= 439)) && ((pixel_y >= 251) && (pixel_y <= 252))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 438) && (pixel_x <= 439)) && ((pixel_y >= 260) && (pixel_y <= 261))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 434) && (pixel_x <= 435)) && ((pixel_y >= 301) && (pixel_y <= 302))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 432) && (pixel_x <= 433)) && ((pixel_y >= 302) && (pixel_y <= 303))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 432) && (pixel_x <= 433)) && ((pixel_y >= 300) && (pixel_y <= 301))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 436) && (pixel_x <= 437)) && ((pixel_y >= 258) && (pixel_y <= 259))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 438) && (pixel_x <= 439)) && ((pixel_y >= 254) && (pixel_y <= 255))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 438) && (pixel_x <= 439)) && ((pixel_y >= 256) && (pixel_y <= 257))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 441) && (pixel_x <= 442)) && ((pixel_y >= 283) && (pixel_y <= 284))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 441) && (pixel_x <= 442)) && ((pixel_y >= 290) && (pixel_y <= 291))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 441) && (pixel_x <= 442)) && ((pixel_y >= 290) && (pixel_y <= 291))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 441) && (pixel_x <= 442)) && ((pixel_y >= 280) && (pixel_y <= 281))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 441) && (pixel_x <= 442)) && ((pixel_y >= 251) && (pixel_y <= 252))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 441) && (pixel_x <= 442)) && ((pixel_y >= 251) && (pixel_y <= 252))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 443) && (pixel_x <= 444)) && ((pixel_y >= 272) && (pixel_y <= 273))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 443) && (pixel_x <= 444)) && ((pixel_y >= 292) && (pixel_y <= 293))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 443) && (pixel_x <= 444)) && ((pixel_y >= 294) && (pixel_y <= 295))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 443) && (pixel_x <= 444)) && ((pixel_y >= 286) && (pixel_y <= 287))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 443) && (pixel_x <= 444)) && ((pixel_y >= 237) && (pixel_y <= 238))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 443) && (pixel_x <= 444)) && ((pixel_y >= 235) && (pixel_y <= 236))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 443) && (pixel_x <= 444)) && ((pixel_y >= 246) && (pixel_y <= 247))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 443) && (pixel_x <= 444)) && ((pixel_y >= 272) && (pixel_y <= 273))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 443) && (pixel_x <= 444)) && ((pixel_y >= 277) && (pixel_y <= 278))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 443) && (pixel_x <= 444)) && ((pixel_y >= 277) && (pixel_y <= 278))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 439) && (pixel_x <= 440)) && ((pixel_y >= 257) && (pixel_y <= 258))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 437) && (pixel_x <= 438)) && ((pixel_y >= 236) && (pixel_y <= 237))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 437) && (pixel_x <= 438)) && ((pixel_y >= 234) && (pixel_y <= 235))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 437) && (pixel_x <= 438)) && ((pixel_y >= 247) && (pixel_y <= 248))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 437) && (pixel_x <= 438)) && ((pixel_y >= 272) && (pixel_y <= 273))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 437) && (pixel_x <= 438)) && ((pixel_y >= 276) && (pixel_y <= 277))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 437) && (pixel_x <= 438)) && ((pixel_y >= 276) && (pixel_y <= 277))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 436) && (pixel_x <= 437)) && ((pixel_y >= 273) && (pixel_y <= 274))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 435) && (pixel_x <= 436)) && ((pixel_y >= 269) && (pixel_y <= 270))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 435) && (pixel_x <= 436)) && ((pixel_y >= 272) && (pixel_y <= 273))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 435) && (pixel_x <= 436)) && ((pixel_y >= 294) && (pixel_y <= 295))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 435) && (pixel_x <= 436)) && ((pixel_y >= 296) && (pixel_y <= 297))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 435) && (pixel_x <= 436)) && ((pixel_y >= 296) && (pixel_y <= 297))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 449) && (pixel_x <= 450)) && ((pixel_y >= 275) && (pixel_y <= 276))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 472) && (pixel_x <= 473)) && ((pixel_y >= 220) && (pixel_y <= 221))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 474) && (pixel_x <= 475)) && ((pixel_y >= 209) && (pixel_y <= 210))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 474) && (pixel_x <= 475)) && ((pixel_y >= 209) && (pixel_y <= 210))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 474) && (pixel_x <= 475)) && ((pixel_y >= 226) && (pixel_y <= 227))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 466) && (pixel_x <= 467)) && ((pixel_y >= 312) && (pixel_y <= 313))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 462) && (pixel_x <= 463)) && ((pixel_y >= 346) && (pixel_y <= 347))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 462) && (pixel_x <= 463)) && ((pixel_y >= 346) && (pixel_y <= 347))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 462) && (pixel_x <= 463)) && ((pixel_y >= 346) && (pixel_y <= 347))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 459) && (pixel_x <= 460)) && ((pixel_y >= 315) && (pixel_y <= 316))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 455) && (pixel_x <= 456)) && ((pixel_y >= 262) && (pixel_y <= 263))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 452) && (pixel_x <= 453)) && ((pixel_y >= 242) && (pixel_y <= 243))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 452) && (pixel_x <= 453)) && ((pixel_y >= 242) && (pixel_y <= 243))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 452) && (pixel_x <= 453)) && ((pixel_y >= 244) && (pixel_y <= 245))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 452) && (pixel_x <= 453)) && ((pixel_y >= 296) && (pixel_y <= 297))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 452) && (pixel_x <= 453)) && ((pixel_y >= 305) && (pixel_y <= 306))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 452) && (pixel_x <= 453)) && ((pixel_y >= 305) && (pixel_y <= 306))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 445) && (pixel_x <= 446)) && ((pixel_y >= 285) && (pixel_y <= 286))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 432) && (pixel_x <= 433)) && ((pixel_y >= 252) && (pixel_y <= 253))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 432) && (pixel_x <= 433)) && ((pixel_y >= 252) && (pixel_y <= 253))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 432) && (pixel_x <= 433)) && ((pixel_y >= 275) && (pixel_y <= 276))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 432) && (pixel_x <= 433)) && ((pixel_y >= 291) && (pixel_y <= 292))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 432) && (pixel_x <= 433)) && ((pixel_y >= 293) && (pixel_y <= 294))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 433) && (pixel_x <= 434)) && ((pixel_y >= 291) && (pixel_y <= 292))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 435) && (pixel_x <= 436)) && ((pixel_y >= 245) && (pixel_y <= 246))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 435) && (pixel_x <= 436)) && ((pixel_y >= 231) && (pixel_y <= 232))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 435) && (pixel_x <= 436)) && ((pixel_y >= 238) && (pixel_y <= 239))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 440) && (pixel_x <= 441)) && ((pixel_y >= 287) && (pixel_y <= 288))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 442) && (pixel_x <= 443)) && ((pixel_y >= 295) && (pixel_y <= 296))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 442) && (pixel_x <= 443)) && ((pixel_y >= 296) && (pixel_y <= 297))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 442) && (pixel_x <= 443)) && ((pixel_y >= 266) && (pixel_y <= 267))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 442) && (pixel_x <= 443)) && ((pixel_y >= 239) && (pixel_y <= 240))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 443) && (pixel_x <= 444)) && ((pixel_y >= 240) && (pixel_y <= 241))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 444) && (pixel_x <= 445)) && ((pixel_y >= 277) && (pixel_y <= 278))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 444) && (pixel_x <= 445)) && ((pixel_y >= 287) && (pixel_y <= 288))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 444) && (pixel_x <= 445)) && ((pixel_y >= 287) && (pixel_y <= 288))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 444) && (pixel_x <= 445)) && ((pixel_y >= 250) && (pixel_y <= 251))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 444) && (pixel_x <= 445)) && ((pixel_y >= 225) && (pixel_y <= 226))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 445) && (pixel_x <= 446)) && ((pixel_y >= 225) && (pixel_y <= 226))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 451) && (pixel_x <= 452)) && ((pixel_y >= 255) && (pixel_y <= 256))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 453) && (pixel_x <= 454)) && ((pixel_y >= 273) && (pixel_y <= 274))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 453) && (pixel_x <= 454)) && ((pixel_y >= 273) && (pixel_y <= 274))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 453) && (pixel_x <= 454)) && ((pixel_y >= 268) && (pixel_y <= 269))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 453) && (pixel_x <= 454)) && ((pixel_y >= 233) && (pixel_y <= 234))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 453) && (pixel_x <= 454)) && ((pixel_y >= 237) && (pixel_y <= 238))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 453) && (pixel_x <= 454)) && ((pixel_y >= 267) && (pixel_y <= 268))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 453) && (pixel_x <= 454)) && ((pixel_y >= 270) && (pixel_y <= 271))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 453) && (pixel_x <= 454)) && ((pixel_y >= 270) && (pixel_y <= 271))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 449) && (pixel_x <= 450)) && ((pixel_y >= 234) && (pixel_y <= 235))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 447) && (pixel_x <= 448)) && ((pixel_y >= 226) && (pixel_y <= 227))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 447) && (pixel_x <= 448)) && ((pixel_y >= 233) && (pixel_y <= 234))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 447) && (pixel_x <= 448)) && ((pixel_y >= 272) && (pixel_y <= 273))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 447) && (pixel_x <= 448)) && ((pixel_y >= 279) && (pixel_y <= 280))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 447) && (pixel_x <= 448)) && ((pixel_y >= 279) && (pixel_y <= 280))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 447) && (pixel_x <= 448)) && ((pixel_y >= 251) && (pixel_y <= 252))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 447) && (pixel_x <= 448)) && ((pixel_y >= 228) && (pixel_y <= 229))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 447) && (pixel_x <= 448)) && ((pixel_y >= 238) && (pixel_y <= 239))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 450) && (pixel_x <= 451)) && ((pixel_y >= 261) && (pixel_y <= 262))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 450) && (pixel_x <= 451)) && ((pixel_y >= 262) && (pixel_y <= 263))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 450) && (pixel_x <= 451)) && ((pixel_y >= 252) && (pixel_y <= 253))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 447) && (pixel_x <= 448)) && ((pixel_y >= 222) && (pixel_y <= 223))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 447) && (pixel_x <= 448)) && ((pixel_y >= 222) && (pixel_y <= 223))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 447) && (pixel_x <= 448)) && ((pixel_y >= 258) && (pixel_y <= 259))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 447) && (pixel_x <= 448)) && ((pixel_y >= 274) && (pixel_y <= 275))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 447) && (pixel_x <= 448)) && ((pixel_y >= 274) && (pixel_y <= 275))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 445) && (pixel_x <= 446)) && ((pixel_y >= 266) && (pixel_y <= 267))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 440) && (pixel_x <= 441)) && ((pixel_y >= 235) && (pixel_y <= 236))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 440) && (pixel_x <= 441)) && ((pixel_y >= 234) && (pixel_y <= 235))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 440) && (pixel_x <= 441)) && ((pixel_y >= 234) && (pixel_y <= 235))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 436) && (pixel_x <= 437)) && ((pixel_y >= 273) && (pixel_y <= 274))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 433) && (pixel_x <= 434)) && ((pixel_y >= 316) && (pixel_y <= 317))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 433) && (pixel_x <= 434)) && ((pixel_y >= 320) && (pixel_y <= 321))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 433) && (pixel_x <= 434)) && ((pixel_y >= 292) && (pixel_y <= 293))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 429) && (pixel_x <= 430)) && ((pixel_y >= 225) && (pixel_y <= 226))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 429) && (pixel_x <= 430)) && ((pixel_y >= 204) && (pixel_y <= 205))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 429) && (pixel_x <= 430)) && ((pixel_y >= 204) && (pixel_y <= 205))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 435) && (pixel_x <= 436)) && ((pixel_y >= 228) && (pixel_y <= 229))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 441) && (pixel_x <= 442)) && ((pixel_y >= 263) && (pixel_y <= 264))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 444) && (pixel_x <= 445)) && ((pixel_y >= 267) && (pixel_y <= 268))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 444) && (pixel_x <= 445)) && ((pixel_y >= 267) && (pixel_y <= 268))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 444) && (pixel_x <= 445)) && ((pixel_y >= 251) && (pixel_y <= 252))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 444) && (pixel_x <= 445)) && ((pixel_y >= 210) && (pixel_y <= 211))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 445) && (pixel_x <= 446)) && ((pixel_y >= 210) && (pixel_y <= 211))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 453) && (pixel_x <= 454)) && ((pixel_y >= 262) && (pixel_y <= 263))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 453) && (pixel_x <= 454)) && ((pixel_y >= 273) && (pixel_y <= 274))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 453) && (pixel_x <= 454)) && ((pixel_y >= 273) && (pixel_y <= 274))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 453) && (pixel_x <= 454)) && ((pixel_y >= 262) && (pixel_y <= 263))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 453) && (pixel_x <= 454)) && ((pixel_y >= 247) && (pixel_y <= 248))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 453) && (pixel_x <= 454)) && ((pixel_y >= 246) && (pixel_y <= 247))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 453) && (pixel_x <= 454)) && ((pixel_y >= 271) && (pixel_y <= 272))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 453) && (pixel_x <= 454)) && ((pixel_y >= 305) && (pixel_y <= 306))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 453) && (pixel_x <= 454)) && ((pixel_y >= 309) && (pixel_y <= 310))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 453) && (pixel_x <= 454)) && ((pixel_y >= 309) && (pixel_y <= 310))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 453) && (pixel_x <= 454)) && ((pixel_y >= 272) && (pixel_y <= 273))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 453) && (pixel_x <= 454)) && ((pixel_y >= 244) && (pixel_y <= 245))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 456) && (pixel_x <= 457)) && ((pixel_y >= 245) && (pixel_y <= 246))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 459) && (pixel_x <= 460)) && ((pixel_y >= 268) && (pixel_y <= 269))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 459) && (pixel_x <= 460)) && ((pixel_y >= 282) && (pixel_y <= 283))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 459) && (pixel_x <= 460)) && ((pixel_y >= 282) && (pixel_y <= 283))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 459) && (pixel_x <= 460)) && ((pixel_y >= 281) && (pixel_y <= 282))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 453) && (pixel_x <= 454)) && ((pixel_y >= 240) && (pixel_y <= 241))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 451) && (pixel_x <= 452)) && ((pixel_y >= 220) && (pixel_y <= 221))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 451) && (pixel_x <= 452)) && ((pixel_y >= 221) && (pixel_y <= 222))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 451) && (pixel_x <= 452)) && ((pixel_y >= 249) && (pixel_y <= 250))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 451) && (pixel_x <= 452)) && ((pixel_y >= 257) && (pixel_y <= 258))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 451) && (pixel_x <= 452)) && ((pixel_y >= 257) && (pixel_y <= 258))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 451) && (pixel_x <= 452)) && ((pixel_y >= 256) && (pixel_y <= 257))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 446) && (pixel_x <= 447)) && ((pixel_y >= 225) && (pixel_y <= 226))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 445) && (pixel_x <= 446)) && ((pixel_y >= 224) && (pixel_y <= 225))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 445) && (pixel_x <= 446)) && ((pixel_y >= 241) && (pixel_y <= 242))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 445) && (pixel_x <= 446)) && ((pixel_y >= 270) && (pixel_y <= 271))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 300) && (pixel_x <= 301)) && ((pixel_y >= 262) && (pixel_y <= 263))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 308) && (pixel_x <= 309)) && ((pixel_y >= 285) && (pixel_y <= 286))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 308) && (pixel_x <= 309)) && ((pixel_y >= 291) && (pixel_y <= 292))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 308) && (pixel_x <= 309)) && ((pixel_y >= 291) && (pixel_y <= 292))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 310) && (pixel_x <= 311)) && ((pixel_y >= 278) && (pixel_y <= 279))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 321) && (pixel_x <= 322)) && ((pixel_y >= 236) && (pixel_y <= 237))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 321) && (pixel_x <= 322)) && ((pixel_y >= 233) && (pixel_y <= 234))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 323) && (pixel_x <= 324)) && ((pixel_y >= 233) && (pixel_y <= 234))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 323) && (pixel_x <= 324)) && ((pixel_y >= 259) && (pixel_y <= 260))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 323) && (pixel_x <= 324)) && ((pixel_y >= 269) && (pixel_y <= 270))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 323) && (pixel_x <= 324)) && ((pixel_y >= 269) && (pixel_y <= 270))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 323) && (pixel_x <= 324)) && ((pixel_y >= 267) && (pixel_y <= 268))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 326) && (pixel_x <= 327)) && ((pixel_y >= 243) && (pixel_y <= 244))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 326) && (pixel_x <= 327)) && ((pixel_y >= 243) && (pixel_y <= 244))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 328) && (pixel_x <= 329)) && ((pixel_y >= 256) && (pixel_y <= 257))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 328) && (pixel_x <= 329)) && ((pixel_y >= 284) && (pixel_y <= 285))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 328) && (pixel_x <= 329)) && ((pixel_y >= 287) && (pixel_y <= 288))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 328) && (pixel_x <= 329)) && ((pixel_y >= 286) && (pixel_y <= 287))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 328) && (pixel_x <= 329)) && ((pixel_y >= 260) && (pixel_y <= 261))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 328) && (pixel_x <= 329)) && ((pixel_y >= 256) && (pixel_y <= 257))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 328) && (pixel_x <= 329)) && ((pixel_y >= 258) && (pixel_y <= 259))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 328) && (pixel_x <= 329)) && ((pixel_y >= 310) && (pixel_y <= 311))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 328) && (pixel_x <= 329)) && ((pixel_y >= 330) && (pixel_y <= 331))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 328) && (pixel_x <= 329)) && ((pixel_y >= 330) && (pixel_y <= 331))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 331) && (pixel_x <= 332)) && ((pixel_y >= 290) && (pixel_y <= 291))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 337) && (pixel_x <= 338)) && ((pixel_y >= 219) && (pixel_y <= 220))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 338) && (pixel_x <= 339)) && ((pixel_y >= 214) && (pixel_y <= 215))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 338) && (pixel_x <= 339)) && ((pixel_y >= 231) && (pixel_y <= 232))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 338) && (pixel_x <= 339)) && ((pixel_y >= 279) && (pixel_y <= 280))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 338) && (pixel_x <= 339)) && ((pixel_y >= 292) && (pixel_y <= 293))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 338) && (pixel_x <= 339)) && ((pixel_y >= 292) && (pixel_y <= 293))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 336) && (pixel_x <= 337)) && ((pixel_y >= 276) && (pixel_y <= 277))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 325) && (pixel_x <= 326)) && ((pixel_y >= 227) && (pixel_y <= 228))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 324) && (pixel_x <= 325)) && ((pixel_y >= 226) && (pixel_y <= 227))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 324) && (pixel_x <= 325)) && ((pixel_y >= 250) && (pixel_y <= 251))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 321) && (pixel_x <= 322)) && ((pixel_y >= 276) && (pixel_y <= 277))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 321) && (pixel_x <= 322)) && ((pixel_y >= 279) && (pixel_y <= 280))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 321) && (pixel_x <= 322)) && ((pixel_y >= 279) && (pixel_y <= 280))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 319) && (pixel_x <= 320)) && ((pixel_y >= 254) && (pixel_y <= 255))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 318) && (pixel_x <= 319)) && ((pixel_y >= 249) && (pixel_y <= 250))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 321) && (pixel_x <= 322)) && ((pixel_y >= 277) && (pixel_y <= 278))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 321) && (pixel_x <= 322)) && ((pixel_y >= 299) && (pixel_y <= 300))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 321) && (pixel_x <= 322)) && ((pixel_y >= 299) && (pixel_y <= 300))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 321) && (pixel_x <= 322)) && ((pixel_y >= 265) && (pixel_y <= 266))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 325) && (pixel_x <= 326)) && ((pixel_y >= 223) && (pixel_y <= 224))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 327) && (pixel_x <= 328)) && ((pixel_y >= 224) && (pixel_y <= 225))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 330) && (pixel_x <= 331)) && ((pixel_y >= 243) && (pixel_y <= 244))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 330) && (pixel_x <= 331)) && ((pixel_y >= 253) && (pixel_y <= 254))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 330) && (pixel_x <= 331)) && ((pixel_y >= 253) && (pixel_y <= 254))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 330) && (pixel_x <= 331)) && ((pixel_y >= 253) && (pixel_y <= 254))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 330) && (pixel_x <= 331)) && ((pixel_y >= 246) && (pixel_y <= 247))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 330) && (pixel_x <= 331)) && ((pixel_y >= 246) && (pixel_y <= 247))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 336) && (pixel_x <= 337)) && ((pixel_y >= 257) && (pixel_y <= 258))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 340) && (pixel_x <= 341)) && ((pixel_y >= 274) && (pixel_y <= 275))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 340) && (pixel_x <= 341)) && ((pixel_y >= 274) && (pixel_y <= 275))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 340) && (pixel_x <= 341)) && ((pixel_y >= 269) && (pixel_y <= 270))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 344) && (pixel_x <= 345)) && ((pixel_y >= 227) && (pixel_y <= 228))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 344) && (pixel_x <= 345)) && ((pixel_y >= 227) && (pixel_y <= 228))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 344) && (pixel_x <= 345)) && ((pixel_y >= 251) && (pixel_y <= 252))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 344) && (pixel_x <= 345)) && ((pixel_y >= 273) && (pixel_y <= 274))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 344) && (pixel_x <= 345)) && ((pixel_y >= 275) && (pixel_y <= 276))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 344) && (pixel_x <= 345)) && ((pixel_y >= 274) && (pixel_y <= 275))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 340) && (pixel_x <= 341)) && ((pixel_y >= 243) && (pixel_y <= 244))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 340) && (pixel_x <= 341)) && ((pixel_y >= 239) && (pixel_y <= 240))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 336) && (pixel_x <= 337)) && ((pixel_y >= 285) && (pixel_y <= 286))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 333) && (pixel_x <= 334)) && ((pixel_y >= 308) && (pixel_y <= 309))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 333) && (pixel_x <= 334)) && ((pixel_y >= 308) && (pixel_y <= 309))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 333) && (pixel_x <= 334)) && ((pixel_y >= 305) && (pixel_y <= 306))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 333) && (pixel_x <= 334)) && ((pixel_y >= 251) && (pixel_y <= 252))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 333) && (pixel_x <= 334)) && ((pixel_y >= 243) && (pixel_y <= 244))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 333) && (pixel_x <= 334)) && ((pixel_y >= 256) && (pixel_y <= 257))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 327) && (pixel_x <= 328)) && ((pixel_y >= 342) && (pixel_y <= 343))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 316) && (pixel_x <= 317)) && ((pixel_y >= 395) && (pixel_y <= 396))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 316) && (pixel_x <= 317)) && ((pixel_y >= 395) && (pixel_y <= 396))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 316) && (pixel_x <= 317)) && ((pixel_y >= 357) && (pixel_y <= 358))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 320) && (pixel_x <= 321)) && ((pixel_y >= 274) && (pixel_y <= 275))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 320) && (pixel_x <= 321)) && ((pixel_y >= 271) && (pixel_y <= 272))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 322) && (pixel_x <= 323)) && ((pixel_y >= 284) && (pixel_y <= 285))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 322) && (pixel_x <= 323)) && ((pixel_y >= 329) && (pixel_y <= 330))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 322) && (pixel_x <= 323)) && ((pixel_y >= 333) && (pixel_y <= 334))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 322) && (pixel_x <= 323)) && ((pixel_y >= 333) && (pixel_y <= 334))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 328) && (pixel_x <= 329)) && ((pixel_y >= 275) && (pixel_y <= 276))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 333) && (pixel_x <= 334)) && ((pixel_y >= 262) && (pixel_y <= 263))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 335) && (pixel_x <= 336)) && ((pixel_y >= 273) && (pixel_y <= 274))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 335) && (pixel_x <= 336)) && ((pixel_y >= 302) && (pixel_y <= 303))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 335) && (pixel_x <= 336)) && ((pixel_y >= 303) && (pixel_y <= 304))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 335) && (pixel_x <= 336)) && ((pixel_y >= 303) && (pixel_y <= 304))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 335) && (pixel_x <= 336)) && ((pixel_y >= 278) && (pixel_y <= 279))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 335) && (pixel_x <= 336)) && ((pixel_y >= 267) && (pixel_y <= 268))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 338) && (pixel_x <= 339)) && ((pixel_y >= 269) && (pixel_y <= 270))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 338) && (pixel_x <= 339)) && ((pixel_y >= 308) && (pixel_y <= 309))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 335) && (pixel_x <= 336)) && ((pixel_y >= 323) && (pixel_y <= 324))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 335) && (pixel_x <= 336)) && ((pixel_y >= 323) && (pixel_y <= 324))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 335) && (pixel_x <= 336)) && ((pixel_y >= 295) && (pixel_y <= 296))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 335) && (pixel_x <= 336)) && ((pixel_y >= 273) && (pixel_y <= 274))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 335) && (pixel_x <= 336)) && ((pixel_y >= 271) && (pixel_y <= 272))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 333) && (pixel_x <= 334)) && ((pixel_y >= 296) && (pixel_y <= 297))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 323) && (pixel_x <= 324)) && ((pixel_y >= 339) && (pixel_y <= 340))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 321) && (pixel_x <= 322)) && ((pixel_y >= 340) && (pixel_y <= 341))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 321) && (pixel_x <= 322)) && ((pixel_y >= 329) && (pixel_y <= 330))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 324) && (pixel_x <= 325)) && ((pixel_y >= 222) && (pixel_y <= 223))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 324) && (pixel_x <= 325)) && ((pixel_y >= 203) && (pixel_y <= 204))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 326) && (pixel_x <= 327)) && ((pixel_y >= 209) && (pixel_y <= 210))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 317) && (pixel_x <= 318)) && ((pixel_y >= 292) && (pixel_y <= 293))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 314) && (pixel_x <= 315)) && ((pixel_y >= 311) && (pixel_y <= 312))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 314) && (pixel_x <= 315)) && ((pixel_y >= 311) && (pixel_y <= 312))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 314) && (pixel_x <= 315)) && ((pixel_y >= 255) && (pixel_y <= 256))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 314) && (pixel_x <= 315)) && ((pixel_y >= 215) && (pixel_y <= 216))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 316) && (pixel_x <= 317)) && ((pixel_y >= 215) && (pixel_y <= 216))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 316) && (pixel_x <= 317)) && ((pixel_y >= 266) && (pixel_y <= 267))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 316) && (pixel_x <= 317)) && ((pixel_y >= 303) && (pixel_y <= 304))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 316) && (pixel_x <= 317)) && ((pixel_y >= 304) && (pixel_y <= 305))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 316) && (pixel_x <= 317)) && ((pixel_y >= 303) && (pixel_y <= 304))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 312) && (pixel_x <= 313)) && ((pixel_y >= 233) && (pixel_y <= 234))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 312) && (pixel_x <= 313)) && ((pixel_y >= 228) && (pixel_y <= 229))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 312) && (pixel_x <= 313)) && ((pixel_y >= 233) && (pixel_y <= 234))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 312) && (pixel_x <= 313)) && ((pixel_y >= 269) && (pixel_y <= 270))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 312) && (pixel_x <= 313)) && ((pixel_y >= 273) && (pixel_y <= 274))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 312) && (pixel_x <= 313)) && ((pixel_y >= 268) && (pixel_y <= 269))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 312) && (pixel_x <= 313)) && ((pixel_y >= 225) && (pixel_y <= 226))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 312) && (pixel_x <= 313)) && ((pixel_y >= 222) && (pixel_y <= 223))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 316) && (pixel_x <= 317)) && ((pixel_y >= 253) && (pixel_y <= 254))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 316) && (pixel_x <= 317)) && ((pixel_y >= 300) && (pixel_y <= 301))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 316) && (pixel_x <= 317)) && ((pixel_y >= 301) && (pixel_y <= 302))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 316) && (pixel_x <= 317)) && ((pixel_y >= 299) && (pixel_y <= 300))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 316) && (pixel_x <= 317)) && ((pixel_y >= 227) && (pixel_y <= 228))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 316) && (pixel_x <= 317)) && ((pixel_y >= 218) && (pixel_y <= 219))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 318) && (pixel_x <= 319)) && ((pixel_y >= 224) && (pixel_y <= 225))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 318) && (pixel_x <= 319)) && ((pixel_y >= 263) && (pixel_y <= 264))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 318) && (pixel_x <= 319)) && ((pixel_y >= 267) && (pixel_y <= 268))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 318) && (pixel_x <= 319)) && ((pixel_y >= 266) && (pixel_y <= 267))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 318) && (pixel_x <= 319)) && ((pixel_y >= 205) && (pixel_y <= 206))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 318) && (pixel_x <= 319)) && ((pixel_y >= 172) && (pixel_y <= 173))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 318) && (pixel_x <= 319)) && ((pixel_y >= 172) && (pixel_y <= 173))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 318) && (pixel_x <= 319)) && ((pixel_y >= 172) && (pixel_y <= 173))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 321) && (pixel_x <= 322)) && ((pixel_y >= 199) && (pixel_y <= 200))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 321) && (pixel_x <= 322)) && ((pixel_y >= 205) && (pixel_y <= 206))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 321) && (pixel_x <= 322)) && ((pixel_y >= 205) && (pixel_y <= 206))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 321) && (pixel_x <= 322)) && ((pixel_y >= 200) && (pixel_y <= 201))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 326) && (pixel_x <= 327)) && ((pixel_y >= 161) && (pixel_y <= 162))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 327) && (pixel_x <= 328)) && ((pixel_y >= 160) && (pixel_y <= 161))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 328) && (pixel_x <= 329)) && ((pixel_y >= 164) && (pixel_y <= 165))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 332) && (pixel_x <= 333)) && ((pixel_y >= 176) && (pixel_y <= 177))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 332) && (pixel_x <= 333)) && ((pixel_y >= 176) && (pixel_y <= 177))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 332) && (pixel_x <= 333)) && ((pixel_y >= 176) && (pixel_y <= 177))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 332) && (pixel_x <= 333)) && ((pixel_y >= 176) && (pixel_y <= 177))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 332) && (pixel_x <= 333)) && ((pixel_y >= 176) && (pixel_y <= 177))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 332) && (pixel_x <= 333)) && ((pixel_y >= 173) && (pixel_y <= 174))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 332) && (pixel_x <= 333)) && ((pixel_y >= 142) && (pixel_y <= 143))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 329) && (pixel_x <= 330)) && ((pixel_y >= 113) && (pixel_y <= 114))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 327) && (pixel_x <= 328)) && ((pixel_y >= 101) && (pixel_y <= 102))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 327) && (pixel_x <= 328)) && ((pixel_y >= 98) && (pixel_y <= 99))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 327) && (pixel_x <= 328)) && ((pixel_y >= 111) && (pixel_y <= 112))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 327) && (pixel_x <= 328)) && ((pixel_y >= 143) && (pixel_y <= 144))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 329) && (pixel_x <= 330)) && ((pixel_y >= 146) && (pixel_y <= 147))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 329) && (pixel_x <= 330)) && ((pixel_y >= 146) && (pixel_y <= 147))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 329) && (pixel_x <= 330)) && ((pixel_y >= 130) && (pixel_y <= 131))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 329) && (pixel_x <= 330)) && ((pixel_y >= 98) && (pixel_y <= 99))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 329) && (pixel_x <= 330)) && ((pixel_y >= 97) && (pixel_y <= 98))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 329) && (pixel_x <= 330)) && ((pixel_y >= 112) && (pixel_y <= 113))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 327) && (pixel_x <= 328)) && ((pixel_y >= 204) && (pixel_y <= 205))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 326) && (pixel_x <= 327)) && ((pixel_y >= 209) && (pixel_y <= 210))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 326) && (pixel_x <= 327)) && ((pixel_y >= 209) && (pixel_y <= 210))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 326) && (pixel_x <= 327)) && ((pixel_y >= 174) && (pixel_y <= 175))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 326) && (pixel_x <= 327)) && ((pixel_y >= 120) && (pixel_y <= 121))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 326) && (pixel_x <= 327)) && ((pixel_y >= 112) && (pixel_y <= 113))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 326) && (pixel_x <= 327)) && ((pixel_y >= 113) && (pixel_y <= 114))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 326) && (pixel_x <= 327)) && ((pixel_y >= 174) && (pixel_y <= 175))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 326) && (pixel_x <= 327)) && ((pixel_y >= 218) && (pixel_y <= 219))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 326) && (pixel_x <= 327)) && ((pixel_y >= 220) && (pixel_y <= 221))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 326) && (pixel_x <= 327)) && ((pixel_y >= 173) && (pixel_y <= 174))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 326) && (pixel_x <= 327)) && ((pixel_y >= 112) && (pixel_y <= 113))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 326) && (pixel_x <= 327)) && ((pixel_y >= 106) && (pixel_y <= 107))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 326) && (pixel_x <= 327)) && ((pixel_y >= 117) && (pixel_y <= 118))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 326) && (pixel_x <= 327)) && ((pixel_y >= 131) && (pixel_y <= 132))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 326) && (pixel_x <= 327)) && ((pixel_y >= 131) && (pixel_y <= 132))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 326) && (pixel_x <= 327)) && ((pixel_y >= 131) && (pixel_y <= 132))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 326) && (pixel_x <= 327)) && ((pixel_y >= 116) && (pixel_y <= 117))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 326) && (pixel_x <= 327)) && ((pixel_y >= 105) && (pixel_y <= 106))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 326) && (pixel_x <= 327)) && ((pixel_y >= 105) && (pixel_y <= 106))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 326) && (pixel_x <= 327)) && ((pixel_y >= 139) && (pixel_y <= 140))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 326) && (pixel_x <= 327)) && ((pixel_y >= 162) && (pixel_y <= 163))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 326) && (pixel_x <= 327)) && ((pixel_y >= 162) && (pixel_y <= 163))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 326) && (pixel_x <= 327)) && ((pixel_y >= 158) && (pixel_y <= 159))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 326) && (pixel_x <= 327)) && ((pixel_y >= 152) && (pixel_y <= 153))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 326) && (pixel_x <= 327)) && ((pixel_y >= 152) && (pixel_y <= 153))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 326) && (pixel_x <= 327)) && ((pixel_y >= 161) && (pixel_y <= 162))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 326) && (pixel_x <= 327)) && ((pixel_y >= 175) && (pixel_y <= 176))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 326) && (pixel_x <= 327)) && ((pixel_y >= 176) && (pixel_y <= 177))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 326) && (pixel_x <= 327)) && ((pixel_y >= 176) && (pixel_y <= 177))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end

else if (((pixel_x >= 334) && (pixel_x <= 335)) && ((pixel_y >= 172) && (pixel_y <= 173))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 334) && (pixel_x <= 335)) && ((pixel_y >= 169) && (pixel_y <= 170))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 334) && (pixel_x <= 335)) && ((pixel_y >= 144) && (pixel_y <= 145))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 334) && (pixel_x <= 335)) && ((pixel_y >= 136) && (pixel_y <= 137))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 334) && (pixel_x <= 335)) && ((pixel_y >= 136) && (pixel_y <= 137))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 334) && (pixel_x <= 335)) && ((pixel_y >= 136) && (pixel_y <= 137))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 334) && (pixel_x <= 335)) && ((pixel_y >= 151) && (pixel_y <= 152))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 334) && (pixel_x <= 335)) && ((pixel_y >= 165) && (pixel_y <= 166))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 334) && (pixel_x <= 335)) && ((pixel_y >= 168) && (pixel_y <= 169))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 408) && (pixel_x <= 409)) && ((pixel_y >= 264) && (pixel_y <= 265))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 410) && (pixel_x <= 411)) && ((pixel_y >= 281) && (pixel_y <= 282))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 410) && (pixel_x <= 411)) && ((pixel_y >= 283) && (pixel_y <= 284))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 410) && (pixel_x <= 411)) && ((pixel_y >= 282) && (pixel_y <= 283))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 410) && (pixel_x <= 411)) && ((pixel_y >= 237) && (pixel_y <= 238))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 410) && (pixel_x <= 411)) && ((pixel_y >= 210) && (pixel_y <= 211))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 410) && (pixel_x <= 411)) && ((pixel_y >= 210) && (pixel_y <= 211))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 410) && (pixel_x <= 411)) && ((pixel_y >= 215) && (pixel_y <= 216))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 410) && (pixel_x <= 411)) && ((pixel_y >= 238) && (pixel_y <= 239))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 410) && (pixel_x <= 411)) && ((pixel_y >= 241) && (pixel_y <= 242))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 410) && (pixel_x <= 411)) && ((pixel_y >= 241) && (pixel_y <= 242))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 410) && (pixel_x <= 411)) && ((pixel_y >= 201) && (pixel_y <= 202))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 410) && (pixel_x <= 411)) && ((pixel_y >= 197) && (pixel_y <= 198))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 410) && (pixel_x <= 411)) && ((pixel_y >= 206) && (pixel_y <= 207))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 410) && (pixel_x <= 411)) && ((pixel_y >= 254) && (pixel_y <= 255))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 410) && (pixel_x <= 411)) && ((pixel_y >= 260) && (pixel_y <= 261))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 410) && (pixel_x <= 411)) && ((pixel_y >= 258) && (pixel_y <= 259))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 406) && (pixel_x <= 407)) && ((pixel_y >= 185) && (pixel_y <= 186))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 406) && (pixel_x <= 407)) && ((pixel_y >= 161) && (pixel_y <= 162))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 406) && (pixel_x <= 407)) && ((pixel_y >= 163) && (pixel_y <= 164))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 404) && (pixel_x <= 405)) && ((pixel_y >= 247) && (pixel_y <= 248))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 400) && (pixel_x <= 401)) && ((pixel_y >= 281) && (pixel_y <= 282))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 400) && (pixel_x <= 401)) && ((pixel_y >= 281) && (pixel_y <= 282))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 400) && (pixel_x <= 401)) && ((pixel_y >= 257) && (pixel_y <= 258))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 383) && (pixel_x <= 384)) && ((pixel_y >= 161) && (pixel_y <= 162))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 383) && (pixel_x <= 384)) && ((pixel_y >= 154) && (pixel_y <= 155))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 383) && (pixel_x <= 384)) && ((pixel_y >= 165) && (pixel_y <= 166))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 383) && (pixel_x <= 384)) && ((pixel_y >= 263) && (pixel_y <= 264))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 383) && (pixel_x <= 384)) && ((pixel_y >= 296) && (pixel_y <= 297))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 383) && (pixel_x <= 384)) && ((pixel_y >= 296) && (pixel_y <= 297))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 383) && (pixel_x <= 384)) && ((pixel_y >= 275) && (pixel_y <= 276))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 388) && (pixel_x <= 389)) && ((pixel_y >= 192) && (pixel_y <= 193))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 388) && (pixel_x <= 389)) && ((pixel_y >= 168) && (pixel_y <= 169))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 390) && (pixel_x <= 391)) && ((pixel_y >= 169) && (pixel_y <= 170))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 394) && (pixel_x <= 395)) && ((pixel_y >= 240) && (pixel_y <= 241))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 394) && (pixel_x <= 395)) && ((pixel_y >= 257) && (pixel_y <= 258))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 394) && (pixel_x <= 395)) && ((pixel_y >= 259) && (pixel_y <= 260))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 397) && (pixel_x <= 398)) && ((pixel_y >= 228) && (pixel_y <= 229))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 400) && (pixel_x <= 401)) && ((pixel_y >= 129) && (pixel_y <= 130))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 400) && (pixel_x <= 401)) && ((pixel_y >= 124) && (pixel_y <= 125))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 403) && (pixel_x <= 404)) && ((pixel_y >= 174) && (pixel_y <= 175))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 401) && (pixel_x <= 402)) && ((pixel_y >= 251) && (pixel_y <= 252))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 399) && (pixel_x <= 400)) && ((pixel_y >= 271) && (pixel_y <= 272))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 399) && (pixel_x <= 400)) && ((pixel_y >= 271) && (pixel_y <= 272))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 399) && (pixel_x <= 400)) && ((pixel_y >= 264) && (pixel_y <= 265))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 399) && (pixel_x <= 400)) && ((pixel_y >= 163) && (pixel_y <= 164))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 403) && (pixel_x <= 404)) && ((pixel_y >= 118) && (pixel_y <= 119))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 403) && (pixel_x <= 404)) && ((pixel_y >= 118) && (pixel_y <= 119))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 403) && (pixel_x <= 404)) && ((pixel_y >= 167) && (pixel_y <= 168))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 398) && (pixel_x <= 399)) && ((pixel_y >= 265) && (pixel_y <= 266))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 395) && (pixel_x <= 396)) && ((pixel_y >= 291) && (pixel_y <= 292))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 395) && (pixel_x <= 396)) && ((pixel_y >= 291) && (pixel_y <= 292))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 395) && (pixel_x <= 396)) && ((pixel_y >= 227) && (pixel_y <= 228))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 395) && (pixel_x <= 396)) && ((pixel_y >= 107) && (pixel_y <= 108))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 395) && (pixel_x <= 396)) && ((pixel_y >= 99) && (pixel_y <= 100))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 395) && (pixel_x <= 396)) && ((pixel_y >= 111) && (pixel_y <= 112))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 395) && (pixel_x <= 396)) && ((pixel_y >= 183) && (pixel_y <= 184))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 395) && (pixel_x <= 396)) && ((pixel_y >= 220) && (pixel_y <= 221))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 395) && (pixel_x <= 396)) && ((pixel_y >= 221) && (pixel_y <= 222))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 406) && (pixel_x <= 407)) && ((pixel_y >= 114) && (pixel_y <= 115))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 407) && (pixel_x <= 408)) && ((pixel_y >= 119) && (pixel_y <= 120))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 412) && (pixel_x <= 413)) && ((pixel_y >= 150) && (pixel_y <= 151))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 412) && (pixel_x <= 413)) && ((pixel_y >= 162) && (pixel_y <= 163))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 412) && (pixel_x <= 413)) && ((pixel_y >= 163) && (pixel_y <= 164))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 412) && (pixel_x <= 413)) && ((pixel_y >= 163) && (pixel_y <= 164))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 412) && (pixel_x <= 413)) && ((pixel_y >= 158) && (pixel_y <= 159))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 412) && (pixel_x <= 413)) && ((pixel_y >= 140) && (pixel_y <= 141))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 412) && (pixel_x <= 413)) && ((pixel_y >= 139) && (pixel_y <= 140))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 412) && (pixel_x <= 413)) && ((pixel_y >= 139) && (pixel_y <= 140))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 412) && (pixel_x <= 413)) && ((pixel_y >= 145) && (pixel_y <= 146))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 412) && (pixel_x <= 413)) && ((pixel_y >= 146) && (pixel_y <= 147))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 185) && (pixel_x <= 186)) && ((pixel_y >= 397) && (pixel_y <= 398))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 185) && (pixel_x <= 186)) && ((pixel_y >= 397) && (pixel_y <= 398))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 185) && (pixel_x <= 186)) && ((pixel_y >= 396) && (pixel_y <= 397))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 185) && (pixel_x <= 186)) && ((pixel_y >= 367) && (pixel_y <= 368))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 185) && (pixel_x <= 186)) && ((pixel_y >= 365) && (pixel_y <= 366))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 185) && (pixel_x <= 186)) && ((pixel_y >= 370) && (pixel_y <= 371))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 185) && (pixel_x <= 186)) && ((pixel_y >= 388) && (pixel_y <= 389))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 185) && (pixel_x <= 186)) && ((pixel_y >= 390) && (pixel_y <= 391))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 185) && (pixel_x <= 186)) && ((pixel_y >= 390) && (pixel_y <= 391))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 185) && (pixel_x <= 186)) && ((pixel_y >= 379) && (pixel_y <= 380))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 185) && (pixel_x <= 186)) && ((pixel_y >= 374) && (pixel_y <= 375))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 185) && (pixel_x <= 186)) && ((pixel_y >= 374) && (pixel_y <= 375))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 185) && (pixel_x <= 186)) && ((pixel_y >= 399) && (pixel_y <= 400))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 185) && (pixel_x <= 186)) && ((pixel_y >= 421) && (pixel_y <= 422))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 185) && (pixel_x <= 186)) && ((pixel_y >= 421) && (pixel_y <= 422))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 185) && (pixel_x <= 186)) && ((pixel_y >= 421) && (pixel_y <= 422))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 185) && (pixel_x <= 186)) && ((pixel_y >= 383) && (pixel_y <= 384))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 188) && (pixel_x <= 189)) && ((pixel_y >= 363) && (pixel_y <= 364))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 188) && (pixel_x <= 189)) && ((pixel_y >= 363) && (pixel_y <= 364))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 189) && (pixel_x <= 190)) && ((pixel_y >= 364) && (pixel_y <= 365))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 193) && (pixel_x <= 194)) && ((pixel_y >= 390) && (pixel_y <= 391))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 193) && (pixel_x <= 194)) && ((pixel_y >= 391) && (pixel_y <= 392))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 193) && (pixel_x <= 194)) && ((pixel_y >= 391) && (pixel_y <= 392))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 193) && (pixel_x <= 194)) && ((pixel_y >= 374) && (pixel_y <= 375))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 193) && (pixel_x <= 194)) && ((pixel_y >= 326) && (pixel_y <= 327))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 193) && (pixel_x <= 194)) && ((pixel_y >= 325) && (pixel_y <= 326))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 193) && (pixel_x <= 194)) && ((pixel_y >= 336) && (pixel_y <= 337))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 193) && (pixel_x <= 194)) && ((pixel_y >= 386) && (pixel_y <= 387))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 193) && (pixel_x <= 194)) && ((pixel_y >= 390) && (pixel_y <= 391))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 193) && (pixel_x <= 194)) && ((pixel_y >= 390) && (pixel_y <= 391))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 191) && (pixel_x <= 192)) && ((pixel_y >= 386) && (pixel_y <= 387))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 177) && (pixel_x <= 178)) && ((pixel_y >= 243) && (pixel_y <= 244))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 175) && (pixel_x <= 176)) && ((pixel_y >= 256) && (pixel_y <= 257))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 174) && (pixel_x <= 175)) && ((pixel_y >= 256) && (pixel_y <= 257))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 174) && (pixel_x <= 175)) && ((pixel_y >= 256) && (pixel_y <= 257))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 168) && (pixel_x <= 169)) && ((pixel_y >= 246) && (pixel_y <= 247))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 158) && (pixel_x <= 159)) && ((pixel_y >= 230) && (pixel_y <= 231))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 158) && (pixel_x <= 159)) && ((pixel_y >= 230) && (pixel_y <= 231))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 158) && (pixel_x <= 159)) && ((pixel_y >= 230) && (pixel_y <= 231))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 158) && (pixel_x <= 159)) && ((pixel_y >= 251) && (pixel_y <= 252))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 158) && (pixel_x <= 159)) && ((pixel_y >= 268) && (pixel_y <= 269))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 158) && (pixel_x <= 159)) && ((pixel_y >= 268) && (pixel_y <= 269))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 155) && (pixel_x <= 156)) && ((pixel_y >= 259) && (pixel_y <= 260))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 155) && (pixel_x <= 156)) && ((pixel_y >= 226) && (pixel_y <= 227))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 153) && (pixel_x <= 154)) && ((pixel_y >= 220) && (pixel_y <= 221))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 153) && (pixel_x <= 154)) && ((pixel_y >= 220) && (pixel_y <= 221))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 153) && (pixel_x <= 154)) && ((pixel_y >= 248) && (pixel_y <= 249))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 153) && (pixel_x <= 154)) && ((pixel_y >= 274) && (pixel_y <= 275))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 153) && (pixel_x <= 154)) && ((pixel_y >= 274) && (pixel_y <= 275))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 153) && (pixel_x <= 154)) && ((pixel_y >= 269) && (pixel_y <= 270))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 156) && (pixel_x <= 157)) && ((pixel_y >= 198) && (pixel_y <= 199))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 156) && (pixel_x <= 157)) && ((pixel_y >= 192) && (pixel_y <= 193))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 159) && (pixel_x <= 160)) && ((pixel_y >= 196) && (pixel_y <= 197))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 162) && (pixel_x <= 163)) && ((pixel_y >= 228) && (pixel_y <= 229))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 162) && (pixel_x <= 163)) && ((pixel_y >= 242) && (pixel_y <= 243))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 162) && (pixel_x <= 163)) && ((pixel_y >= 242) && (pixel_y <= 243))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 162) && (pixel_x <= 163)) && ((pixel_y >= 242) && (pixel_y <= 243))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 162) && (pixel_x <= 163)) && ((pixel_y >= 220) && (pixel_y <= 221))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 162) && (pixel_x <= 163)) && ((pixel_y >= 220) && (pixel_y <= 221))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 162) && (pixel_x <= 163)) && ((pixel_y >= 220) && (pixel_y <= 221))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 162) && (pixel_x <= 163)) && ((pixel_y >= 240) && (pixel_y <= 241))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 162) && (pixel_x <= 163)) && ((pixel_y >= 256) && (pixel_y <= 257))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 162) && (pixel_x <= 163)) && ((pixel_y >= 256) && (pixel_y <= 257))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 162) && (pixel_x <= 163)) && ((pixel_y >= 256) && (pixel_y <= 257))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 162) && (pixel_x <= 163)) && ((pixel_y >= 238) && (pixel_y <= 239))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 162) && (pixel_x <= 163)) && ((pixel_y >= 235) && (pixel_y <= 236))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 162) && (pixel_x <= 163)) && ((pixel_y >= 235) && (pixel_y <= 236))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 162) && (pixel_x <= 163)) && ((pixel_y >= 236) && (pixel_y <= 237))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 162) && (pixel_x <= 163)) && ((pixel_y >= 255) && (pixel_y <= 256))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 162) && (pixel_x <= 163)) && ((pixel_y >= 259) && (pixel_y <= 260))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 162) && (pixel_x <= 163)) && ((pixel_y >= 259) && (pixel_y <= 260))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 162) && (pixel_x <= 163)) && ((pixel_y >= 246) && (pixel_y <= 247))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 159) && (pixel_x <= 160)) && ((pixel_y >= 230) && (pixel_y <= 231))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 159) && (pixel_x <= 160)) && ((pixel_y >= 221) && (pixel_y <= 222))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 159) && (pixel_x <= 160)) && ((pixel_y >= 221) && (pixel_y <= 222))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 159) && (pixel_x <= 160)) && ((pixel_y >= 235) && (pixel_y <= 236))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 159) && (pixel_x <= 160)) && ((pixel_y >= 245) && (pixel_y <= 246))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 159) && (pixel_x <= 160)) && ((pixel_y >= 245) && (pixel_y <= 246))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 159) && (pixel_x <= 160)) && ((pixel_y >= 245) && (pixel_y <= 246))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 159) && (pixel_x <= 160)) && ((pixel_y >= 228) && (pixel_y <= 229))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 159) && (pixel_x <= 160)) && ((pixel_y >= 206) && (pixel_y <= 207))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 159) && (pixel_x <= 160)) && ((pixel_y >= 206) && (pixel_y <= 207))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 159) && (pixel_x <= 160)) && ((pixel_y >= 207) && (pixel_y <= 208))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 159) && (pixel_x <= 160)) && ((pixel_y >= 233) && (pixel_y <= 234))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 159) && (pixel_x <= 160)) && ((pixel_y >= 240) && (pixel_y <= 241))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 193) && (pixel_x <= 194)) && ((pixel_y >= 101) && (pixel_y <= 102))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 193) && (pixel_x <= 194)) && ((pixel_y >= 102) && (pixel_y <= 103))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 193) && (pixel_x <= 194)) && ((pixel_y >= 92) && (pixel_y <= 93))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 190) && (pixel_x <= 191)) && ((pixel_y >= 48) && (pixel_y <= 49))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 190) && (pixel_x <= 191)) && ((pixel_y >= 38) && (pixel_y <= 39))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 190) && (pixel_x <= 191)) && ((pixel_y >= 38) && (pixel_y <= 39))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 190) && (pixel_x <= 191)) && ((pixel_y >= 52) && (pixel_y <= 53))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 190) && (pixel_x <= 191)) && ((pixel_y >= 87) && (pixel_y <= 88))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 190) && (pixel_x <= 191)) && ((pixel_y >= 90) && (pixel_y <= 91))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 190) && (pixel_x <= 191)) && ((pixel_y >= 90) && (pixel_y <= 91))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 190) && (pixel_x <= 191)) && ((pixel_y >= 63) && (pixel_y <= 64))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 190) && (pixel_x <= 191)) && ((pixel_y >= 43) && (pixel_y <= 44))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 190) && (pixel_x <= 191)) && ((pixel_y >= 43) && (pixel_y <= 44))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 190) && (pixel_x <= 191)) && ((pixel_y >= 45) && (pixel_y <= 46))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 190) && (pixel_x <= 191)) && ((pixel_y >= 74) && (pixel_y <= 75))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 192) && (pixel_x <= 193)) && ((pixel_y >= 79) && (pixel_y <= 80))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 192) && (pixel_x <= 193)) && ((pixel_y >= 79) && (pixel_y <= 80))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 194) && (pixel_x <= 195)) && ((pixel_y >= 69) && (pixel_y <= 70))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 198) && (pixel_x <= 199)) && ((pixel_y >= 35) && (pixel_y <= 36))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 198) && (pixel_x <= 199)) && ((pixel_y >= 35) && (pixel_y <= 36))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 200) && (pixel_x <= 201)) && ((pixel_y >= 49) && (pixel_y <= 50))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 201) && (pixel_x <= 202)) && ((pixel_y >= 67) && (pixel_y <= 68))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 201) && (pixel_x <= 202)) && ((pixel_y >= 69) && (pixel_y <= 70))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 201) && (pixel_x <= 202)) && ((pixel_y >= 69) && (pixel_y <= 70))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 201) && (pixel_x <= 202)) && ((pixel_y >= 49) && (pixel_y <= 50))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 201) && (pixel_x <= 202)) && ((pixel_y >= 37) && (pixel_y <= 38))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 201) && (pixel_x <= 202)) && ((pixel_y >= 37) && (pixel_y <= 38))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 205) && (pixel_x <= 206)) && ((pixel_y >= 54) && (pixel_y <= 55))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 207) && (pixel_x <= 208)) && ((pixel_y >= 97) && (pixel_y <= 98))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 207) && (pixel_x <= 208)) && ((pixel_y >= 99) && (pixel_y <= 100))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 207) && (pixel_x <= 208)) && ((pixel_y >= 99) && (pixel_y <= 100))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 207) && (pixel_x <= 208)) && ((pixel_y >= 78) && (pixel_y <= 79))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 207) && (pixel_x <= 208)) && ((pixel_y >= 55) && (pixel_y <= 56))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 207) && (pixel_x <= 208)) && ((pixel_y >= 39) && (pixel_y <= 40))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 207) && (pixel_x <= 208)) && ((pixel_y >= 39) && (pixel_y <= 40))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 207) && (pixel_x <= 208)) && ((pixel_y >= 63) && (pixel_y <= 64))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 207) && (pixel_x <= 208)) && ((pixel_y >= 92) && (pixel_y <= 93))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 205) && (pixel_x <= 206)) && ((pixel_y >= 96) && (pixel_y <= 97))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 205) && (pixel_x <= 206)) && ((pixel_y >= 96) && (pixel_y <= 97))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 205) && (pixel_x <= 206)) && ((pixel_y >= 73) && (pixel_y <= 74))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 205) && (pixel_x <= 206)) && ((pixel_y >= 51) && (pixel_y <= 52))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 205) && (pixel_x <= 206)) && ((pixel_y >= 51) && (pixel_y <= 52))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 198) && (pixel_x <= 199)) && ((pixel_y >= 54) && (pixel_y <= 55))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 188) && (pixel_x <= 189)) && ((pixel_y >= 61) && (pixel_y <= 62))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 187) && (pixel_x <= 188)) && ((pixel_y >= 63) && (pixel_y <= 64))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 187) && (pixel_x <= 188)) && ((pixel_y >= 63) && (pixel_y <= 64))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 185) && (pixel_x <= 186)) && ((pixel_y >= 63) && (pixel_y <= 64))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 185) && (pixel_x <= 186)) && ((pixel_y >= 45) && (pixel_y <= 46))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 185) && (pixel_x <= 186)) && ((pixel_y >= 37) && (pixel_y <= 38))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 387) && (pixel_x <= 388)) && ((pixel_y >= 13) && (pixel_y <= 14))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 387) && (pixel_x <= 388)) && ((pixel_y >= 30) && (pixel_y <= 31))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 384) && (pixel_x <= 385)) && ((pixel_y >= 65) && (pixel_y <= 66))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 384) && (pixel_x <= 385)) && ((pixel_y >= 65) && (pixel_y <= 66))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 384) && (pixel_x <= 385)) && ((pixel_y >= 63) && (pixel_y <= 64))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 391) && (pixel_x <= 392)) && ((pixel_y >= 2) && (pixel_y <= 3))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 391) && (pixel_x <= 392)) && ((pixel_y >= -6) && (pixel_y <= -5))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 394) && (pixel_x <= 395)) && ((pixel_y >= -1) && (pixel_y <= 0))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 401) && (pixel_x <= 402)) && ((pixel_y >= 57) && (pixel_y <= 58))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 401) && (pixel_x <= 402)) && ((pixel_y >= 82) && (pixel_y <= 83))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 401) && (pixel_x <= 402)) && ((pixel_y >= 83) && (pixel_y <= 84))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 403) && (pixel_x <= 404)) && ((pixel_y >= 75) && (pixel_y <= 76))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 410) && (pixel_x <= 411)) && ((pixel_y >= 43) && (pixel_y <= 44))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 410) && (pixel_x <= 411)) && ((pixel_y >= 43) && (pixel_y <= 44))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 414) && (pixel_x <= 415)) && ((pixel_y >= 47) && (pixel_y <= 48))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 420) && (pixel_x <= 421)) && ((pixel_y >= 63) && (pixel_y <= 64))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 420) && (pixel_x <= 421)) && ((pixel_y >= 64) && (pixel_y <= 65))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 427) && (pixel_x <= 428)) && ((pixel_y >= 51) && (pixel_y <= 52))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 436) && (pixel_x <= 437)) && ((pixel_y >= 19) && (pixel_y <= 20))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 437) && (pixel_x <= 438)) && ((pixel_y >= 19) && (pixel_y <= 20))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 444) && (pixel_x <= 445)) && ((pixel_y >= 38) && (pixel_y <= 39))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 447) && (pixel_x <= 448)) && ((pixel_y >= 52) && (pixel_y <= 53))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 447) && (pixel_x <= 448)) && ((pixel_y >= 53) && (pixel_y <= 54))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 448) && (pixel_x <= 449)) && ((pixel_y >= 48) && (pixel_y <= 49))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 453) && (pixel_x <= 454)) && ((pixel_y >= 15) && (pixel_y <= 16))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 453) && (pixel_x <= 454)) && ((pixel_y >= 14) && (pixel_y <= 15))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 455) && (pixel_x <= 456)) && ((pixel_y >= 24) && (pixel_y <= 25))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 467) && (pixel_x <= 468)) && ((pixel_y >= 83) && (pixel_y <= 84))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 467) && (pixel_x <= 468)) && ((pixel_y >= 91) && (pixel_y <= 92))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 467) && (pixel_x <= 468)) && ((pixel_y >= 91) && (pixel_y <= 92))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 467) && (pixel_x <= 468)) && ((pixel_y >= 68) && (pixel_y <= 69))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 467) && (pixel_x <= 468)) && ((pixel_y >= 42) && (pixel_y <= 43))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 464) && (pixel_x <= 465)) && ((pixel_y >= 35) && (pixel_y <= 36))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 464) && (pixel_x <= 465)) && ((pixel_y >= 32) && (pixel_y <= 33))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 464) && (pixel_x <= 465)) && ((pixel_y >= 39) && (pixel_y <= 40))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 461) && (pixel_x <= 462)) && ((pixel_y >= 67) && (pixel_y <= 68))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 461) && (pixel_x <= 462)) && ((pixel_y >= 67) && (pixel_y <= 68))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 461) && (pixel_x <= 462)) && ((pixel_y >= 67) && (pixel_y <= 68))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 461) && (pixel_x <= 462)) && ((pixel_y >= 67) && (pixel_y <= 68))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 461) && (pixel_x <= 462)) && ((pixel_y >= 46) && (pixel_y <= 47))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 461) && (pixel_x <= 462)) && ((pixel_y >= 42) && (pixel_y <= 43))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 460) && (pixel_x <= 461)) && ((pixel_y >= 52) && (pixel_y <= 53))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 455) && (pixel_x <= 456)) && ((pixel_y >= 83) && (pixel_y <= 84))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 452) && (pixel_x <= 453)) && ((pixel_y >= 89) && (pixel_y <= 90))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 452) && (pixel_x <= 453)) && ((pixel_y >= 89) && (pixel_y <= 90))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 443) && (pixel_x <= 444)) && ((pixel_y >= 42) && (pixel_y <= 43))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 433) && (pixel_x <= 434)) && ((pixel_y >= 10) && (pixel_y <= 11))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 432) && (pixel_x <= 433)) && ((pixel_y >= 10) && (pixel_y <= 11))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 432) && (pixel_x <= 433)) && ((pixel_y >= 10) && (pixel_y <= 11))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 426) && (pixel_x <= 427)) && ((pixel_y >= 14) && (pixel_y <= 15))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 418) && (pixel_x <= 419)) && ((pixel_y >= 37) && (pixel_y <= 38))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 418) && (pixel_x <= 419)) && ((pixel_y >= 45) && (pixel_y <= 46))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 418) && (pixel_x <= 419)) && ((pixel_y >= 45) && (pixel_y <= 46))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 418) && (pixel_x <= 419)) && ((pixel_y >= 43) && (pixel_y <= 44))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 418) && (pixel_x <= 419)) && ((pixel_y >= 4) && (pixel_y <= 5))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 418) && (pixel_x <= 419)) && ((pixel_y >= 1) && (pixel_y <= 2))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 418) && (pixel_x <= 419)) && ((pixel_y >= 1) && (pixel_y <= 2))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 413) && (pixel_x <= 414)) && ((pixel_y >= 32) && (pixel_y <= 33))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 408) && (pixel_x <= 409)) && ((pixel_y >= 62) && (pixel_y <= 63))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 408) && (pixel_x <= 409)) && ((pixel_y >= 66) && (pixel_y <= 67))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 408) && (pixel_x <= 409)) && ((pixel_y >= 66) && (pixel_y <= 67))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 408) && (pixel_x <= 409)) && ((pixel_y >= 57) && (pixel_y <= 58))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 408) && (pixel_x <= 409)) && ((pixel_y >= 9) && (pixel_y <= 10))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 408) && (pixel_x <= 409)) && ((pixel_y >= 8) && (pixel_y <= 9))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 408) && (pixel_x <= 409)) && ((pixel_y >= 8) && (pixel_y <= 9))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 408) && (pixel_x <= 409)) && ((pixel_y >= 26) && (pixel_y <= 27))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 408) && (pixel_x <= 409)) && ((pixel_y >= 43) && (pixel_y <= 44))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 410) && (pixel_x <= 411)) && ((pixel_y >= 47) && (pixel_y <= 48))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 419) && (pixel_x <= 420)) && ((pixel_y >= 47) && (pixel_y <= 48))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 430) && (pixel_x <= 431)) && ((pixel_y >= 43) && (pixel_y <= 44))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 430) && (pixel_x <= 431)) && ((pixel_y >= 42) && (pixel_y <= 43))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 436) && (pixel_x <= 437)) && ((pixel_y >= 42) && (pixel_y <= 43))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 447) && (pixel_x <= 448)) && ((pixel_y >= 50) && (pixel_y <= 51))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 451) && (pixel_x <= 452)) && ((pixel_y >= 61) && (pixel_y <= 62))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 451) && (pixel_x <= 452)) && ((pixel_y >= 61) && (pixel_y <= 62))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 453) && (pixel_x <= 454)) && ((pixel_y >= 68) && (pixel_y <= 69))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 507) && (pixel_x <= 508)) && ((pixel_y >= 6) && (pixel_y <= 7))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 507) && (pixel_x <= 508)) && ((pixel_y >= 27) && (pixel_y <= 28))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 507) && (pixel_x <= 508)) && ((pixel_y >= 39) && (pixel_y <= 40))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 507) && (pixel_x <= 508)) && ((pixel_y >= 39) && (pixel_y <= 40))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 507) && (pixel_x <= 508)) && ((pixel_y >= 39) && (pixel_y <= 40))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 507) && (pixel_x <= 508)) && ((pixel_y >= 27) && (pixel_y <= 28))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 509) && (pixel_x <= 510)) && ((pixel_y >= 6) && (pixel_y <= 7))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 513) && (pixel_x <= 514)) && ((pixel_y >= 18) && (pixel_y <= 19))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 514) && (pixel_x <= 515)) && ((pixel_y >= 19) && (pixel_y <= 20))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 514) && (pixel_x <= 515)) && ((pixel_y >= 19) && (pixel_y <= 20))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 514) && (pixel_x <= 515)) && ((pixel_y >= 19) && (pixel_y <= 20))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 517) && (pixel_x <= 518)) && ((pixel_y >= 15) && (pixel_y <= 16))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 520) && (pixel_x <= 521)) && ((pixel_y >= 5) && (pixel_y <= 6))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 520) && (pixel_x <= 521)) && ((pixel_y >= 5) && (pixel_y <= 6))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 521) && (pixel_x <= 522)) && ((pixel_y >= 5) && (pixel_y <= 6))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 525) && (pixel_x <= 526)) && ((pixel_y >= 15) && (pixel_y <= 16))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 525) && (pixel_x <= 526)) && ((pixel_y >= 24) && (pixel_y <= 25))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 525) && (pixel_x <= 526)) && ((pixel_y >= 24) && (pixel_y <= 25))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 525) && (pixel_x <= 526)) && ((pixel_y >= 24) && (pixel_y <= 25))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 525) && (pixel_x <= 526)) && ((pixel_y >= 24) && (pixel_y <= 25))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 525) && (pixel_x <= 526)) && ((pixel_y >= 24) && (pixel_y <= 25))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 525) && (pixel_x <= 526)) && ((pixel_y >= 24) && (pixel_y <= 25))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 525) && (pixel_x <= 526)) && ((pixel_y >= 16) && (pixel_y <= 17))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 525) && (pixel_x <= 526)) && ((pixel_y >= 7) && (pixel_y <= 8))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 525) && (pixel_x <= 526)) && ((pixel_y >= 5) && (pixel_y <= 6))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 525) && (pixel_x <= 526)) && ((pixel_y >= 5) && (pixel_y <= 6))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end

else if (((pixel_x >= 554) && (pixel_x <= 555)) && ((pixel_y >= 95) && (pixel_y <= 96))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 558) && (pixel_x <= 559)) && ((pixel_y >= 94) && (pixel_y <= 95))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 565) && (pixel_x <= 566)) && ((pixel_y >= 61) && (pixel_y <= 62))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 565) && (pixel_x <= 566)) && ((pixel_y >= 59) && (pixel_y <= 60))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 565) && (pixel_x <= 566)) && ((pixel_y >= 63) && (pixel_y <= 64))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 568) && (pixel_x <= 569)) && ((pixel_y >= 80) && (pixel_y <= 81))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 568) && (pixel_x <= 569)) && ((pixel_y >= 86) && (pixel_y <= 87))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 568) && (pixel_x <= 569)) && ((pixel_y >= 86) && (pixel_y <= 87))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 583) && (pixel_x <= 584)) && ((pixel_y >= 49) && (pixel_y <= 50))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 585) && (pixel_x <= 586)) && ((pixel_y >= 35) && (pixel_y <= 36))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 587) && (pixel_x <= 588)) && ((pixel_y >= 35) && (pixel_y <= 36))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 593) && (pixel_x <= 594)) && ((pixel_y >= 68) && (pixel_y <= 69))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 596) && (pixel_x <= 597)) && ((pixel_y >= 88) && (pixel_y <= 89))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 596) && (pixel_x <= 597)) && ((pixel_y >= 88) && (pixel_y <= 89))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 596) && (pixel_x <= 597)) && ((pixel_y >= 88) && (pixel_y <= 89))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 596) && (pixel_x <= 597)) && ((pixel_y >= 76) && (pixel_y <= 77))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 596) && (pixel_x <= 597)) && ((pixel_y >= 72) && (pixel_y <= 73))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 596) && (pixel_x <= 597)) && ((pixel_y >= 72) && (pixel_y <= 73))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 596) && (pixel_x <= 597)) && ((pixel_y >= 83) && (pixel_y <= 84))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 599) && (pixel_x <= 600)) && ((pixel_y >= 127) && (pixel_y <= 128))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 599) && (pixel_x <= 600)) && ((pixel_y >= 128) && (pixel_y <= 129))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 599) && (pixel_x <= 600)) && ((pixel_y >= 128) && (pixel_y <= 129))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 599) && (pixel_x <= 600)) && ((pixel_y >= 125) && (pixel_y <= 126))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 599) && (pixel_x <= 600)) && ((pixel_y >= 123) && (pixel_y <= 124))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 599) && (pixel_x <= 600)) && ((pixel_y >= 123) && (pixel_y <= 124))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 599) && (pixel_x <= 600)) && ((pixel_y >= 137) && (pixel_y <= 138))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 599) && (pixel_x <= 600)) && ((pixel_y >= 153) && (pixel_y <= 154))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 599) && (pixel_x <= 600)) && ((pixel_y >= 153) && (pixel_y <= 154))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 599) && (pixel_x <= 600)) && ((pixel_y >= 151) && (pixel_y <= 152))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 599) && (pixel_x <= 600)) && ((pixel_y >= 121) && (pixel_y <= 122))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 599) && (pixel_x <= 600)) && ((pixel_y >= 121) && (pixel_y <= 122))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 16) && (pixel_x <= 17)) && ((pixel_y >= 376) && (pixel_y <= 377))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 16) && (pixel_x <= 17)) && ((pixel_y >= 367) && (pixel_y <= 368))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 16) && (pixel_x <= 17)) && ((pixel_y >= 367) && (pixel_y <= 368))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 16) && (pixel_x <= 17)) && ((pixel_y >= 380) && (pixel_y <= 381))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 16) && (pixel_x <= 17)) && ((pixel_y >= 427) && (pixel_y <= 428))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 16) && (pixel_x <= 17)) && ((pixel_y >= 435) && (pixel_y <= 436))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 16) && (pixel_x <= 17)) && ((pixel_y >= 435) && (pixel_y <= 436))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 16) && (pixel_x <= 17)) && ((pixel_y >= 435) && (pixel_y <= 436))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
//else if ( (pixel_y <= ((pixel_x - 92)*(116/13) + 86)) && (pixel_y <= ((pixel_x - 105)*(-114/12) + 202)) && (pixel_y >= ((pixel_x - 117)*(-2/-25) + 88))) begin
//red <= 4'h7; green <= 4'h2; blue <= 4'h2;
//end
else if ( (pixel_x >= 282) && (pixel_y <= ((pixel_x - 282)*(9/5) + 341)) && (pixel_y <= ((pixel_x - 287)*(3/4) + 350)) && (pixel_y <= ((pixel_x - 291)*(-5/5) + 353)) && (pixel_y >= ((pixel_x - 296)*(-130/-14) + 348))) begin
red <= 4'h7; green <= 4'h2; blue <= 4'h2;
end
//else if ( (pixel_y >= ((pixel_x - 92)*(-14/16) + 86)) && (pixel_y >= ((pixel_x - 108)*(16/9) + 72)) && (pixel_y <= ((pixel_x - 117)*(-2/-25) + 88))) begin
//red <= 4'h7; green <= 4'h2; blue <= 4'h2;
//end
else if ((pixel_x - 385)**2 + (pixel_y - 110)**2 <= 7**2) begin
red <= 4'h7; green <= 4'h2; blue <= 4'h2;
end
else if ((pixel_x - 403)**2 + (pixel_y - 287)**2 <= 6**2) begin
red <= 4'h7; green <= 4'h2; blue <= 4'h2;
end
else if ((pixel_x - 28)**2 + (pixel_y - 159)**2 <= 2**2) begin
red <= 4'h7; green <= 4'h2; blue <= 4'h2;
end
else if ((pixel_x - 181)**2 + (pixel_y - 190)**2 <= 2**2) begin
red <= 4'h7; green <= 4'h2; blue <= 4'h2;
end
else if ((pixel_x - 464)**2 + (pixel_y - 426)**2 <= 11**2) begin
red <= 4'h7; green <= 4'h2; blue <= 4'h2;
end
else if ((pixel_x - 589)**2 + (pixel_y - 133)**2 <= 11**2) begin
red <= 4'h7; green <= 4'h2; blue <= 4'h2;
end
else if ( (pixel_y >= ((pixel_x - 377)*(-47/7) + 110)) && (pixel_y >= ((pixel_x - 384)*(46/7) + 63)) && (pixel_y <= ((pixel_x - 391)*(1/-14) + 109))) begin
red <= 4'h7; green <= 4'h2; blue <= 4'h2;
end
else if ( (pixel_y >= ((pixel_x - 398)*(-23/5) + 286)) && (pixel_y >= ((pixel_x - 403)*(22/5) + 263)) && (pixel_y <= ((pixel_x - 408)*(1/-10) + 285))) begin
red <= 4'h7; green <= 4'h2; blue <= 4'h2;
end
else if (((pixel_x >= 180) && (pixel_x <= 181)) && ((pixel_y >= 166) && (pixel_y <= 190))) begin
red <= 4'h7; green <= 4'h2; blue <= 4'h2;
end
else if (((pixel_x >= 380) && (pixel_x <= 385)) && ((pixel_y >= 183) && (pixel_y <= 260))) begin
red <= 4'h7; green <= 4'h2; blue <= 4'h2;
end
else if (((pixel_x >= 326) && (pixel_x <= 343)) && ((pixel_y >= 212) && (pixel_y <= 261))) begin
red <= 4'h7; green <= 4'h2; blue <= 4'h2;
end
else if (((pixel_x >= 108) && (pixel_x <= 119)) && ((pixel_y >= 250) && (pixel_y <= 337))) begin
red <= 4'h7; green <= 4'h2; blue <= 4'h2;
end
else if (((pixel_x >= 609) && (pixel_x <= 616)) && ((pixel_y >= 123) && (pixel_y <= 244))) begin
red <= 4'h7; green <= 4'h2; blue <= 4'h2;
end
else if (((pixel_x >= 143) && (pixel_x <= 177)) && ((pixel_y >= 4) && (pixel_y <= 78))) begin
red <= 4'h7; green <= 4'h2; blue <= 4'h2;
end
else if (((pixel_x >= 475) && (pixel_x <= 491)) && ((pixel_y >= 299) && (pixel_y <= 331))) begin
red <= 4'h5; green <= 4'h5; blue <= 4'h5;
end
else if (((pixel_x >= 477) && (pixel_x <= 489)) && ((pixel_y >= 294) && (pixel_y <= 314))) begin
red <= 4'hF; green <= 4'hF; blue <= 4'hF;
end
else if (((pixel_x >= 477) && (pixel_x <= 489)) && ((pixel_y >= 326) && (pixel_y <= 365))) begin
red <= 4'hF; green <= 4'hF; blue <= 4'hF;
end
else if (((pixel_x >= 476) && (pixel_x <= 490)) && ((pixel_y >= 317) && (pixel_y <= 319))) begin
red <= 4'h7; green <= 4'h2; blue <= 4'h2;
end

        case(score)
            0: begin // Pixels for a, b, c, d, e, f
    if ((((pixel_x >= a_x_start) && (pixel_x <= a_x_end)) && ((pixel_y >= a_y_start) && (pixel_y <= a_y_end)))||
        (((pixel_x >= b_x_start) && (pixel_x <= b_x_end)) && ((pixel_y >= b_y_start) && (pixel_y <= b_y_end)))||
        (((pixel_x >= c_x_start) && (pixel_x <= c_x_end)) && ((pixel_y >= c_y_start) && (pixel_y <= c_y_end)))||
        (((pixel_x >= d_x_start) && (pixel_x <= d_x_end)) && ((pixel_y >= d_y_start) && (pixel_y <= d_y_end)))||
        (((pixel_x >= e_x_start) && (pixel_x <= e_x_end)) && ((pixel_y >= e_y_start) && (pixel_y <= e_y_end)))||
        (((pixel_x >= f_x_start) && (pixel_x <= f_x_end)) && ((pixel_y >= f_y_start) && (pixel_y <= f_y_end))))
     begin
        red <= 4'hF; green <= 4'hF; blue <= 4'hF;
    end
  
//else red = 4'h0; blue = 4'h0; green = 4'hF;
end

    //for one
                1: begin 
                if (((pixel_x >= b_x_start) && (pixel_x <= b_x_end)) && ((pixel_y >= b_y_start) && (pixel_y <= b_y_end)) || (((pixel_x >= c_x_start) && (pixel_x <= c_x_end)) && ((pixel_y >= c_y_start) && (pixel_y <= c_y_end)))) begin
                    red <= 4'hF; green <= 4'hF; blue <= 4'hF;
                end
//                else if ((pixel_x - x_add) ** 2 + (pixel_y - y_add) ** 2 <= circle_radius ** 2)
//            red = 4'hF;  // Pixel is inside the circle, set blue color
//    else red = 4'h0;blue = 4'h0; green = 4'h0;
                end
                
   // for two
                 2: begin 
                if ((((pixel_x >= a_x_start) && (pixel_x <= a_x_end)) && ((pixel_y >= a_y_start) && (pixel_y <= a_y_end))) ||
                 (((pixel_x >= b_x_start) && (pixel_x <= b_x_end)) && ((pixel_y >= b_y_start) && (pixel_y <= b_y_end)))||
                 (((pixel_x >= g_x_start) && (pixel_x <= g_x_end)) && ((pixel_y >= g_y_start) && (pixel_y <= g_y_end)))||
                 (((pixel_x >= d_x_start) && (pixel_x <= d_x_end)) && ((pixel_y >= d_y_start) && (pixel_y <= d_y_end)))||
                 (((pixel_x >= e_x_start) && (pixel_x <= e_x_end)) && ((pixel_y >= e_y_start) && (pixel_y <= e_y_end))))
                 begin
                    red <= 4'hF; green <= 4'hF; blue <= 4'hF;
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
                    red <= 4'hF; green <= 4'hF; blue <= 4'hF;
                end
                end

     //for 4
                4: begin // Pixels for b, c, f, g
    if ((((pixel_x >= b_x_start) && (pixel_x <= b_x_end)) && ((pixel_y >= b_y_start) && (pixel_y <= b_y_end)))||
        (((pixel_x >= c_x_start) && (pixel_x <= c_x_end)) && ((pixel_y >= c_y_start) && (pixel_y <= c_y_end)))||
        (((pixel_x >= f_x_start) && (pixel_x <= f_x_end)) && ((pixel_y >= f_y_start) && (pixel_y <= f_y_end)))||
        (((pixel_x >= g_x_start) && (pixel_x <= g_x_end)) && ((pixel_y >= g_y_start) && (pixel_y <= g_y_end))))
     begin
        red <= 4'hF; green <= 4'hF; blue <= 4'hF;
    end
//    else if ((pixel_x - x_add) ** 2 + (pixel_y - y_add) ** 2 <= circle_radius ** 2)
//            red <= 4'hF;  // Pixel is inside the circle, set blue color
//    else red = 4'h0;blue = 4'h0; green = 4'h0;
end

      //for 5
                5: begin 
                if ((((pixel_x >= a_x_start) && (pixel_x <= a_x_end)) && ((pixel_y >= a_y_start) && (pixel_y <= a_y_end)))||
                   (((pixel_x >= c_x_start) && (pixel_x <= c_x_end)) && ((pixel_y >= c_y_start) && (pixel_y <= c_y_end)))||
                   (((pixel_x >= d_x_start) && (pixel_x <= d_x_end)) && ((pixel_y >= d_y_start) && (pixel_y <= d_y_end)))||
                   (((pixel_x >= g_x_start) && (pixel_x <= g_x_end)) && ((pixel_y >= g_y_start) && (pixel_y <= g_y_end)))||
                   (((pixel_x >= f_x_start) && (pixel_x <= f_x_end)) && ((pixel_y >= f_y_start) && (pixel_y <= f_y_end))))
                 begin
                    red <= 4'hF; green <= 4'hF; blue <= 4'hF;
                end
//               else if ((pixel_x - x_add) ** 2 + (pixel_y - y_add) ** 2 <= circle_radius ** 2)
//            red = 4'hF;  // Pixel is inside the circle, set blue color
//    else red = 4'h0;blue = 4'h0; green = 4'h0;
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
                red <= 4'hF; green <= 4'hF; blue <= 4'hF;
            end
//            else if ((pixel_x - x_add) ** 2 + (pixel_y - y_add) ** 2 <= circle_radius ** 2)
//            red = 4'hF;  // Pixel is inside the circle, set blue color
//    else red = 4'h0;blue = 4'h0; green = 4'h0;
        end
               7: begin // Pixels for a, b, c
            if ((((pixel_x >= a_x_start) && (pixel_x <= a_x_end)) && ((pixel_y >= a_y_start) && (pixel_y <= a_y_end)))||
                (((pixel_x >= b_x_start) && (pixel_x <= b_x_end)) && ((pixel_y >= b_y_start) && (pixel_y <= b_y_end)))||
                (((pixel_x >= c_x_start) && (pixel_x <= c_x_end)) && ((pixel_y >= c_y_start) && (pixel_y <= c_y_end))))
             begin
                red <= 4'hF; green <= 4'hF; blue <= 4'hF;
            end
//            else if ((pixel_x - x_add) ** 2 + (pixel_y - y_add) ** 2 <= circle_radius ** 2)
//            red = 4'hF;  // Pixel is inside the circle, set blue color
//    else red = 4'h0;blue = 4'h0; green = 4'h0;
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
                red <= 4'hF; green <= 4'hF; blue <= 4'hF;
            end
//            else if ((pixel_x - x_add) ** 2 + (pixel_y - y_add) ** 2 <= circle_radius ** 2)
//            red = 4'hF;  // Pixel is inside the circle, set blue color
//    else red = 4'h0;blue = 4'h0; green = 4'h0;
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
                red <= 4'hF; green <= 4'hF ; blue <= 4'hF;
            end
//            else if ((pixel_x - x_add) ** 2 + (pixel_y - y_add) ** 2 <= circle_radius ** 2)
//            red = 4'hF;  // Pixel is inside the circle, set blue color
//    else red = 4'h0;blue = 4'h0; green = 4'h0;
else begin
red <= video_on? 4'hF: 4'h0;
blue <= video_on? 4'hF: 4'h0;
green <= video_on? 4'hF: 4'h0;
if ((((pixel_x >= (one_x_s - 100)) && (pixel_x <= (one_x_e - 100))) && ((pixel_y >= one_y_s) && (pixel_y <= one_y_e)))||
            (((pixel_x >= (five_x_s - 100)) && (pixel_x <= (five_x_e - 100))) && ((pixel_y >= five_y_s) && (pixel_y <= five_y_e)))||
            (((pixel_x >= (six_x_s - 100)) && (pixel_x <= (six_x_e - 100))) && ((pixel_y >= six_y_s) && (pixel_y <= six_y_e)))||
            (((pixel_x >= ten_x_s - 100) && (pixel_x <= ten_x_e - 100)) && ((pixel_y >= ten_y_s) && (pixel_y <= ten_y_e)))||
            (((pixel_x >= (twelve_x_s - 100)) && (pixel_x <= (twelve_x_e - 100))) && ((pixel_y >= twelve_y_s) && (pixel_y <= twelve_y_e)))||
            (((pixel_x >= (thirteen_x_s - 100)) && (pixel_x <= (thirteen_x_e - 100))) && ((pixel_y >= thirteen_y_s) && (pixel_y <= thirteen_y_e)))||
            (((pixel_x >= (fourteen_x_s - 100)) && (pixel_x <= (fourteen_x_e - 100))) && ((pixel_y >= fourteen_y_s) && (pixel_y <= fourteen_y_e)))||
            (((pixel_x >= (eighteen_x_s - 100)) && (pixel_x <= (eighteen_x_e - 100))) && ((pixel_y >= eighteen_y_s) && (pixel_y <= eighteen_y_e)))||
            (((pixel_x >= (twentythree_x_s - 100)) && (pixel_x <= (twentythree_x_e - 100))) && ((pixel_y >= twentythree_y_s) && (pixel_y <= twentythree_y_e)))||
            (((pixel_x >= (two_x_s + 18)) && (pixel_x <= (two_x_e + 18))) && ((pixel_y >= two_y_s) && (pixel_y <= two_y_e)))||
            (((pixel_x >= (six_x_s + 18)) && (pixel_x <= (six_x_e + 18))) && ((pixel_y >= six_y_s) && (pixel_y <= six_y_e)))||
            (((pixel_x >= (eleven_x_s + 18)) && (pixel_x <= (eleven_x_e + 18))) && ((pixel_y >= eleven_y_s) && (pixel_y <= eleven_y_e)))||
            (((pixel_x >= (sixteen_x_s + 18)) && (pixel_x <= (sixteen_x_e + 18))) && ((pixel_y >= sixteen_y_s) && (pixel_y <= sixteen_y_e)))||
            (((pixel_x >= (twenty_x_s + 18)) && (pixel_x <= (twenty_x_e + 18))) && ((pixel_y >= twenty_y_s) && (pixel_y <= twenty_y_e)))||
            (((pixel_x >= (twentytwo_x_s + 18)) && (pixel_x <= (twentytwo_x_e + 18))) && ((pixel_y >= twentytwo_y_s) && (pixel_y <= twentytwo_y_e)))||
            (((pixel_x >= (twentythree_x_s + 18)) && (pixel_x <= (twentythree_x_e + 18))) && ((pixel_y >= twentythree_y_s) && (pixel_y <= twentythree_y_e)))||
            (((pixel_x >= (three_x_s + 18)) && (pixel_x <= (three_x_e + 18))) && ((pixel_y >= three_y_s) && (pixel_y <= three_y_e)))||
            (((pixel_x >= (four_x_s + 18)) && (pixel_x <= (four_x_e + 18))) && ((pixel_y >= four_y_s) && (pixel_y <= four_y_e)))||
            (((pixel_x >= (ten_x_s + 18)) && (pixel_x <= (ten_x_e + 18))) && ((pixel_y >= ten_y_s) && (pixel_y <= ten_y_e)))||
            (((pixel_x >= (thirteen_x_s + 18)) && (pixel_x <= (thirteen_x_e + 18))) && ((pixel_y >= thirteen_y_s) && (pixel_y <= thirteen_y_e)))||
            (((pixel_x >= (fifteen_x_s + 18)) && (pixel_x <= (fifteen_x_e + 18))) && ((pixel_y >= fifteen_y_s) && (pixel_y <= fifteen_y_e)))||
            (((pixel_x >= (twentyfour_x_s + 18)) && (pixel_x <= (twentyfour_x_e + 18))) && ((pixel_y >= twentyfour_y_s) && (pixel_y <= twentyfour_y_e)))||
          (((pixel_x >= (one_x_s + 130)) && (pixel_x <= (one_x_e + 130))) && ((pixel_y >= one_y_s) && (pixel_y <= one_y_e)))||
          (((pixel_x >= (sixteen_x_s + 130)) && (pixel_x <= (sixteen_x_e + 130))) && ((pixel_y >= sixteen_y_s) && (pixel_y <= sixteen_y_e)))||
        (((pixel_x >= (six_x_s + 130)) && (pixel_x <= (six_x_e + 130))) && ((pixel_y >= six_y_s) && (pixel_y <= six_y_e)))||
        (((pixel_x >= (eleven_x_s + 130)) && (pixel_x <= (eleven_x_e + 130))) && ((pixel_y >= eleven_y_s) && (pixel_y <= eleven_y_e)))||
        (((pixel_x >= (twentytwo_x_s + 125)) && (pixel_x <= (twentytwo_x_e + 125))) && ((pixel_y >= twentytwo_y_s) && (pixel_y <= twentytwo_y_e)))||
        (((pixel_x >= (twentythree_x_s + 125)) && (pixel_x <= (twentythree_x_e + 125))) && ((pixel_y >= twentythree_y_s) && (pixel_y <= twentythree_y_e)))||
        (((pixel_x >= (twentyfour_x_s + 125)) && (pixel_x <= (twentyfour_x_e + 125))) && ((pixel_y >= twentyfour_y_s) && (pixel_y <= twentyfour_y_e)))||
        (((pixel_x >= (twenty_x_s + 125)) && (pixel_x <= (twenty_x_e + 125))) && ((pixel_y >= twenty_y_s) && (pixel_y <= twenty_y_e)))||
        (((pixel_x >= (fifteen_x_s + 125)) && (pixel_x <= (fifteen_x_e + 125))) && ((pixel_y >= fifteen_y_s) && (pixel_y <= fifteen_y_e)))||
        (((pixel_x >= (ten_x_s + 125)) && (pixel_x <= (ten_x_e + 125))) && ((pixel_y >= ten_y_s) && (pixel_y <= ten_y_e)))||
        (((pixel_x >= (five_x_s + 125)) && (pixel_x <= (five_x_e + 125))) && ((pixel_y >= five_y_s) && (pixel_y <= five_y_e)))||



            // win ka w
           (((pixel_x >= one_x_s - 100) && (pixel_x <= one_x_e - 100)) && ((pixel_y >= one_y_s + 150) && (pixel_y <= one_y_e + 150)))||
        (((pixel_x >= six_x_s - 100) && (pixel_x <= six_x_e - 100)) && ((pixel_y >= six_y_s + 150) && (pixel_y <= six_y_e + 150)))||
        (((pixel_x >= eleven_x_s - 100) && (pixel_x <= eleven_x_e - 100)) && ((pixel_y >= eleven_y_s + 150) && (pixel_y <= eleven_y_e + 150)))||
        (((pixel_x >= sixteen_x_s - 100) && (pixel_x <= sixteen_x_e - 100)) && ((pixel_y >= sixteen_y_s + 150) && (pixel_y <= sixteen_y_e + 150)))||
        (((pixel_x >= twentyone_x_s - 100) && (pixel_x <= twentyone_x_e - 100)) && ((pixel_y >= twentyone_y_s + 150) && (pixel_y <= twentyone_y_e + 150)))||
        (((pixel_x >= seventeen_x_s - 100) && (pixel_x <= seventeen_x_e - 100)) && ((pixel_y >= seventeen_y_s + 150) && (pixel_y <= seventeen_y_e + 150)))||
        (((pixel_x >= thirteen_x_s - 100) && (pixel_x <= thirteen_x_e - 100)) && ((pixel_y >= thirteen_y_s + 150) && (pixel_y <= thirteen_y_e + 150)))||
        (((pixel_x >= nineteen_x_s - 100) && (pixel_x <= nineteen_x_e - 100)) && ((pixel_y >= nineteen_y_s + 150) && (pixel_y <= nineteen_y_e + 150)))||
        (((pixel_x >= twentyfive_x_s - 100) && (pixel_x <= twentyfive_x_e - 100)) && ((pixel_y >= twentyfive_y_s + 150) && (pixel_y <= twentyfive_y_e + 150)))||
        (((pixel_x >= twenty_x_s - 100) && (pixel_x <= twenty_x_e - 100)) && ((pixel_y >= twenty_y_s + 150) && (pixel_y <= twenty_y_e + 150)))||
        (((pixel_x >= fifteen_x_s - 100) && (pixel_x <= fifteen_x_e - 100)) && ((pixel_y >= fifteen_y_s + 150) && (pixel_y <= fifteen_y_e + 150)))||
        (((pixel_x >= ten_x_s - 100) && (pixel_x <= ten_x_e - 100)) && ((pixel_y >= ten_y_s + 150) && (pixel_y <= ten_y_e + 150)))||
        (((pixel_x >= five_x_s - 100) && (pixel_x <= five_x_e - 100)) && ((pixel_y >= five_y_s + 150) && (pixel_y <= five_y_e + 150)))||
            //win ka I          
        (((pixel_x >= three_x_s + 10) && (pixel_x <= three_x_e + 10)) && ((pixel_y >= three_y_s + 150) && (pixel_y <= three_y_e + 150)))||
        (((pixel_x >= eight_x_s + 10) && (pixel_x <= eight_x_e + 10)) && ((pixel_y >= eight_y_s + 150) && (pixel_y <= eight_y_e + 150)))||
        (((pixel_x >= thirteen_x_s + 10) && (pixel_x <= thirteen_x_e + 10)) && ((pixel_y >= thirteen_y_s + 150) && (pixel_y <= thirteen_y_e + 150)))||
        (((pixel_x >= eighteen_x_s + 10) && (pixel_x <= eighteen_x_e + 10)) && ((pixel_y >= eighteen_y_s + 150) && (pixel_y <= eighteen_y_e + 150)))||
        (((pixel_x >= twentythree_x_s + 10) && (pixel_x <= twentythree_x_e + 10)) && ((pixel_y >= twentythree_y_s + 150) && (pixel_y <= twentythree_y_e + 150)))||
        //win ka N
      (((pixel_x >= (one_x_s + 100)) && (pixel_x <= (one_x_e + 100))) && ((pixel_y >= one_y_s + 150) && (pixel_y <= one_y_e + 150)))||
    (((pixel_x >= (six_x_s + 100)) && (pixel_x <= (six_x_e + 100))) && ((pixel_y >= six_y_s + 150) && (pixel_y <= six_y_e + 150)))||
    (((pixel_x >= (eleven_x_s + 100)) && (pixel_x <= (eleven_x_e + 100))) && ((pixel_y >= eleven_y_s + 150) && (pixel_y <= eleven_y_e + 150)))||
    (((pixel_x >= (sixteen_x_s + 100)) && (pixel_x <= (sixteen_x_e + 100))) && ((pixel_y >= sixteen_y_s + 150) && (pixel_y <= sixteen_y_e + 150)))||
    (((pixel_x >= (twentyone_x_s + 100)) && (pixel_x <= (twentyone_x_e + 100))) && ((pixel_y >= twentyone_y_s + 150) && (pixel_y <= twentyone_y_e + 150)))||
    (((pixel_x >= (seven_x_s + 100)) && (pixel_x <= (seven_x_e + 100))) && ((pixel_y >= seven_y_s + 150) && (pixel_y <= seven_y_e + 150)))||
    (((pixel_x >= (thirteen_x_s + 100)) && (pixel_x <= (thirteen_x_e + 100))) && ((pixel_y >= thirteen_y_s + 150) && (pixel_y <= thirteen_y_e + 150)))||
    (((pixel_x >= (nineteen_x_s + 100)) && (pixel_x <= (nineteen_x_e + 100))) && ((pixel_y >= nineteen_y_s + 150) && (pixel_y <= nineteen_y_e + 150)))||
    (((pixel_x >= (twenty_x_s + 100)) && (pixel_x <= (twenty_x_e + 100))) && ((pixel_y >= twenty_y_s + 150) && (pixel_y <= twenty_y_e + 150)))||
    (((pixel_x >= (five_x_s + 100)) && (pixel_x <= (five_x_e + 100))) && ((pixel_y >= five_y_s + 150) && (pixel_y <= five_y_e + 150)))||
    (((pixel_x >= (ten_x_s + 100)) && (pixel_x <= (ten_x_e + 100))) && ((pixel_y >= ten_y_s + 150) && (pixel_y <= ten_y_e + 150)))||
    (((pixel_x >= (fifteen_x_s + 100)) && (pixel_x <= (fifteen_x_e + 100))) && ((pixel_y >= fifteen_y_s + 150) && (pixel_y <= fifteen_y_e + 150)))||
    (((pixel_x >= (twentyfive_x_s + 100)) && (pixel_x <= (twentyfive_x_e + 100))) && ((pixel_y >= twentyfive_y_s + 150) && (pixel_y <= twentyfive_y_e + 150))))
        begin
   red <= 4'h7; green <= 4'h2; blue <= 4'h2;
end 
    else if ((((pixel_x <= 450+52+5+50+5) && (pixel_x >=450+5+50+5))&&((pixel_y <=200+8) && (pixel_y >=200))) ||
                (((pixel_x <= 450+8+5+50+5) && (pixel_x >=450+5+50+5))&&((pixel_y <=200+39) && (pixel_y >=200))) || 
                (((pixel_x <= 450+52+5+50+5) && (pixel_x >=450+44+5+50+5))&&((pixel_y <=200+39) && (pixel_y >=200))) ||
                (((pixel_x <= 450+52+5+50+5) && (pixel_x >=450+5+50+5))&&((pixel_y <=200+39) && (pixel_y >=200+31))) ||
                (((pixel_x <= 450+23+5+50+5) && (pixel_x >=450+15+5+50+5))&&((pixel_y <=200+23) && (pixel_y >=200+15)))||
                (((pixel_x <= 450+38+5+50+5) && (pixel_x >=450+30+5+50+5))&&((pixel_y <=200+23) && (pixel_y >=200+15))) ||
                (((pixel_x <= 450+42+5+50+5) && (pixel_x >=450+10+5+50+5))&&((pixel_y <=200+41) && (pixel_y >=200+33))) ||
                (((pixel_x <= 450+18+5+50+5) && (pixel_x >=450+10+5+50+5))&&((pixel_y <=200+72) && (pixel_y >=200+33))) ||
                (((pixel_x <= 450+42+5+50+5) && (pixel_x >=450+34+5+50+5))&&((pixel_y <=200+72) && (pixel_y >=200+33))) ||
                (((pixel_x <= 450+42+5+50+5) && (pixel_x >=450+10+5+50+5))&&((pixel_y <=200+72) && (pixel_y >=200+64))) ||
                (((pixel_x <= 450+9+5+50+5) && (pixel_x >=450+5+50+5))&&((pixel_y <=200+60) && (pixel_y >=200+51))) ||
                (((pixel_x <= 450+52+5+50+5) && (pixel_x >=450+43+5+50+5))&&((pixel_y <=200+60) && (pixel_y >=200+51))) ||
                (((pixel_x <= 450+24+5+50+5) && (pixel_x >=450+15+5+50+5))&&((pixel_y <=200+88) && (pixel_y >=200+73))) ||
                (((pixel_x <=450+38+5+50+5) && (pixel_x >=450+29+5+50+5))&&((pixel_y <=200+88) && (pixel_y >=200+73))) ) begin
           
    red <= 4'h2; green <= 4'h2; blue <= 4'h7;
    end
     else if (pixel_x >= 510 && pixel_y <= 110) begin
    red <= 4'h0; blue <= 4'h0; green <=4'h0;
    end
    else if ((pixel_x >= 472+50 && pixel_x <= 480+50 && pixel_y >= 190 && pixel_y <= 200)|| (pixel_x >= 472+50 && pixel_x <= 540+50 && pixel_y >= 182 && pixel_y <= 190) || (pixel_x >= 532+50 && pixel_x <= 540+50 && pixel_y >= 190 && pixel_y <= 280)) begin 
    red <= 4'h0; blue <= 4'h0; green <=4'h0;
    end
end
        end
        
                endcase  
          
    end
end


//always @(posedge clk_d) begin
//    if (video_on == 1) begin
////        red <= 4'h0; green <= 4'h0; blue <= 4'h0;

//        // Check which pixels to light up based on the score
        
//    end
//end

    endmodule