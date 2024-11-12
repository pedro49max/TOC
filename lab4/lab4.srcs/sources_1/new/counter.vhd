library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity counter is
generic(t : natural := 8);
Port( E1,E2: IN STD_LOGIC_VECTOR (t-1 downto 0);
S: OUT STD_LOGIC );
end counter;
architecture Behavioral of counter is
begin
process(E1,E2)
begin
if (E2 >= E1) then
S <= '1';
else
S <= '0';
end if;
end process;
end Behavioral;