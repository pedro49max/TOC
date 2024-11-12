library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.all;

entity regDiv is
    generic(t : natural := 8);
    port (
        rst : IN std_logic;
        clk : IN std_logic;
        load : IN std_logic;
        E : IN std_logic_vector(t-1 downto 0);
        S : OUT std_logic_vector(t-1 downto 0)
    );
end regDiv;

architecture Behavioral of regDiv is
SIGNAL pl : UNSIGNED(t-1 DOWNTO 0);
begin
    process(clk, rst)
    begin
        if(rising_edge(clk))then
            if(rst='1')then
                pl <= (others => '0');
            elsif(load='1')then
                pl <= unsigned(E);
            end if;
       end if;
    end process;
    S <= std_logic_vector(pl);
end Behavioral;
