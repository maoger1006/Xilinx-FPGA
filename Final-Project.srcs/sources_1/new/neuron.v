`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/24 17:20:41
// Design Name: 
// Module Name: neuron
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


module neuron #(dataWidth = 8, numWeight = 784, addressWidth = 10 )
   (input           clk,
    input           rst,
    input [dataWidth - 1:0]    pixel_input,

    input [7:0]    neuro_num,
//    input [1:0]  relu_en,
    output wire [1:0]   wr_en,
    output [31:0]    out,
//    output wire [1:0]  read_en,
//    output wire [1:0] neuron_en
    output reg [9:0] counter 
    );
    
    reg [1:0] re_en;
    reg [addressWidth : 0]   r_addr;
    reg signed [31 : 0]   mul; 
    reg signed [31 : 0]   sum = 0;
   // reg [31 : 0]  relu_in;
    reg [1:0] relu_en;
    reg [7:0]  w_out;
    
    // reg  [9:0] counter;
        
    reg signed [8:0] mem_weights [0: 100351];
    reg [16:0] weight_addr;        // 32bit
    wire [31:0] out_1;
//    reg [1:0] weight_en;
//    reg [1:0] neuron_en1;
    
    initial begin
        $readmemh("C:\\Users\\22770\\Desktop\\Low Power FPGA\\Final Project\\weights1_out.txt", mem_weights);
        weight_addr <= 0 ;
        counter <= 0;
        sum <= 0;
    end
     
    always @(posedge clk)begin
        if (rst)begin
            weight_addr <= neuro_num * 10'd784;
        end
        else if (counter <= 782 || counter == 785) begin
            weight_addr <= weight_addr + 1;
        end
    end
       
    always @(posedge clk)begin
        w_out <= mem_weights[weight_addr];
    end
    
    always @(negedge clk)begin
    
        mul <= $signed({1'b0,pixel_input}) * $signed(w_out);
        
    end
    
   // sum 
   always @ (posedge clk)begin
       if (counter <= 784 && counter >= 1)begin
            sum <= sum + mul;
       end
       else begin
            sum <= 32'b0;
       end
   end  
   
   //  counter 
   always @ (posedge clk)begin
       if (counter <785)begin       // counter <784
         counter <= counter + 1;
       end
       else begin
            counter <= 0;
       end
   end
    

    
   //relu_en
   always @ (posedge clk) begin
        if (counter >= 783 && counter <=784)begin  //counter >= 783
            relu_en <= 1;
        end
        else begin
            relu_en <= 0;
        end
   end
   
   assign wr_en = relu_en;

//Functions

  assign out = out_1;
  
  relu uut1(
       .clk(clk),
       .wr_en(relu_en),
       .x(sum),
       .out(out_1)
  );  
  
  

    
    
endmodule


