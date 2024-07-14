`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/24 16:45:56
// Design Name: 
// Module Name: relu
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


module relu (
    input clk,
    input wr_en,
    input[31:0] x,
    output reg [31:0] out
    );
    
    
always @(posedge clk)begin
 if (wr_en)begin
    if( $signed (x) >= 0)begin
        out <= x;
    end
    else
        out <= 0;
    end
 end
endmodule
