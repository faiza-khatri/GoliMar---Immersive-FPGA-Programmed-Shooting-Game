`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/10/2024 05:43:57 PM
// Design Name: 
// Module Name: score_box
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


module score_box(
     input clk_d,
    input d_inc,      // Input to increment score (1-bit)
    output reg [3:0] score  // Output score (4 bits to represent 0 to 9)
);

//    always @(posedge d_inc) begin
//        if (score < 9) begin
//            score <= score + 1;
//        end
//        end
always @(posedge clk_d) begin
score <= 4'h0;
    end

endmodule
