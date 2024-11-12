
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FinalSim is
--  Port ( );
end FinalSim;

architecture Behavioral of FinalSim is
component fushion is
    Port (
        rst             : in std_logic;
        clk             : in std_logic;
        boton           : in std_logic;
        I               : in std_logic_vector(7 downto 0);
        O               : out std_logic;
        x               : out STD_LOGIC_VECTOR (6 downto 0)
    );
end component;
signal rst, clk, boton, O: std_logic;
signal I: std_logic_vector(7 downto 0);
signal x: STD_LOGIC_VECTOR (6 downto 0);
constant clk_period : time := 50 ns;

begin
    uut: fushion PORT MAP (
        rst => rst,
        clk => clk,
        boton => boton,
        I => I,
        O => O,
        x => x
        );
    clock_process: process
        begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;
    
    stim_proc: process
    begin
        rst<='1';
        boton <= '0';
        I <= "00000100";
        wait for 50 ns;
        
        rst<='1';
        boton <= '1';
        I <= "00110010";
        wait for 50 ns;
        
        rst<='1';
        boton <= '0';
        I <= "00110010";
        wait for 50 ns;
        
        rst<='0';
        boton <= '1';
        I <= "00000100";
        wait for 50 ns;
        
        rst<='0';
        boton <= '0';
        I <= "00000100";
        wait for 50 ns;
        
        rst<='0';
        boton <= '1';
        I <= "10100010";
        wait for 50 ns;
        
        rst<='0';
        boton <= '0';
        I <= "10100010";
        wait for 50 ns;
        
        rst<='0';
        boton <= '1';
        I <= "00110010";
        wait for 50 ns;
        
        rst<='0';
        boton <= '0';
        I <= "00110010";
        wait for 50 ns;
        
        rst<='0';
        boton <= '1';
        I <= "11111111";
        wait for 50 ns;
        
        rst<='0';
        boton <= '0';
        I <= "11111111";
        wait for 50 ns;
        
        rst<='0';
        boton <= '1';
        I <= "00000000";
        wait for 50 ns;
        
        rst<='0';
        boton <= '0';
        I <= "00000000";
        wait for 50 ns;
        
        rst<='0';
        boton <= '1';
        I <= "10000000";
        wait for 50 ns;
        
        rst<='0';
        boton <= '0';
        I <= "10000000";
        wait for 50 ns;
        
        rst<='0';
        boton <= '1';
        I <= "11000000";
        wait for 50 ns;
        
        rst<='0';
        boton <= '0';
        I <= "11000000";
        wait for 50 ns;
    end process;

end;
