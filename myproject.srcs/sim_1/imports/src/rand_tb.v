`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/08/2023 04:22:18 PM
// Design Name: 
// Module Name: rand_tb
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


module rand_tb(

    );
    reg clk = 1'b1;
    reg rand_reset;
    
    
    initial begin
        rand_reset = 1'b1;
        #10
        rand_reset = 0'b0;
    
    end
    always 
        begin
        clk = ~clk;
        #5;
    end
    
    wire [126:0] seed_in = {{7{16'haaaa}},15'h5aaa};

    wire [15:0] rand_out;

    
    rand127 myrand(
    .rand_out(rand_out),
    .seed_in (seed_in),
    .state_in(4'd0),
    .clock_in(clk),
    .reset_in(rand_reset)
  );

endmodule
