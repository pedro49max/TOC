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
        clk: IN STD_LOGIC;
        O: out std_logic_vector(n-1 downto 0));
        
end comparator;

architecture Behavioral of comparator is
    component reg is
    Port (
        rst, clk, load: IN STD_LOGIC;
        E: IN STD_LOGIC_VECTOR(3 downto 0);
        S: OUT STD_LOGIC_VECTOR(3 downto 0)
    );
    end component;
    
    signal P, E: std_logic_vector(3 downto 0);
    begin
    MOD_reg: reg port map('0', clk, '1', E, P);
    compare: process(A,B, clk)
        begin
        if rising_edge(clk) then
            if(TO_INTEGER(signed(A)) > TO_INTEGER(signed(B))) then
                E <= A;
            else
                E <= B;
            end if;
        end if;
   end process;
   
   O <= P;
end Behavioral;