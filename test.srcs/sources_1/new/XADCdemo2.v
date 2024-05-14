`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Design Name: 
// Module Name: // Project Name: 
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
 

module XADCdemo2(
   input CLK100MHZ,
   input vauxp6,
   input vauxn6,
   input vauxp7,
   input vauxn7,
   input vauxp15,
   input vauxn15,
   input vauxp14,
   input vauxn14,
   output reg [3:0] Vrx
 );
   
  
   
   wire enable;  
   wire ready;
   wire [15:0] data;   
   reg [6:0] Address_in = 8'h16;     
   reg sw;
   reg [32:0] delay;
   


   //xadc instantiation connect the eoc_out .den_in to get continuous conversion
   xadc_wiz_0  XLXI_8 (.daddr_in(Address_in), //addresses can be found in the artix 7 XADC user guide DRP register space
                     .dclk_in(CLK100MHZ), 
                     .den_in(enable), 
                     .di_in(), 
                     .dwe_in(), 
                     .busy_out(),                    
                     .vauxp6(vauxp6),
                     .vauxn6(vauxn6),
                     .vauxp7(vauxp7),
                     .vauxn7(vauxn7),
                     .vauxp14(vauxp14),
                     .vauxn14(vauxn14),
                     .vauxp15(vauxp15),
                     .vauxn15(vauxn15),
                     .vn_in(), 
                     .vp_in(), 
                     .alarm_out(), 
                     .do_out(data), 
                     //.reset_in(),
                     .eoc_out(enable),
                     .channel_out(),
                     .drdy_out(ready));
                     
         
    
//      initial
//      begin
//      sw=0;
//      end
      
//      always @(posedge(CLK100MHZ))
//      begin
//        if (delay == 10) // the huge value of this delay is for testing purposes. for using the joystick in the game, teh value should be reduced to check x and y values more frequently.
//            begin
//            sw = ~sw; 
//            if (sw) // toggle to Vry address
//               Address_in <= 8'h1e;
//            else // toggle back to Vrx address
//               Address_in <= 8'h16;
//            delay = 0;
//            end
//        else
//            delay = delay+1;
//     end
        
        
      
      
      // Always block for Vrx
always @(posedge CLK100MHZ) begin
  //if (sw) begin
    Vrx <= data[15:12];
  //end
  end
//always @(posedge CLK100MHZ) begin
//    if (~sw) begin
//    Vrx <= data[15:12];
//    end
//end


  
endmodule   