-- * header
-------------------------------------------------------------------------------
-- Title      : debugger
-- Project    :
-------------------------------------------------------------------------------
-- File       : debugger.vhd
-- Author     :
-- Company    :
-- Created    : 2023-12-02
-- Last update: 2023-12-10
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
    clk_out        : out std_logic;
    display        : out std_logic_vector(6 downto 0);
    display_enable : out std_logic_vector(3 downto 0);
    switch         : in  std_logic_vector(14 downto 0);
    -- debug display
    dbg_uc         : in  std_logic_vector(31 downto 0);
    dbg_pc         : in  std_logic_vector(31 downto 0);
    dbg_addr       : in  std_logic_vector(31 downto 0);
    dbg_rw         : in  std_logic_vector(31 downto 0);
    dbg_busw       : in  std_logic_vector(31 downto 0);
    dbg_ir         : in  std_logic_vector(31 downto 0);
    dbg_a          : in  std_logic_vector(31 downto 0);
    dbg_b          : in  std_logic_vector(31 downto 0);
    dbg_opa        : in  std_logic_vector(31 downto 0);
    dbg_opb        : in  std_logic_vector(31 downto 0);
    dbg_alu        : in  std_logic_vector(31 downto 0)
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
  signal digito_0 : std_logic_vector(3 downto 0);
  signal digito_1 : std_logic_vector(3 downto 0) := (others => '0');
  signal digito_2 : std_logic_vector(3 downto 0) := (others => '0');
  signal digito_3 : std_logic_vector(3 downto 0) := (others => '0');

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
-- * B0 : global buffer with clock enable                                    --
-------------------------------------------------------------------------------

  BUFGCE_inst : BUFGCE
    port map (
      O  => int_clk,
      CE => pulso,
      I  => clk_100MHz
      );

  clk_out <= int_clk;
-------------------------------------------------------------------------------
-- * B2 : switch                                                             --
-------------------------------------------------------------------------------

  SW : entity work.switch_dbg
    port map (
      switch   => switch,
      dbg_uc   => dbg_uc,
      dbg_pc   => dbg_pc,
      dbg_addr => dbg_addr,
      dbg_rw   => dbg_rw,
      dbg_busw => dbg_busw,
      dbg_ir   => dbg_ir,
      dbg_a    => dbg_a,
      dbg_b    => dbg_b,
      dbg_opa  => dbg_opa,
      dbg_opb  => dbg_opb,
      dbg_alu  => dbg_alu,
      digito_0 => digito_0,
      digito_1 => digito_1,
      digito_2 => digito_2,
      digito_3 => digito_3);

-------------------------------------------------------------------------------
-- * B3 : display 7 segment                                                  --
-------------------------------------------------------------------------------

  DISP : entity work.displays
    port map (
      rst            => rst,
      clk            => clk_100MHz,
      digito_0       => digito_0,
      digito_1       => digito_1,
      digito_2       => digito_2,
      digito_3       => digito_3,
      display        => display,
      display_enable => display_enable);

end rtl;
