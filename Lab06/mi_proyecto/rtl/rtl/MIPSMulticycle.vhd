library IEEE;
use IEEE.std_logic_1164.all;

entity MIPSMulticycle is
  port(
    clk            : in  std_logic;
    rst_n          : in  std_logic;
    -- debug
    boton          : in  std_logic;
    sw             : in  std_logic_vector(14 downto 0);
    display        : out std_logic_vector(6 downto 0);
    display_enable : out std_logic_vector(3 downto 0)
    );
end MIPSMulticycle;

architecture MIPSMulticycleArch of MIPSMulticycle is

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

  component debugger is
    port (
      rst_n          : in  std_logic;
      clk_100MHz     : in  std_logic;
      boton          : in  std_logic;
      clk_out        : out std_logic;
      display        : out std_logic_vector(6 downto 0);
      display_enable : out std_logic_vector(3 downto 0);
      switch         : in  std_logic_vector(14 downto 0);
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
  end component;

  signal control   : std_logic_vector(15 downto 0);
  signal Zero      : std_logic;
  signal op        : std_logic_vector(5 downto 0);
  signal dbg_uc    : std_logic_vector(31 downto 0);
  signal dbg_pc    : std_logic_vector(31 downto 0);
  signal dbg_addr  : std_logic_vector(31 downto 0);
  signal dbg_rw    : std_logic_vector(31 downto 0);
  signal dbg_busw  : std_logic_vector(31 downto 0);
  signal dbg_ir    : std_logic_vector(31 downto 0);
  signal dbg_a     : std_logic_vector(31 downto 0);
  signal dbg_b     : std_logic_vector(31 downto 0);
  signal dbg_opa   : std_logic_vector(31 downto 0);
  signal dbg_opb   : std_logic_vector(31 downto 0);
  signal dbg_alu   : std_logic_vector(31 downto 0);
  signal dbg_clk   : std_logic;

begin

  CU : controlUnit
    port map(
      clk     => dbg_clk,
      rst_n   => rst_n,
      control => control,
      dbg_uc  => dbg_uc,
      Zero    => Zero,
      op      => op);

  DP : dataPath
    port map(
      clk       => dbg_clk,
      rst_n     => rst_n,
      control   => control,
      Zero      => Zero,
      op        => op,
      dbg_pc    => dbg_pc,
      dbg_addr  => dbg_addr,
      dbg_rw    => dbg_rw,
      dbg_busw  => dbg_busw,
      dbg_ir    => dbg_ir,
      dbg_a     => dbg_a,
      dbg_b     => dbg_b,
      dbg_opa   => dbg_opa,
      dbg_opb   => dbg_opb,
      dbg_alu   => dbg_alu);

  DBG : debugger
    port map(
      clk_100MHz     => clk,
      rst_n          => rst_n,
      boton          => boton,
      clk_out        => dbg_clk,
      display        => display,
      display_enable => display_enable,
      switch         => sw,
      dbg_uc         => dbg_uc,
      dbg_pc         => dbg_pc,
      dbg_addr       => dbg_addr,
      dbg_rw         => dbg_rw,
      dbg_busw       => dbg_busw,
      dbg_ir         => dbg_ir,
      dbg_a          => dbg_a,
      dbg_b          => dbg_b,
      dbg_opa        => dbg_opa,
      dbg_opb        => dbg_opb,
      dbg_alu        => dbg_alu);


end MIPSMulticycleArch;
