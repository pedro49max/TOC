library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
entity right_shift_reg is
generic(t : natural := 8);
Port (
rst : IN std_logic;
clk : IN std_logic;
load : IN std_logic;
desp : IN std_logic;
E : IN std_logic_vector(t-1 downto 0);
S : OUT std_logic_vector(t-1 downto 0)
);
end right_shift_reg;

architecture despdere of right_shift_reg is

signal cambio: std_logic_vector(t-1 downto 0);
begin
    process(clk)
    begin
        if(rising_edge(clk))then
            if(rst='1')then
                cambio <= (others => '0');
            elsif(load='1')then
                cambio <= E;
            elsif(desp = '1')then
                cambio <= '0' & cambio(t-1 downto 1);
            end if;
        end if;
    end process;
    S <= cambio;
end despdere;