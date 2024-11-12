library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity treeComparator  is
    generic(
        n_bits: natural := 4;
        n_inputs: natural := 4
    );
    Port ( X : in STD_LOGIC_VECTOR (n_inputs*n_bits-1 downto 0);
        clk: IN STD_LOGIC;
        O : out STD_LOGIC_VECTOR (n_bits-1 downto 0));
        
end treeComparator ;

architecture Behavioral of treeComparator  is
    function Log2( input:integer ) return integer is
        variable temp,log:integer;
    begin
        temp:=input;
        log:=0;
        while (temp >1) loop
            temp:=temp/2;
            log:=log+1;
    end loop;
    return log;
    end function log2;
    
    component comparator 
        generic(
            n: natural := 4 );
        Port ( A: in std_logic_vector(n-1 downto 0) ;
        B: in std_logic_vector(n-1 downto 0) ;
        clk: IN STD_LOGIC;
        O: out std_logic_vector(n-1 downto 0));
    end component;
    
    type C_type is array (Log2(n_inputs) downto 0,n_inputs-1 downto 0) of std_logic_vector(n_bits-1 downto 0);
    
signal C : C_type;
begin

    generate_inputs: for i in 0 to n_inputs-1 generate
        C(0,i) <= X((i+1)*n_bits-1 downto i*n_bits);
        end generate generate_inputs;
        
    generate_levels: for i in 0 to Log2(n_inputs)-1 generate
    generate_comparators: for j in 0 to (n_inputs/2**(i+1))-1 generate
    comparator_i: comparator 
-- generic map(
-- n => n_bits
-- );
        port map (
            clk => clk,
            A => C(i,2*j),
            B => C(i,2*j+1),
            O => C(i+1,j)
        );
    end generate generate_comparators;
    end generate generate_levels;
    O <= C(Log2(n_inputs), 0);
end Behavioral;