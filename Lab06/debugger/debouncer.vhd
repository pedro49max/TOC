-- * header
-------------------------------------------------------------------------------
-- Title      : debouncer
-- Project    :
-------------------------------------------------------------------------------
-- File       : debouncer.vhd
-- Author     :
-- Company    :
-- Created    : 2023-12-02
-- Last update: 2023-12-02
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

-------------------------------------------------------------------------------
-- * entity declaration                                                      --
-------------------------------------------------------------------------------

entity debouncer is

  generic (
    G_CLKFREQ_MHZ : real := 100.0;
    G_PULSE_MS    : real := 300.0);

  port (
    rst   : in  std_logic;
    clk   : in  std_logic;
    boton : in  std_logic;
    pulso : out std_logic);
end debouncer;

-------------------------------------------------------------------------------
-- * architecture body                                                       --
-------------------------------------------------------------------------------

architecture rtl of debouncer is


-- ** constant declaration

  constant C_CLKFREQ_HZ : real                          := G_CLKFREQ_MHZ * 1000000.0;
  constant C_PULSE_SEC  : real                          := G_PULSE_MS / 1000.0;
  constant C_CNT_MAX    : natural                       := natural(ceil(C_CLKFREQ_HZ * C_PULSE_SEC));
  constant C_CNT_L2     : natural                       := natural(ceil(log2(C_CLKFREQ_HZ * C_PULSE_SEC)));
  constant C_CNT_BIN    : unsigned(C_CNT_L2-1 downto 0) := to_unsigned(C_CNT_MAX, C_CNT_L2);
  constant C_DLY        : natural                       := 2;

-- ** signal declaration

  signal b0_mek_ra : unsigned(0 to C_DLY-1)        := (others => '0');
  --
  signal b1_cnt_r  : unsigned(C_CNT_L2-1 downto 0) := (others => '0');
  signal b1_ena_r  : std_logic                     := '0';
  --
  signal b2_ena_ra : unsigned(0 to 1)              := (others => '0');

begin

-------------------------------------------------------------------------------
-- * B0 : metastability killer                                               --
-------------------------------------------------------------------------------

  MEK : process (clk) is
  begin
    if rising_edge(clk) then
      if (boton = '1') then
        b0_mek_ra <= (others => '1');
      else
        b0_mek_ra <= '0' & b0_mek_ra(0 to C_DLY-2);
      end if;
    end if;
  end process MEK;

-------------------------------------------------------------------------------
-- * B1 : glitch killer                                                      --
-------------------------------------------------------------------------------

  GK : process (clk) is
  begin
    if rising_edge(clk) then
      if (b0_mek_ra(C_DLY-1) = '0') then
        b1_cnt_r <= (others => '0');
        b1_ena_r <= '0';
      else
        if (b1_cnt_r = C_CNT_BIN) then
          b1_cnt_r <= b1_cnt_r;
          b1_ena_r <= '1';
        else
          b1_cnt_r <= b1_cnt_r + 1;
          b1_ena_r <= '0';
        end if;
      end if;
    end if;
  end process GK;

-------------------------------------------------------------------------------
-- * B2 : trigger generator                                                  --
-------------------------------------------------------------------------------

  TRIG : process (clk,rst) is
  begin

    if (rst = '1') then
      b2_ena_ra <= (others => '0');
    elsif rising_edge(clk) then
      b2_ena_ra <= b1_ena_r & b2_ena_ra(0);
    end if;
  end process TRIG;

  pulso <= b2_ena_ra(0) and not (b2_ena_ra(1));

end rtl;
