library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;



entity SimNetwork is
--  Port ( );
end SimNetwork;

architecture Behavioral of SimNetwork is
    
    component iterativeNetwork  is
    generic(
        n_bits: natural := 4;
        n_inputs: natural := 4
    );
    Port ( X : in STD_LOGIC_VECTOR (15 downto 0);
        O : out STD_LOGIC_VECTOR (3 downto 0));
    end component ;
    
    signal X: STD_LOGIC_VECTOR (15 downto 0);
    Signal O : STD_LOGIC_VECTOR (3 downto 0);
begin
    uut: iterativeNetwork PORT MAP (
        O => O,
        X => X
        );
    stim_proc: process
    begin
        X <= "0011000101110000";
        wait for 50 ns;
         X <= "0011000101110000";
        wait for 50 ns;
         X <= "1001000101110000";
        wait for 50 ns;
         X <= "0011000101111111";
        wait for 50 ns;
        wait;
   end process;
end Behavioral;