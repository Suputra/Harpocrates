// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
// Date        : Thu May  4 23:13:32 2023
// Host        : MSI running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/saaha/Documents/Code/Research/TCL_Test_Merge/myproject/Prime_Generation.gen/sources_1/bd/ADC/ip/ADC_key_gen_0_0/ADC_key_gen_0_0_stub.v
// Design      : ADC_key_gen_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "key_gen,Vivado 2022.2" *)
module ADC_key_gen_0_0(clk, reset, finish, p_key, q_param, kappa_key)
/* synthesis syn_black_box black_box_pad_pin="clk,reset,finish,p_key[31:0],q_param[31:0],kappa_key[15:0]" */;
  input clk;
  input reset;
  output finish;
  output [31:0]p_key;
  output [31:0]q_param;
  output [15:0]kappa_key;
endmodule
