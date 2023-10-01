`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/30/2023 11:36:43 PM
// Design Name: 
// Module Name: encrypt_tb
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


module encrypt_tb(

    );
    reg clk = 1'b1;
    always begin
        clk <= !clk;
        #10;
    end
    
    
    reg[31:0] q_param = 32'd3171876517;
    reg[31:0] p_key = 32'd3142709951;
    reg[15:0] kappa_key = 16'd58031;
    
    
    wire [63: 0] c;
    wire[9:0] m;

    encrypt enc(
    .clk(clk),
    .m(6'd1),
    .q_param(q_param),
    .p_key(p_key),
    .kappa_key(kappa_key),
    .c(c)
    );
    
    decrypt dec(
        .kappa_key(kappa_key),
        .p_key(p_key),
        .c(c),
        .m(m)
    );

endmodule
