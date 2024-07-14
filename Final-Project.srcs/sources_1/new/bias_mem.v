`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/25 01:15:13
// Design Name: 
// Module Name: bias_mem
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


module bias_mem#(parameter numbias = 128,addressWidth=7,dataWidth = 32) 
    (
    input clk,
    //input wen,
    input bias_ren,
    //input [addressWidth-1:0] wadd,
    input [addressWidth-1:0] radd,
    input [dataWidth-1:0] win,
    output reg [dataWidth-1:0] bout
    );
    
    reg [dataWidth-1:0] bias_mem [0: numbias-1];
    
    initial begin
        $readmemh("C:\\Users\\22770\\OneDrive - Johns Hopkins\\Low Power FPGA\\Final Project", bias_mem);
    end
    
    always @(posedge clk)begin
        if(bias_ren)begin
            bout <= bias_mem[radd];
        end 
    end
    
    
   
endmodule
