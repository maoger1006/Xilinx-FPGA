`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/28 10:36:16
// Design Name: 
// Module Name: test_bench
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


module test_bench(

    );
    reg clk;
    
    reg wr_en;
    
    reg signed [31:0]  x;
    reg signed [8:0] mem_weights [0: 100351];
    wire [31:0] out; 
    
    reg signed [31:0] y;
    always begin
        # 10
        clk = ~clk;
    end
    
    initial begin
    
    $readmemh ("C:\\Users\\22770\\Desktop\\Low Power FPGA\\Final Project\\weights1_out.txt", mem_weights);
    clk = 0;
    wr_en = 0;
    x = -10;
    
    #20
    
    wr_en = 1;
    y = mem_weights[100350];
    #20
    
    x = 10;
    
    end
    
    relu uut1(
        .clk(clk),
        .wr_en(wr_en),
        .x(x),
        .out(out)
        );
    
endmodule
