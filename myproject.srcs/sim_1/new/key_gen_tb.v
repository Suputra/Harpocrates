`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2023 10:13:12 PM
// Design Name: 
// Module Name: key_gen_tb
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


module key_gen_tb(

    );
    reg clk = 1'b1;
    reg reset;
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
        if (finish) begin
            #100
            reset <= 1'b1;
        end
        if (reset) begin
            reset <= 1'b0;
        end 
    end
    
    wire finish;
    wire [15:0] q;
    wire [31:0] p;
    wire [63:0] kappa;

    key_gen #(.eta(16), .lambda(32), .nu(64)) key_generator(
    .clk(clk),
    .reset(reset),
    .finish(finish),
    .q_param(q),
    .p_key(p),
    .kappa_key(kappa)
    );
    
endmodule
