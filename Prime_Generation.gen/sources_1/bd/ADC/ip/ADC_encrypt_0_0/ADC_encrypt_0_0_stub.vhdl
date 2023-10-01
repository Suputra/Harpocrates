-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
-- Date        : Thu May  4 23:11:38 2023
-- Host        : MSI running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               c:/Users/saaha/Documents/Code/Research/TCL_Test_Merge/myproject/Prime_Generation.gen/sources_1/bd/ADC/ip/ADC_encrypt_0_0/ADC_encrypt_0_0_stub.vhdl
-- Design      : ADC_encrypt_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ADC_encrypt_0_0 is
  Port ( 
    clk : in STD_LOGIC;
    q_param : in STD_LOGIC_VECTOR ( 31 downto 0 );
    p_key : in STD_LOGIC_VECTOR ( 31 downto 0 );
    kappa_key : in STD_LOGIC_VECTOR ( 15 downto 0 );
    m : in STD_LOGIC_VECTOR ( 4 downto 0 );
    c : out STD_LOGIC_VECTOR ( 63 downto 0 )
  );

end ADC_encrypt_0_0;

architecture stub of ADC_encrypt_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,q_param[31:0],p_key[31:0],kappa_key[15:0],m[4:0],c[63:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "encrypt,Vivado 2022.2";
begin
end;
