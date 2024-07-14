`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/25 12:06:21
// Design Name: 
// Module Name: neuron_tb
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


module neuron_tb(

    );
  //  reg  [7:0] pixel_mem [0:783];
    reg  [8:0] mem_weights [0: 100351];
    reg clk;
    
    reg signed test;
    always begin
  
        #10
        clk = ~clk;  
    end
    
    initial begin
        $readmemh ("C:\\Users\\22770\\Desktop\\Low Power FPGA\\Final Project\\weights1_out.txt", mem_weights);
        clk = 0;
    end 
    
    always @(posedge clk)begin
        test <= mem_weights[0];
    end
    
endmodule
