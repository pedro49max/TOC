library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity comparator is
    Port (
        Password, Input: IN STD_LOGIC_VECTOR(7 downto 0);
        Equ: OUT STD_LOGIC
    );
end comparator;

architecture Behavioral of comparator is
begin
    process (Password, Input)
    begin
        if(Password = Input) then
            Equ <= '1';
        else
            Equ <= '0';
        end if;
    end process;
end Behavioral;
