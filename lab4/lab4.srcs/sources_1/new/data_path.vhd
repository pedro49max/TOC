library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;
use IEEE.numeric_std.all;

entity data_path is
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
end data_path;

architecture ARCH of data_path is
signal control_aux : std_logic_vector(8 downto 0);
alias load_dividend : std_logic is control_aux(0);
alias load_divisor : std_logic is control_aux(1);
alias shift_right_divisor : std_logic is control_aux(2);
alias load_quotient : std_logic is control_aux(3);
alias shift_left_quotient : std_logic is control_aux(4);
alias load_k : std_logic is control_aux(5);
alias count_k : std_logic is control_aux(6);
alias mux_dividend : std_logic is control_aux(7);
alias operation : std_logic is control_aux(8);
-- declaration of components and remaining intermediate signals...
component regDiv
generic(t : natural := 8);
port (
rst : IN std_logic;
clk : IN std_logic;
load : IN std_logic;
E : IN std_logic_vector(t-1 downto 0);
S : OUT std_logic_vector(t-1 downto 0)
);
end component;
component counter_register
generic(t : natural := 8);
Port (
rst : IN std_logic;
clk : IN std_logic;
load : IN std_logic;
cont: IN std_logic;
E : IN std_logic_vector(t -1 downto 0);
S : OUT std_logic_vector(t -1 downto 0)
);
end component;
component right_shift_reg
generic(t : natural := 8);
Port (
rst : IN std_logic;
clk : IN std_logic;
load : IN std_logic;
desp : IN std_logic;
E : IN std_logic_vector(t -1 downto 0);
S : OUT std_logic_vector(t -1 downto 0)
);
end component;
component left_shift_reg
generic(t : natural := 8);
Port (
rst : IN std_logic;
clk : IN std_logic;
load : IN std_logic;
desp : IN std_logic;
MSB : IN std_logic;
E : IN std_logic_vector(t -1 downto 0);
S : OUT std_logic_vector(t -1 downto 0)
);
end component;
component adder is
generic(z : natural := 8);
Port (
A : IN std_logic_vector(z-1 downto 0);
B : IN std_logic_vector(z-1 downto 0);
op: IN std_logic;
C : OUT std_logic_vector(z-1 downto 0)
);
end component;
component counter is
generic(t : natural := 8);
Port( E1,E2: IN STD_LOGIC_VECTOR (t-1 downto 0);
S: OUT STD_LOGIC );
end component;
signal salida_divid, entrada_divid: std_logic_vector(n downto 0);
signal salida_divis, entrada_divis : std_logic_vector(n downto 0);
signal salida_sum, salida_mux: std_logic_vector(n downto 0);
signal entrada_coci, salida_coci: std_logic_vector(n downto 0);
signal salida_cont, entrada_cont: std_logic_vector(n downto 0);
signal num: integer;
signal numstd: std_logic_vector(n downto 0);
signal msbnum: std_logic;
begin
-- code of the datapath...
control_aux <= control;
entrada_divid <= '0' & dividendo;
entrada_divis <= '0' & divisor & "0000";
entrada_cont <= (others => '0');
entrada_coci <= (others => '0');
num <= n-m;
numstd <= std_logic_vector(to_unsigned(num, n+1));

regDivisor: right_shift_reg
generic map (t => n+1)
port map (rst => reset,clk => clk,load => load_divisor,desp => shift_right_divisor,E =>
entrada_divis,S => salida_divis);
regK: counter_register
generic map (t => n+1)
port map (rst => reset,clk => clk,load => load_k,cont => count_k,E => entrada_cont,S =>
salida_cont);
comp: counter
generic map (t => n+1)
port map (E1 => salida_cont, E2 => numstd, S => less_or_equals);
sumrest: adder
generic map (z => n+1)
port map (A => salida_divid,B => salida_divis,op => operation,C => salida_sum);
salida_mux <= salida_sum when mux_dividend = '0' else entrada_divid;
regDividend: regDiv
generic map (t => n+1)
port map (rst => reset,clk => clk,load => load_dividend,E => salida_mux,S => salida_divid);
msbnum <= salida_divid(n);
MSB_dividend <= msbnum;
regq: left_shift_reg
generic map (t => n+1)
port map (rst => reset,clk => clk,load => load_quotient,MSB => msbnum,desp =>
shift_left_quotient,E => entrada_coci,S => salida_coci);

cociente <= salida_coci(n-1 downto 0);
end ARCH;