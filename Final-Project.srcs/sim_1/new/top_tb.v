`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/27 00:13:24
// Design Name: 
// Module Name: top_tb
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


module top_tb(
    
    );
    
    reg signed [8:0] pixel_mem [0:783];
    reg signed [8:0] pixel_input;
    reg [9:0]  pixel_addr;   // control which pixel 
    
    //reg [1:0 ]relu_en;  put in neuron
    wire [1:0] wr_en;
    wire [31:0] out;
    reg [7:0]  neuro_num;
    reg signed [31:0] features_1[0:127];
    reg signed [31:0] features_2[0:9];
    reg signed [31:0] maxvalue;
    reg [3:0] max_class;
    wire [9:0] counter;
    reg  clk;
    reg [1:0] step2_en;
    reg [1:0] step3_en;
    reg [9:0] feature_addr;
    wire [9:0] counter1;
    reg [7:0] class_num;
    wire [31:0] out1;
    wire [1:0] wr_en1;
    reg signed [20:0] feature_input;
    reg [5:0] class_counter;
    wire [3:0]sw;
    
    assign sw = max_class;
    
    always begin
        # 7.5
        clk = ~clk;  
    end
    

        
    initial begin
        $readmemb ("C:\\Users\\22770\\Desktop\\Low Power FPGA\\Final Project\\image_example_out1.txt", pixel_mem);
        pixel_addr <= 0;
        neuro_num <= 0; 
        clk <= 1;
        feature_addr <= 0;
        class_num <= 0;
        maxvalue <= 0;
        max_class <= 0;
        class_counter <= 0;
        step2_en <= 0;
        step3_en <= 0;
    end 
    

    
    
    always @ (posedge clk)begin
        if (rst)begin
            pixel_addr <= 0;
        end
        else if(counter <= 782 || counter == 785) begin
            pixel_addr <= pixel_addr + 1;  
            if (pixel_addr >= 783)begin
                pixel_addr <= 0;
            end     
        end
    end
    
    always@ (posedge clk)begin
        pixel_input <= pixel_mem[pixel_addr];
    end

    always @ (posedge clk)begin
        if (rst)begin
            neuro_num <= 0;
        end
        else begin
            if(counter >= 785)begin    // pixel_addr >= 783
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
        if(neuro_num <= 127)begin
          if (rst)begin
                       
           end
           else begin
             if (wr_en)begin                       
                features_1[neuro_num] <= out;
                if (neuro_num ==127)begin
                    step2_en <= 1;
                end
             end
        end
      end
    end
    
///////////////////////////////////////////////////////////
    // assign step2_en = features_1[127][0] !== 1'bx ? 1 : 0;
    
    always @(posedge clk)begin
        if (step2_en)begin
            if (rst)begin
                 feature_addr <= 0;
            end
            else if(counter1 <= 126 || counter1 == 129) begin
            feature_addr <= feature_addr + 1;  
                if (feature_addr >= 127)begin
                feature_addr <= 0;
                end     
            end
        end
    end
    
    always @(posedge clk)begin
        if (step2_en)begin 
            feature_input <= features_1[feature_addr];
        end
    end
    
    always @ (posedge clk)begin
      if (step2_en)begin
        if (rst)begin
            class_num <= 0;
        end
        else begin
            if(counter1 >= 129)begin    // pixel_addr >= 783
                class_num <= class_num + 1;
            end
        end
      end
    end
    
    
    
    always @(posedge clk)begin
     if(! step3_en )begin
      if(step2_en)begin
        if (rst)begin
                       
        end
        else begin
            if (wr_en1)begin                       
                features_2[class_num] <= out1;
                if (class_num == 9)begin
                    step3_en <= 1;
                end
            end
        end
      end
      end
     end    
     
    //assign step3_en = features_2[9][0] !== 1'bx ? 1 : 0;
    
    always @(posedge clk)begin
        if (step3_en)begin
  
            if (features_2[class_counter] >= maxvalue) begin
                maxvalue <= features_2[class_counter];
                max_class <= class_counter;
            end
        end
    end
    
    
    always @(posedge clk)begin
        if (step3_en)begin
          if(class_counter<=9)begin
                class_counter = class_counter + 1;
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
    .counter(counter)
    );
    
    
    
    
    neuron2 uut2(
    .clk(clk),
    .rst(rst),
    .pixel_input(feature_input),
    .step2_en(step2_en),
    .neuro_num(class_num),
    .wr_en(wr_en1),
    .out1(out1),
    .counter1(counter1)
    );
    
    
endmodule
