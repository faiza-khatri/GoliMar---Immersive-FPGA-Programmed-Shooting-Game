`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2024 10:56:04 PM
// Design Name: 
// Module Name: clk_div
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


module clk_div (clk, clk_d);
parameter div_value = 1;
input clk;
output clk_d;
reg clk_d; reg count;
initial
begin
clk_d = 0; count = 0;
end
always @(posedge clk)
begin
if (count == div_value)
count <= 0; // reset count
else
count <= count + 1; // count up
end
always @(posedge clk)
begin
if (count == div_value)
clk_d <= ~ clk_d; //toggle
end endmodule