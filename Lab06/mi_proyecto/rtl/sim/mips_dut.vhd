library IEEE;
use IEEE.std_logic_1164.all;

entity MIPS_DUT is
  port(
    clk            : in  std_logic;
    rst_n          : in  std_logic
    );
end MIPS_DUT;

architecture MIPSMulticycleArch of MIPS_DUT is

  component controlUnit is
    port(
      clk     : in  std_logic;
      rst_n   : in  std_logic;
      control : out std_logic_vector(15 downto 0);
      dbg_uc  : out std_logic_vector(31 downto 0);
      Zero    : in  std_logic;
      op      : in  std_logic_vector(5 downto 0)
      );
  end component;

  component dataPath is
    port(
      clk       : in  std_logic;
      rst_n     : in  std_logic;
      control   : in  std_logic_vector(15 downto 0);
      Zero      : out std_logic;
      op        : out std_logic_vector(5 downto 0);
      dbg_pc    : out std_logic_vector(31 downto 0);
      dbg_addr  : out std_logic_vector(31 downto 0);
      dbg_rw    : out std_logic_vector(31 downto 0);
      dbg_busw  : out std_logic_vector(31 downto 0);
      dbg_ir    : out std_logic_vector(31 downto 0);
      dbg_a     : out std_logic_vector(31 downto 0);
      dbg_b     : out std_logic_vector(31 downto 0);
      dbg_opa   : out std_logic_vector(31 downto 0);
      dbg_opb   : out std_logic_vector(31 downto 0);
      dbg_alu   : out std_logic_vector(31 downto 0)
      );
  end component;

  signal control : std_logic_vector(15 downto 0);
  signal Zero    : std_logic;
  signal op      : std_logic_vector(5 downto 0);

begin

  CU : controlUnit
    port map(
      clk => clk,
      rst_n => rst_n,
      control => control,
      dbg_uc => open,
      Zero => Zero,
      op => op);

  DP : dataPath
    port map(
      clk => clk,
      rst_n => rst_n,
      control => control,
      Zero => Zero,
      op => op,
      dbg_pc    => open,
      dbg_addr  => open,
      dbg_rw    => open,
      dbg_busw  => open,
      dbg_ir    => open,
      dbg_a     => open,
      dbg_b     => open,
      dbg_opa   => open,
      dbg_opb   => open,
      dbg_alu   => open);

end MIPSMulticycleArch;
