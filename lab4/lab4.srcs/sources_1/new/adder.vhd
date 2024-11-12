library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity adder is
generic(z : natural := 8);
Port (
A : IN std_logic_vector(z-1 downto 0);
B : IN std_logic_vector(z-1 downto 0);
op: IN std_logic;
C : OUT std_logic_vector(z-1 downto 0)
);
end adder;
architecture Behavioral of adder is
signal op_c_unsigned: unsigned(z-1 downto 0);
begin
process (A,B,op)
begin
if (op = '0') then
op_c_unsigned <= (unsigned(A)) + (unsigned(B));

else

op_c_unsigned <= (unsigned(A)) - (unsigned(B));
end if;
end process;
C <= std_logic_vector(op_c_unsigned);
end Behavioral;