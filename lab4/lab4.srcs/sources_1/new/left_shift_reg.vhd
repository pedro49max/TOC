library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity left_shift_reg is
generic(t : natural := 8);
Port (
rst : IN std_logic;
clk : IN std_logic;
load : IN std_logic;
desp : IN std_logic;
MSB : IN std_logic;
E : IN std_logic_vector(t-1 downto 0);
S : OUT std_logic_vector(t -1 downto 0)
);
end left_shift_reg;

architecture Behavioral of left_shift_reg is
signal cambio: std_logic;
signal mov: std_logic_vector(t-1 downto 0);
begin
    process(clk, rst)
    begin
        if(MSB = '0')then
            cambio <= '1';
        else
            cambio <= '0';
        end if;
        if(rising_edge(clk))then
            if(rst='1')then
                mov <= (others => '0');
            elsif(load='1')then
                mov <= E;
            elsif(desp='1')then
                mov <= mov(t-2 downto 0) & cambio;
            end if;
        end if;
    end process;
    S <= mov;
end Behavioral;
