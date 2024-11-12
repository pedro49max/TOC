library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;



entity treeSim is
--  Port ( );
end treeSim;

architecture Behavioral of treeSim is
    
    component treeComparator  is
    generic(
        n_bits: natural := 4;
        n_inputs: natural := 4
    );
    Port ( X : in STD_LOGIC_VECTOR (15 downto 0);
        clk: IN STD_LOGIC;
        O : out STD_LOGIC_VECTOR (3 downto 0));
    end component ;
    
    signal X: STD_LOGIC_VECTOR (15 downto 0);
    Signal O : STD_LOGIC_VECTOR (3 downto 0);
    signal clk:  STD_LOGIC;
    constant clk_period : time := 50 ns;
begin
    uut: treeComparator PORT MAP (
        O => O,
        X => X,
        clk => clk
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
        X <= "1011000100010000";
        wait for 250 ns;
         X <= "0011000101110000";
        wait for 250 ns;
         X <= "1001000101110000";
        wait for 250 ns;
         X <= "0011000101111111";
        wait for 250 ns;
        wait;
   end process;
end Behavioral;