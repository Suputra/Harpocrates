-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
-- Date        : Wed Apr 19 14:07:35 2023
-- Host        : MSI running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               c:/Users/saaha/Documents/Code/Research/TCL_Test_Merge/myproject/Prime_Generation.gen/sources_1/bd/ADC/ip/ADC_key_switch_controller_0_0/ADC_key_switch_controller_0_0_sim_netlist.vhdl
-- Design      : ADC_key_switch_controller_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z020clg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity ADC_key_switch_controller_0_0_key_switch_controller is
  port (
    switch : out STD_LOGIC;
    clk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of ADC_key_switch_controller_0_0_key_switch_controller : entity is "key_switch_controller";
end ADC_key_switch_controller_0_0_key_switch_controller;

architecture STRUCTURE of ADC_key_switch_controller_0_0_key_switch_controller is
begin
switch_reg_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => '1',
      D => '0',
      Q => switch,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity ADC_key_switch_controller_0_0 is
  port (
    clk : in STD_LOGIC;
    finish : in STD_LOGIC;
    switch : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of ADC_key_switch_controller_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of ADC_key_switch_controller_0_0 : entity is "ADC_key_switch_controller_0_0,key_switch_controller,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of ADC_key_switch_controller_0_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of ADC_key_switch_controller_0_0 : entity is "module_ref";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of ADC_key_switch_controller_0_0 : entity is "key_switch_controller,Vivado 2022.2";
end ADC_key_switch_controller_0_0;

architecture STRUCTURE of ADC_key_switch_controller_0_0 is
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of clk : signal is "xilinx.com:signal:clock:1.0 clk CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of clk : signal is "XIL_INTERFACENAME clk, FREQ_HZ 50000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN ADC_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0";
begin
inst: entity work.ADC_key_switch_controller_0_0_key_switch_controller
     port map (
      clk => clk,
      switch => switch
    );
end STRUCTURE;
