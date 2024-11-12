library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.all;
entity counter_register is
generic(t : natural := 8);
Port (
rst : IN std_logic;
clk : IN std_logic;
load : IN std_logic;
cont : IN std_logic;
E : IN std_logic_vector(t-1 downto 0);
S : OUT std_logic_vector(t-1 downto 0)
);
end counter_register;
architecture cuenta of counter_register is
SIGNAL cnt : UNSIGNED(t-1 DOWNTO 0);
begin
    process(clk, rst)
    begin
        if(rising_edge(clk))then
            if(rst='1')then
                cnt <= (others => '0');
            elsif(load='1')then
                cnt <= unsigned(E);
            elsif(cont='1')then
                cnt <= cnt+1;
            end if;
       end if;
    end process;
    S <= std_logic_vector(cnt);
end cuenta;