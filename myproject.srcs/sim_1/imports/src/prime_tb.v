`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2023 10:40:28 AM
// Design Name: 
// Module Name: prime_tb
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
//testing move script
module prime_tb #(parameter WORDSIZE = 16)(

);

    reg [7:0] accuracy;
    reg [WORDSIZE-1:0] potential_prime;
    reg prime_reset, clk, rand_reset;
    wire finish, prime;
    reg [31:0] rand_count_top = 0;

    initial begin
    potential_prime = 3;
    accuracy = 5;

    clk = 1'b0;

    prime_reset = 1'b1;
    rand_reset = 1'b1;

    #10
    prime_reset = 1'b0;
    rand_reset = 1'b0;
    end
    
    always
    begin
    clk = ~clk;
    #5;
    end


    wire [126:0] seed_in = {{7{16'haaaa}},15'haaa3};

    wire [15:0] rand_out;
    always @ (posedge clk) begin
        if (prime_reset) begin
            prime_reset <= 1'b0;
            rand_count_top <= 1'b0;
        end
        if (finish) begin
            if (rand_count_top < WORDSIZE/16) begin
                potential_prime[(rand_count_top+1)*16-1 -: 16] <= rand_out;
                rand_count_top <= rand_count_top + 1;
            end else begin
                potential_prime[0] <= 1'b1;
                prime_reset <= 1'b1;
            end
        end  
    end
    
    always @ (posedge prime) begin
        if (prime) begin
            $display($time);
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
