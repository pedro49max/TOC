library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity comparator is
    generic(
       n:natural:=4
    );
    Port ( A: in std_logic_vector(n-1 downto 0) ;
        B: in std_logic_vector(n-1 downto 0) ;
        O: out std_logic_vector(n-1 downto 0));
end comparator;

architecture Behavioral of comparator is
    begin
    compare: process(A,B)
        begin
        if(TO_INTEGER(signed(A)) > TO_INTEGER(signed(B))) then
            O <= A;
        else
            O <= B;
        end if;
   end process;
end Behavioral;
