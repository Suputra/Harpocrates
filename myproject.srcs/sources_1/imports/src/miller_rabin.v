
`timescale 1ns / 1ps

//Generates primes 
module  miller_rabin #(parameter WORDSIZE = 32) (
    input [WORDSIZE-1:0] start_number,
    input [7:0] accuracy,
    input clk,
    input reset,
    output reg prime,
    output finish
);

    reg [WORDSIZE*2-1:0] base, base2; // base2 and exponent2 are internal base and exponent
    reg [WORDSIZE-1:0] modulo;
    reg [WORDSIZE-1:0] exponent, exponent2;
    reg [WORDSIZE*2-1:0] intermediate = 64'd1;
    reg [WORDSIZE-1:0] mod_exp_result;
    reg mod_exp_finish, mod_exp_reset;

    // modular exponentiation process
    always @(posedge clk) begin
        if (mod_exp_reset) begin
            mod_exp_finish <= 1'b0;
            intermediate  <= 1;
            base2 <= base;
            exponent2 <= exponent;
        end
        if (~mod_exp_finish) begin
            if (exponent2 == 0) begin
                mod_exp_result <= (intermediate)%modulo;
                mod_exp_finish <= 1'b1;
            end else if (exponent2 == 1) begin
                mod_exp_result <= (base2 * intermediate)%modulo;
                mod_exp_finish <= 1'b1;
            end else begin
                if (exponent2[0] == 1'b1) begin
                    intermediate <= (base2 * intermediate)%modulo; //accumulate extra base2 into intermediate register
                end
                base2 <= (base2*base2)%modulo; //square base2 and take the mod
                exponent2 <= exponent2 >> 1; //divide exponent2 by 2
            end
        end
    end
    reg [WORDSIZE-1:0] n;
    reg [WORDSIZE-1:0] accuracy_reg;
    reg [WORDSIZE-1:0] r;
    reg [WORDSIZE-1:0] d;
    reg [WORDSIZE-1:0] s;
    reg [3:0] state;
    reg [WORDSIZE-1:0] k;

    reg [WORDSIZE-1:0] count_to_s;

    //state definitions
    localparam FACTORING 	= 4'd1;
    localparam GET_RANDOM 	= 4'd2;
    localparam MOD_EXP_WAIT = 4'd3;
    localparam CHECK			= 4'd4;
    localparam R_LOOP 		= 4'd5;
    localparam HOLD 			= 4'd6;

    assign finish = (state == HOLD) ? 1'b1 : 1'b0;

    reg [31:0] rand_count;
    reg [WORDSIZE-1:0] myrandnum;
    wire [WORDSIZE-1:0] nminus2 = n - 2'd2;

    wire [126:0] seed_in = {{7{16'haaaa}},15'h5aaa};
    wire [15:0] rand_out;
    reg rand_reset;

    // this generates a random number
    rand127 myrand(
        .rand_out(rand_out),
        .seed_in (seed_in),
        .state_in(4'd0),
        .clock_in(clk),
        .reset_in(rand_reset)
    );

    always @ (posedge clk) begin
        if (reset) begin
            n <= start_number;
            d <= start_number - 1;
            s <= 0;
            k <= 0;
            base <= 0;
            modulo <= 0;
            exponent <= 0;
            count_to_s <= 0;
            accuracy_reg <= accuracy;
            state <= FACTORING;
            mod_exp_reset <= 1;
            rand_reset <= 1;
            prime <= 0;
            rand_count <= 0;
        end
        else case (state)
            FACTORING : begin
                rand_reset <= 1'b0;
                if (d[0]) begin //d % 2 == 1
                    state <= GET_RANDOM;
                end
                else begin //d % 2 == 0
                    d <= d >> 1; //d = d / 2
                    s <= s + 32'd1;
                end
            end
            GET_RANDOM: begin
                if (rand_count < WORDSIZE/16) begin
                    myrandnum[(rand_count+1)*16-1 -: 16] <= rand_out;
                    rand_count <= rand_count + 1;
                end else if (myrandnum > nminus2) begin
                    myrandnum <= myrandnum >> 1;
                end
                else begin
                        base <= myrandnum;
                        modulo <= n;
                        exponent <= d;
                        state <= MOD_EXP_WAIT;
                    end
                end
            MOD_EXP_WAIT: begin
                mod_exp_reset <= 1'b0;
                if (~mod_exp_reset & mod_exp_finish) begin
                    mod_exp_reset <= 1'b1;
                    // if x=1 or x=n-1 then do next loop
                    if (mod_exp_result == {{(WORDSIZE-1){1'b0}},1'b1} ||
                    mod_exp_result == n - 1'b1) begin
                        state <= CHECK;
                    end
                    else if (s == 0) begin
                        // skip r_loop (ie. return composite)
                        state <= HOLD;
                        prime <= 1'b0;
                    end
                    else begin
                        // do r_loop
                        state <= R_LOOP;
                        count_to_s <= 32'd1;
                        // do x <== x^2 mod n
                        base <= mod_exp_result; // base is x
                        modulo <= n;
                        exponent <= 32'd2;
                    end
                end
            end
            R_LOOP : begin
                mod_exp_reset <= 1'b0;
                if (~mod_exp_reset & mod_exp_finish) begin
                    mod_exp_reset <= 1'b1;

                    // if x=1 then return composite
                    if (mod_exp_result == {{(WORDSIZE-1){1'b0}},1'b1}) begin
                        state <= HOLD;
                        prime <= 1'b0;
                    end

                    // if x=n-1 then do next loop
                    else if (mod_exp_result == n - 1'b1) begin
                        state <= CHECK;
                    end

                    // if r_loop ends, return composite
                    else if (count_to_s == s) begin
                        state <= HOLD;
                        prime <= 1'b0;
                    end

                    // otherwise, do next r_loop
                    else begin
                        count_to_s <= count_to_s + 1'b1;
                        base <= mod_exp_result;
                        modulo <= n;
                        exponent <= 32'd2;
                    end
                end
            end

            // check loop condition
            CHECK : begin
                // last loop, signal prime
                if (k + 1'b1 >= accuracy_reg) begin
                    state <= HOLD;
                    prime <= 1'b1;
                end
                // next loop
                else begin
                    state <= GET_RANDOM; // next loop
                    k <= k + 1'b1; // increment accuracy count
                end
            end

            HOLD : begin
                // endless loop
            end
        endcase
    end

endmodule
