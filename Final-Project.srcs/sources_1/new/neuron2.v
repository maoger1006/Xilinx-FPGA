`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/03 16:43:54
// Design Name: 
// Module Name: neuron2
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


module neuron2
    (input           clk,
    input           rst,
    input [20:0]    pixel_input,
    input [1:0] step2_en,
    input [7:0]    neuro_num,
//    input [1:0]  relu_en,
    output wire [1:0]   wr_en,
    output [31:0]    out1,
//    output wire [1:0]  read_en,
//    output wire [1:0] neuron_en
    output reg [9:0] counter1
    );
    
    reg [1:0] re_en;
    reg [1:0]  relu_en;
    reg signed [31 : 0]   mul; 
    reg signed [31 : 0]   sum = 0;
    
    reg [7:0]  w_out;
    
    reg signed [8:0] mem_weights [0: 1279];
    reg [10:0] weight_addr;

    reg [1:0] weight_en;
    reg [1:0] neuron_en1;
    
    initial begin
        $readmemh("C:\\Users\\22770\\Desktop\\Low Power FPGA\\Final Project\\weights2_out.txt", mem_weights);
        weight_addr <= 0 ;
        counter1 <= 0;
        sum <= 0;
    end
     
    always @(posedge clk)begin
      if (step2_en)begin
        if (rst)begin
            weight_addr <= neuro_num * 10'd784;
        end
        else if (counter1 <= 126 || counter1 == 129) begin
            weight_addr <= weight_addr + 1;
        end
      end
    end
       
    always @(posedge clk)begin
      if (step2_en)begin
        w_out <= mem_weights[weight_addr];
      end
    end
    
    always @(negedge clk)begin
      if (step2_en)begin
        mul <= $signed({1'b0,pixel_input}) * $signed(w_out);
      end
    end
    
   // sum 
   always @ (posedge clk)begin
     if(step2_en)begin
       if (counter1 <= 128 && counter1 >= 1)begin
            sum <= sum + mul;
       end
       else begin
            sum <= 32'b0;
       end
     end
   end  
   
   //  counter 
   always @ (posedge clk)begin
     if (step2_en)begin
       if (counter1 <129)begin       
         counter1 <= counter1 + 1;
       end
       else begin
            counter1 <= 0;
       end
     end
   end
   
   // weight_read_en
//   always @ (posedge  clk)begin
//       if (counter >= 127)begin
//          weight_en <= 0;       
//       end
//       else begin
//          weight_en <= 1;
//       end
//   end
   
//   assign read_en = weight_en;
   
   // neuron enable 
//   always @ (posedge clk)begin
//        if (counter > 128)begin
//            neuron_en1 <= 1;
//        end
//        else begin
//            neuron_en1 <= 0;
//        end
//   end
//    assign neuron_en = neuron_en1;
    
   //relu_en
   always @ (posedge clk) begin
        if (counter1 == 128 )begin //counter1 >= 127
            relu_en <= 1;
        end
        else begin
            relu_en <= 0;
        end
   end
   
   assign wr_en = relu_en;

//Functions

  assign out1 = sum;
  
//  relu uut1(
//       .clk(clk),
//       .wr_en(relu_en),
//       .x(sum),
//       .out(out_1)
//  );  
    
    
    
endmodule
