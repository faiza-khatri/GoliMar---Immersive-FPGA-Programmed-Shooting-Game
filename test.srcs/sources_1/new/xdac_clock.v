`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/20/2024 03:21:36 PM
// Design Name: 
// Module Name: xdac_clock
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


module xdac_clock(input clk, output reg VGA_clk);

//divides 100 MHz clock to 100Hz 
    integer check = 10000000;
    integer a = 0;
	always@(posedge clk)
 begin 
        if(a<check) begin
            a <= a + 1;
            VGA_clk <= 0;
        end
        else begin
            a <= 0;
            VGA_clk <= 1;
        end
	end
	
endmodule
