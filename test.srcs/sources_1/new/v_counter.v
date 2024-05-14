`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2024 10:52:14 PM
// Design Name: 
// Module Name: v_counter
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


module v_counter(clk, enable_v, v_count);
input clk;
input enable_v;
output [9:0] v_count;
reg [9:0] v_count;
initial v_count = 0;
always @(posedge clk)
begin
if ((enable_v)&(v_count<10'b1000001100))
        v_count <= v_count + 1;
        
else if (enable_v)
    v_count <= 10'b0;
end
    
endmodule
