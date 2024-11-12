


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity fushion is
    Port (
        rst             : in std_logic;
        clk             : in std_logic;
        boton1          : in std_logic;
        boton2          : in std_logic;
        I               : in std_logic_vector(7 downto 0);
        O               : out std_logic;
        x               : out STD_LOGIC_VECTOR (6 downto 0);
        an          : out STD_LOGIC_VECTOR (3 downto 0)
    );
end fushion;

architecture Behavioral of fushion is

component FSM is
    Port (
        rst             : in std_logic;
        clk             : in std_logic;
        boton1          : in std_logic;
        boton2          : in std_logic;
        I               : in std_logic_vector(7 downto 0);
        O               : out std_logic;
        x               : out STD_LOGIC_VECTOR (3 downto 0)
    );
end component;

component debouncer is
    port (
        rst             : in std_logic;
        clk             : in std_logic;
        x               : in std_logic;
        xDeb            : out std_logic;
        xDebFallingEdge : out std_logic;
        xDebRisingEdge  : out std_logic
    );
end component;
component debouncer2 is
    port (
        rst             : in std_logic;
        clk             : in std_logic;
        x               : in std_logic;
        xDeb            : out std_logic;
        xDebFallingEdge : out std_logic;
        xDebRisingEdge  : out std_logic
    );
end component;

component conv_7seg is
    Port ( x       : in   STD_LOGIC_VECTOR (3 downto 0);
           display : out  STD_LOGIC_VECTOR (6 downto 0) );
end component;

signal rising1, rising2, J, K: std_logic;
signal R: STD_LOGIC_VECTOR (3 downto 0);
begin
    MOD_debouncer: debouncer port map('1', clk, boton1,  J, K, rising1);
    MOD_debouncer2: debouncer2 port map('1', clk, boton2,  J, K, rising2);
    MOD_FSM: FSM port map(rst, clk, rising1,rising2,  I, O, R);
    MOD_conv_7seg: conv_7seg port map(R, x);
    an <= "1110";
end Behavioral;
