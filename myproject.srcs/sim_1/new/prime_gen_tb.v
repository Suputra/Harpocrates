`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/30/2023 10:57:12 AM
// Design Name: 
// Module Name: prime_gen_tb
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


module prime_gen_tb(

    );
    reg clk = 1'b1;
    reg reset;
    wire done;
    initial begin
        reset <= 1'b1;
        #10
        reset <= 1'b0;
    end
    always 
        begin
        clk = ~clk;
        #10;
    end
    
    always @(posedge clk) begin
        if (done) begin
            #100
            reset <= 1'b1;
        end
        if (reset) begin
            reset <= 1'b0;
        end 
    end
    
    wire [15:0] prime_out;
    reg [7:0] acc = 10;

    
    prime_gen #(.WORDSIZE(16)) p(
    .accuracy(acc),
    .clk(clk),
    .reset(reset),
    .done(done),
    .prime_out(prime_out)
    );



endmodule
