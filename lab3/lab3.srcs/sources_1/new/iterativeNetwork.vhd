
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
entity iterativeNetwork  is
    generic(
        n_bits: natural := 4;
        n_inputs: natural := 4
    );
    Port ( X : in STD_LOGIC_VECTOR (n_inputs*n_bits-1 downto 0);
        O : out STD_LOGIC_VECTOR (n_bits-1 downto 0));
end iterativeNetwork ;

architecture Behavioral of iterativeNetwork  is

    component iterativeCell 
        generic(
            n: natural := 4
        ); Port ( Z : in STD_LOGIC_VECTOR (n-1 downto 0);
            Ci : in STD_LOGIC_VECTOR (n-1 downto 0);
            Co : out STD_LOGIC_VECTOR (n-1 downto 0));
    end component;
    
type C_type is array (n_inputs downto 0) of std_logic_vector(n_bits-1 downto 0);
signal C : C_type;

begin
    C(0) <= "1000";
    gen1: for i in 0 to n_inputs-1 generate
        u: iterativeCell port map(X((i+1)*n_bits-1 downto i*n_bits),
        C(i),
        C(i+1));
    end generate gen1;

    O <= C(n_inputs);
end Behavioral;
