`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/01 15:33:07
// Design Name: 
// Module Name: top_tb2
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


module top_tb2(

    );
    
    reg signed [8:0] pixel_mem [0:783];
    reg signed [8:0] pixel_input;
    reg [9:0]  pixel_addr;   // control which pixel 
    
    //reg [1:0 ]relu_en;  put in neuron
    wire [1:0] wr_en;
    wire [31:0] out;
    reg [7:0]  neuro_num;
    reg [31:0] features_1[0:127];
    wire [1:0] read_en;
    reg  clk;
    wire [1:0] neuron_en;
    
    always begin
        #10
        clk = ~clk;  
    end
    
    
    initial begin
        $readmemb ("C:\\Users\\22770\\Desktop\\Low Power FPGA\\Final Project\\image_example_out.txt", pixel_mem);
        pixel_addr <= 0;
        neuro_num <= 0; 
        clk <= 0;
    end 
    
    
    always @ (posedge clk)begin
        if (rst)begin
            pixel_addr <= 0;
        end
        else if (read_en) begin
            pixel_addr <= pixel_addr + 1;  
            if (pixel_addr >= 783)begin
                pixel_addr <= 0;
            end     
        end
    end
    
    always@ (posedge clk)begin
        pixel_input <= pixel_mem[pixel_addr];
    end
    
    // neuron number
    always @ (posedge clk)begin
        if (rst)begin
            neuro_num <= 0;
        end
        else begin
            if(neuron_en)begin        //   if(pixel_addr >= 783)begin
                neuro_num <= neuro_num + 1;
            end
        end
    end
    
//    always @(posedge clk)begin          relu_en put in neuron
//        if (pixel_addr >= 784)begin
//            relu_en <= 1;
//        end
//        else begin
//            relu_en <= 0;
//        end
//    end
    
    // assign wr_en = (pixel_addr >= 783)? 1 : 0; // 784 Лђеп 784
        
    always @(posedge clk)begin
        if (rst)begin
                       
        end
        else begin
            if (wr_en)begin                       
                features_1[neuro_num] <= out;
            end
        end
    end
    
  
    
    /// neuron function
    neuron uut1(
    .clk(clk),
    .rst(rst),
    .pixel_input(pixel_input),
//    .relu_en(relu_en),
    .neuro_num(neuro_num),
    .wr_en(wr_en),
    .out (out),
    .read_en(read_en),
    .neuron_en(neuron_en)
    );
    
    
    
    
endmodule
