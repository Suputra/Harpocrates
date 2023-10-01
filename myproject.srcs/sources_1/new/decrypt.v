`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/26/2023 01:50:21 PM
// Design Name: 
// Module Name: decrypt
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


module decrypt #(nu=16, lambda=32, m_size = 10, eta = 32) (
    input [nu-1:0] kappa_key,
    input [lambda-1:0] p_key,
    input [((nu + nu >=  eta + lambda) ? nu + nu : eta + lambda) -1 : 0] c,
    output [m_size-1:0] m
    );
    
    assign m = (c % p_key) % kappa_key;
endmodule
