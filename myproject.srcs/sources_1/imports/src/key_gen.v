`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/13/2023 02:54:25 PM
// Design Name: 
// Module Name: key_gen
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


module key_gen #(lambda = 32, eta = 32, nu = 16) (
    input clk, reset,
    output finish,
    output reg [lambda-1 : 0] p_key,
    output reg [eta-1 : 0] q_param,
    output reg [nu-1 : 0] kappa_key
);
    reg [7:0] acc = 10;
    reg all_prime_reset;
    reg out_reg_full = 1'b0;

    wire p_done, q_done, kappa_done;
    wire [lambda-1 : 0] p_wire;
    wire [eta-1 : 0] q_wire;
    wire [nu-1 : 0] kappa_wire;
    
    wire [2:0] done = {p_done, q_done, kappa_done};
    
    assign finish = (done == 3'b111) ? 1'b1 : 1'b0;
    always @(posedge clk) begin
        if (reset) begin
            all_prime_reset <= 1'b1;
        end else if (all_prime_reset) begin
            all_prime_reset <= 1'b0;
            out_reg_full <= 1'b0;
        end else if (finish) begin
            p_key <= p_wire;
            q_param <= q_wire;
            kappa_key <= kappa_wire;

        end
    end
    
    prime_gen #(.WORDSIZE(lambda)) p_gen(
    .accuracy(acc),
    .clk(clk),
    .reset(all_prime_reset),
    .done(p_done),
    .prime_out(p_wire)
    );
    
    prime_gen #(.WORDSIZE(eta)) q_gen(
    .accuracy(acc),
    .clk(clk),
    .reset(all_prime_reset),
    .done(q_done),
    .prime_out(q_wire)
    );
    
    prime_gen #(.WORDSIZE(nu)) kappa_gen(
    .accuracy(acc),
    .clk(clk),
    .reset(all_prime_reset),
    .done(kappa_done),
    .prime_out(kappa_wire)
    );
endmodule
