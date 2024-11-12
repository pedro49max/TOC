library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity division is
generic (
n : natural := 8;
m: natural := 4);
port (
clk : IN  std_logic;
	   reset : IN  std_logic;
	   dividend : IN  std_logic_vector(N - 1 downto 0);
       divisor : IN  std_logic_vector(M-1 downto 0);
	   start : IN  std_logic;
	   ready : OUT  std_logic;
	   quotient : OUT  std_logic_vector(N-1 downto 0)
);
end division;
architecture ARCH of division is
component controller is
Port (
clk, reset, inicio : in std_logic;
less_or_equals : in std_logic;
MSB_dividend : in std_logic;
control : out std_logic_vector(8 downto 0);
fin : out std_logic
);
end component;
component data_path is
generic (
n: natural := 8;
m: natural := 4);
port (
clk, reset : in std_logic;
dividendo : in std_logic_vector(n - 1 downto 0);
divisor : in std_logic_vector(m - 1 downto 0);
control : in std_logic_vector(8 downto 0);
cociente : out std_logic_vector(n - 1 downto 0);
less_or_equals : out std_logic;
MSB_dividend : out std_logic
);
end component;

component clock_divider is
    port( clk_in:  in std_logic; 
          clk_out: out std_logic );
end component;

signal control : std_logic_vector(8 downto 0);
signal less_or_equals, MSB_dividend, clock_out : std_logic;

begin
my_clock_divider: clock_divider PORT MAP(clk, clock_out);
my_datapath: data_path GENERIC MAP (n, m)
PORT MAP ( clk, --input
reset, --input
dividend, --input
divisor, --input
control, --input
quotient, --output
less_or_equals, --output
MSB_dividend); --output

my_controller: controller PORT MAP( clk, --input
reset, --input
start, --input
less_or_equals, --input
MSB_dividend, --input
control, --output
ready); --output

end ARCH;