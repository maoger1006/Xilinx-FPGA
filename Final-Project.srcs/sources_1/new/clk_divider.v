`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/09 00:56:26
// Design Name: 
// Module Name: clk_divider
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


module clk_divider(
    input clk,
    output reg clk_div
    );
    
    reg[19:0] counter = 20'd0;
    parameter divisor = 20'd1000;
    
    always @(posedge clk)
        begin
    counter <= counter + 20'd1;
    
    if (counter >= (divisor - 1)) begin
        counter <= 20'd0;
    end
    
    clk_div <= (counter<divisor/2)?1'b1:1'b0;

end    
endmodule
