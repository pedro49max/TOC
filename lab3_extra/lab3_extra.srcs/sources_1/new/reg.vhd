 library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg is
 Port (
    rst, clk, load: IN STD_LOGIC;
    E: IN STD_LOGIC_VECTOR(3 downto 0);
    S: OUT STD_LOGIC_VECTOR(3 downto 0)
 );
 end reg;

architecture Behavioral of reg is
begin
    process(clk)
    begin
        if(rising_edge(clk)) then
            if(rst = '1') then
                S <= "0000";
            elsif (load = '1') then
                S <= E;
            end if;
         end if;
    end process;
end Behavioral;
