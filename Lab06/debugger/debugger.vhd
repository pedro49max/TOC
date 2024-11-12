-- * header
-------------------------------------------------------------------------------
-- Title      : debugger
-- Project    :
-------------------------------------------------------------------------------
-- File       : debugger.vhd
-- Author     :
-- Company    :
-- Created    : 2023-12-02
-- Last update: 2023-12-11
-- Platform   :
-- Standard   : VHDL'08
-------------------------------------------------------------------------------
-- Description:
-------------------------------------------------------------------------------
-- Copyright (c) 2023
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-12-02  1.0      jcorrecher  Created
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- * libraries used                                                          --
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

library unisim;
use unisim.vcomponents.all;

-------------------------------------------------------------------------------
-- * entity declaration                                                      --
-------------------------------------------------------------------------------

entity debugger is

  port (
    rst_n          : in  std_logic;
    clk_100MHz     : in  std_logic;
    boton          : in  std_logic;
    clk_out        : out std_logic
    );
end debugger;

-------------------------------------------------------------------------------
-- * architecture body                                                       --
-------------------------------------------------------------------------------

architecture rtl of debugger is

  -- ** constant declaration
  constant C_CLKFREQ_MHZ : real := 100.0;
  constant C_PULSE_MS    : real := 20.0;

  -- ** signal declaration
  signal rst      : std_logic;
  signal pulso    : std_logic;
  signal int_clk  : std_logic;

begin

  rst <= not (rst_n);

-------------------------------------------------------------------------------
-- * B0 : debouncer                                                          --
-------------------------------------------------------------------------------

  DBC : entity work.debouncer
    generic map (
      G_CLKFREQ_MHZ => C_CLKFREQ_MHZ,
      G_PULSE_MS    => C_PULSE_MS)
    port map (
      rst   => rst,
      clk   => clk_100MHz,
      boton => boton,
      pulso => pulso);

-------------------------------------------------------------------------------
-- * B1 : global buffer with clock enable                                    --
-------------------------------------------------------------------------------

  BUFGCE_inst : BUFGCE
    port map (
      O  => int_clk,
      CE => pulso,
      I  => clk_100MHz
      );

  -- clock output assignment
  clk_out <= int_clk;

end rtl;
