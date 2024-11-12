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

entity iterativeCell is
    generic(
       n:natural:=4
    );
    Port ( Z: in std_logic_vector(n-1 downto 0) ;
        Ci: in std_logic_vector(n-1 downto 0) ;
        Co: out std_logic_vector(n-1 downto 0));
end iterativeCell;

architecture Behavioral of iterativeCell is

begin
    comparation: process(z, Ci)
        begin
         if(TO_INTEGER(signed(Z)) > TO_INTEGER(signed(Ci))) then
            Co <= Z;
        else
            Co <= Ci;
        end if;
    end process;
end Behavioral;
