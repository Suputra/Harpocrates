`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2023 10:31:32 AM
// Design Name: 
// Module Name: key_switch_controller
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


module key_switch_controller(
    input clk, finish,
    output switch
    );
    
    //very dumb switching logic for now
    reg switch_reg = 1'b1;
    assign switch = switch_reg;
    always @ (posedge clk) begin
        if (switch_reg) begin
            switch_reg <= 1'b0;
        end
    end
endmodule
