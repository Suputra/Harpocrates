`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/30/2023 10:20:37 AM
// Design Name: 
// Module Name: prime_gen
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
module prime_gen #(parameter WORDSIZE = 32)(
    input [7:0] accuracy,
    input clk, reset,
    output done,
    output [WORDSIZE-1 : 0] prime_out
    );

    assign prime_out = prime_reg;
    assign done = prime;

    reg [WORDSIZE-1:0] potential_prime = 3;
    reg [WORDSIZE-1:0] prime_reg;
    reg prime_reset = 1'b1;
    reg rand_reset = 1'b1;
    wire finish, prime;
    reg [15:0] rand_count_top = 0;

    wire [126:0] seed_in = {{7{16'haaaa}},15'haaa3};
    

    wire [15:0] rand_out;
    always @ (posedge clk) begin
        if (reset) begin
            prime_reset <= 1'b1;
        end else if (prime_reset) begin
            prime_reset <= 1'b0;
            rand_reset <= 1'b0;
            rand_count_top <= 16'b0;
        end else if (finish) begin
            if (rand_count_top < WORDSIZE/16) begin
                potential_prime[(rand_count_top+1)*16-1 -: 16] <= rand_out;
                rand_count_top <= rand_count_top + 1;
            end else begin
                potential_prime[0] <= 1'b1;
            end
            if (!prime) begin
                prime_reset <= 1'b1;
            end
        end
        if (prime && rand_count_top == 16'b0) begin
            prime_reg <= potential_prime;
        end  
    end

    rand127 rand(
    .rand_out(rand_out),
    .seed_in (seed_in),
    .state_in(4'd0),
    .clock_in(clk),
    .reset_in(rand_reset)
    );

    miller_rabin  #(.WORDSIZE(WORDSIZE)) prime_gen (
    .start_number(potential_prime),
    .accuracy(accuracy),
    .clk(clk),
    .reset(prime_reset),
    .prime(prime),
    .finish(finish)
    );
endmodule