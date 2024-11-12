-- * header
-------------------------------------------------------------------------------
-- Title      : switch
-- Project    :
-------------------------------------------------------------------------------
-- File       : switch.vhd
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

-------------------------------------------------------------------------------
-- * entity declaration                                                      --
-------------------------------------------------------------------------------

entity switch_dbg is

  generic (
    G_CLKFREQ_MHZ : real := 100.0;
    G_PULSE_MS    : real := 300.0);

  port (
    switch   : in  std_logic_vector(14 downto 0);
    dbg_uc   : in  std_logic_vector(31 downto 0);
    dbg_pc   : in  std_logic_vector(31 downto 0);
    dbg_addr : in  std_logic_vector(31 downto 0);
    dbg_rw   : in  std_logic_vector(31 downto 0);
    dbg_busw : in  std_logic_vector(31 downto 0);
    dbg_ir   : in  std_logic_vector(31 downto 0);
    dbg_a    : in  std_logic_vector(31 downto 0);
    dbg_b    : in  std_logic_vector(31 downto 0);
    dbg_opa  : in  std_logic_vector(31 downto 0);
    dbg_opb  : in  std_logic_vector(31 downto 0);
    dbg_alu  : in  std_logic_vector(31 downto 0);
    digito_0 : out std_logic_vector(3 downto 0);
    digito_1 : out std_logic_vector(3 downto 0);
    digito_2 : out std_logic_vector(3 downto 0);
    digito_3 : out std_logic_vector(3 downto 0)
    );
end switch_dbg;

-------------------------------------------------------------------------------
-- * architecture body                                                       --
-------------------------------------------------------------------------------

architecture rtl of switch_dbg is

begin

  digito_0 <=  dbg_uc(3 downto 0)     when switch = "000000000000001" else
               dbg_pc(3 downto 0)     when switch = "000000000000010" else
               dbg_addr(3 downto 0)   when switch = "000000000000100" else
               dbg_rw(3 downto 0)     when switch = "000000000001000" else
               dbg_busw(3 downto 0)   when switch = "000000000010000" else
               dbg_ir(3 downto 0)     when switch = "000000000100000" else
               dbg_a(3 downto 0)      when switch = "000000001000000" else
               dbg_b(3 downto 0)      when switch = "000000010000000" else
               dbg_opa(3 downto 0)    when switch = "000000100000000" else
               dbg_opb(3 downto 0)    when switch = "000001000000000" else
               dbg_alu(3 downto 0)    when switch = "000010000000000" else
               dbg_uc(19 downto 16)   when switch = "100000000000001" else
               dbg_pc(19 downto 16)   when switch = "100000000000010" else
               dbg_addr(19 downto 16) when switch = "100000000000100" else
               dbg_rw(19 downto 16)   when switch = "100000000001000" else
               dbg_busw(19 downto 16) when switch = "100000000010000" else
               dbg_ir(19 downto 16)   when switch = "100000000100000" else
               dbg_a(19 downto 16)    when switch = "100000001000000" else
               dbg_b(19 downto 16)    when switch = "100000010000000" else
               dbg_opa(19 downto 16)  when switch = "100000100000000" else
               dbg_opb(19 downto 16)  when switch = "100001000000000" else
               dbg_alu(19 downto 16)  when switch = "100010000000000" else
               (others => '0');

  digito_1 <=  dbg_uc(7 downto 4)     when switch = "000000000000001" else
               dbg_pc(7 downto 4)     when switch = "000000000000010" else
               dbg_addr(7 downto 4)   when switch = "000000000000100" else
               dbg_rw(7 downto 4)     when switch = "000000000001000" else
               dbg_busw(7 downto 4)   when switch = "000000000010000" else
               dbg_ir(7 downto 4)     when switch = "000000000100000" else
               dbg_a(7 downto 4)      when switch = "000000001000000" else
               dbg_b(7 downto 4)      when switch = "000000010000000" else
               dbg_opa(7 downto 4)    when switch = "000000100000000" else
               dbg_opb(7 downto 4)    when switch = "000001000000000" else
               dbg_alu(7 downto 4)    when switch = "000010000000000" else
               dbg_uc(23 downto 20)   when switch = "100000000000001" else
               dbg_pc(23 downto 20)   when switch = "100000000000010" else
               dbg_addr(23 downto 20) when switch = "100000000000100" else
               dbg_rw(23 downto 20)   when switch = "100000000001000" else
               dbg_busw(23 downto 20) when switch = "100000000010000" else
               dbg_ir(23 downto 20)   when switch = "100000000100000" else
               dbg_a(23 downto 20)    when switch = "100000001000000" else
               dbg_b(23 downto 20)    when switch = "100000010000000" else
               dbg_opa(23 downto 20)  when switch = "100000100000000" else
               dbg_opb(23 downto 20)  when switch = "100001000000000" else
               dbg_alu(23 downto 20)  when switch = "100010000000000" else
               (others => '0');

  digito_2 <=  dbg_uc(11 downto 8)    when switch = "000000000000001" else
               dbg_pc(11 downto 8)    when switch = "000000000000010" else
               dbg_addr(11 downto 8)  when switch = "000000000000100" else
               dbg_rw(11 downto 8)    when switch = "000000000001000" else
               dbg_busw(11 downto 8)  when switch = "000000000010000" else
               dbg_ir(11 downto 8)    when switch = "000000000100000" else
               dbg_a(11 downto 8)     when switch = "000000001000000" else
               dbg_b(11 downto 8)     when switch = "000000010000000" else
               dbg_opa(11 downto 8)   when switch = "000000100000000" else
               dbg_opb(11 downto 8)   when switch = "000001000000000" else
               dbg_alu(11 downto 8)   when switch = "000010000000000" else
               dbg_uc(27 downto 24)   when switch = "100000000000001" else
               dbg_pc(27 downto 24)   when switch = "100000000000010" else
               dbg_addr(27 downto 24) when switch = "100000000000100" else
               dbg_rw(27 downto 24)   when switch = "100000000001000" else
               dbg_busw(27 downto 24) when switch = "100000000010000" else
               dbg_ir(27 downto 24)   when switch = "100000000100000" else
               dbg_a(27 downto 24)    when switch = "100000001000000" else
               dbg_b(27 downto 24)    when switch = "100000010000000" else
               dbg_opa(27 downto 24)  when switch = "100000100000000" else
               dbg_opb(27 downto 24)  when switch = "100001000000000" else
               dbg_alu(27 downto 24)  when switch = "100010000000000" else
               (others => '0');

  digito_3 <=  dbg_uc(15 downto 12)   when switch = "000000000000001" else
               dbg_pc(15 downto 12)   when switch = "000000000000010" else
               dbg_addr(15 downto 12) when switch = "000000000000100" else
               dbg_rw(15 downto 12)   when switch = "000000000001000" else
               dbg_busw(15 downto 12) when switch = "000000000010000" else
               dbg_ir(15 downto 12)   when switch = "000000000100000" else
               dbg_a(15 downto 12)    when switch = "000000001000000" else
               dbg_b(15 downto 12)    when switch = "000000010000000" else
               dbg_opa(15 downto 12)  when switch = "000000100000000" else
               dbg_opb(15 downto 12)  when switch = "000001000000000" else
               dbg_alu(15 downto 12)  when switch = "000010000000000" else
               dbg_uc(31 downto 28)   when switch = "100000000000001" else
               dbg_pc(31 downto 28)   when switch = "100000000000010" else
               dbg_addr(31 downto 28) when switch = "100000000000100" else
               dbg_rw(31 downto 28)   when switch = "100000000001000" else
               dbg_busw(31 downto 28) when switch = "100000000010000" else
               dbg_ir(31 downto 28)   when switch = "100000000100000" else
               dbg_a(31 downto 28)    when switch = "100000001000000" else
               dbg_b(31 downto 28)    when switch = "100000010000000" else
               dbg_opa(31 downto 28)  when switch = "100000100000000" else
               dbg_opb(31 downto 28)  when switch = "100001000000000" else
               dbg_alu(31 downto 28)  when switch = "100010000000000" else
               (others => '0');

end rtl;
