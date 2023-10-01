`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/08/2023 04:20:57 PM
// Design Name: 
// Module Name: rand127
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


//////////////////////////////////////////////////////////
// 16-bit parallel random number generator ///////////////
// by Bruce R Land, Cornell University     ///////////////
//////////////////////////////////////////////////////////
// Algorithm is based on:
// A special-purpose processor for the Monte Carlo simulation of ising spin systems
// A. Hoogland, J. Spaa, B. Selman and A. Compagner
// Journal of Computational Physics
// Volume 51, Issue 2, August 1983, Pages 250-260
//////////////////////////////////////////////////////////


module rand127(rand_out, seed_in, state_in, clock_in, reset_in);
	// 16-bit random number on every cycle
	output wire [15:0] rand_out ;
	// the clocks and stuff
	input wire [3:0] state_in ;
	input wire clock_in, reset_in ;
	input wire [127:1] seed_in; // 128 bits is 32 hex digits 0xffff_ffff_ffff_ffff_ffff_ffff_ffff_ffff

	reg [8:1] sr1, sr2, sr3, sr4, sr5, sr6, sr7, sr8, 
				sr9, sr10, sr11, sr12, sr13, sr14, sr15, sr16;
	
	// state names
	parameter react_start=4'd0 ;

	// generate random numbers	
	assign rand_out = {sr1[7], sr2[7], sr3[7], sr4[7],
							sr5[7], sr6[7], sr7[7], sr8[7],
							sr9[7], sr10[7], sr11[7], sr12[7],
							sr13[7], sr14[7], sr15[7], sr16[7]} ;
							
	always @ (posedge clock_in) //
	begin
		
		if (reset_in)
		begin	
			//init random number generator 
			sr1 <= seed_in[8:1] ;
			sr2 <= seed_in[16:9] ;
			sr3 <= seed_in[24:17] ;
			sr4 <= seed_in[32:25] ;
			sr5 <= seed_in[40:33] ;
			sr6 <= seed_in[48:41] ;
			sr7 <= seed_in[56:49] ;
			sr8 <= seed_in[64:57] ;
			sr9 <= seed_in[72:65] ;
			sr10 <= seed_in[80:73] ;
			sr11 <= seed_in[88:81] ;
			sr12 <= seed_in[96:89] ;
			sr13 <= seed_in[104:97] ;
			sr14 <= seed_in[112:105] ;
			sr15 <= seed_in[120:113] ;
			sr16 <= {1'b0,seed_in[127:121]} ;
		end
		
		// update 127-bit shift register
		// 16 times in parallel
		else 
		begin
			if(state_in == react_start) 
			begin
				sr1 <= {sr1[7:1], sr1[7]^sr16[7]} ;
				sr2 <= {sr2[7:1], sr2[7]^sr1[8]}  ;
				sr3 <= {sr3[7:1], sr3[7]^sr2[8]}  ;
				sr4 <= {sr4[7:1], sr4[7]^sr3[8]}  ;
				sr5 <= {sr5[7:1], sr5[7]^sr4[8]}  ;
				sr6 <= {sr6[7:1], sr6[7]^sr5[8]}  ;
				sr7 <= {sr7[7:1], sr7[7]^sr6[8]}  ;
				sr8 <= {sr8[7:1], sr8[7]^sr7[8]}  ;
				sr9 <= {sr9[7:1], sr9[7]^sr8[8]}  ;
				sr10 <= {sr10[7:1], sr10[7]^sr9[8]}  ;
				sr11 <= {sr11[7:1], sr11[7]^sr10[8]}  ;
				sr12 <= {sr12[7:1], sr12[7]^sr11[8]}  ;
				sr13 <= {sr13[7:1], sr13[7]^sr12[8]}  ;
				sr14 <= {sr14[7:1], sr14[7]^sr13[8]}  ;
				sr15 <= {sr15[7:1], sr15[7]^sr14[8]}  ;
				sr16 <= {sr16[6:1], sr16[7]^sr15[8]}  ;
			end	
		end
	end
endmodule
