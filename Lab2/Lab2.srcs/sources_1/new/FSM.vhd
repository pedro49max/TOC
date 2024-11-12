library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FSM is
    Port (
        rst             : in std_logic;
        clk             : in std_logic;
        boton1           : in std_logic;
        boton2           : in std_logic;
        I               : in std_logic_vector(7 downto 0);
        O               : out std_logic;
        x               : out STD_LOGIC_VECTOR (3 downto 0)
    );
end FSM;

architecture Behavioral of FSM is
type STATE is (initial, three, two, one, final); 
signal actual_STATE, next_STATE: STATE;

component reg 
 Port (
    rst, clk, load: IN STD_LOGIC;
    E: IN STD_LOGIC_VECTOR(7 downto 0);
    S: OUT STD_LOGIC_VECTOR(7 downto 0)
  );
end component;
component comparator is
    Port (
        Password, Input: IN STD_LOGIC_VECTOR(7 downto 0);
        Equ: OUT STD_LOGIC
    );
end component;
    
signal eq, firstInput: std_logic;
signal P: std_logic_vector(7 downto 0);
begin
    MOD_REG: reg port map(rst, clk, firstInput, I, P);
    MOD_COMPARATOR: comparator port map(I, P, eq);
    SINCRONO: process(clk, rst)
    begin
        if rising_edge(clk) then
            if(rst = '1') then
                actual_STATE <= initial;
            elsif (boton1 = '1')then
                actual_STATE <= initial;
            else
                actual_STATE <= next_STATE;
            end if;
        end if;
    end process SINCRONO;
    
    COMBINATIONAL: process(actual_STATE, boton1, boton2, eq)
    begin
        next_STATE <= initial;
        case actual_STATE is 
        when initial =>
            O <= '1';
            x <= "1011";
            firstInput <= '1';
            if(boton1 = '1') then
                next_STATE <= initial;
            else
                next_STATE <= three;
            end if;
         
         when three =>
            O <= '0';
            x <= "0011";
            firstInput <= '0';
            if(boton2 = '1') then
                 if(eq = '1') then
                    next_STATE <= initial;
                else
                    next_STATE <= two;
                end if;
            else
                next_STATE <=three;
            end if;
         when two =>
             O <= '0';
            x <= "0010";
            firstInput <= '0';
            if(boton2 = '1') then
                 if(eq = '1') then
                    next_STATE <= initial;
                else
                    next_STATE <= one;
                end if;
            else
                next_STATE <=two;
            end if;
         when one =>
            O <= '0';
            x <= "0001";
            firstInput <= '0';
            if(boton2 = '1') then
                 if(eq = '1') then
                    next_STATE <= initial;
                else
                    next_STATE <= final;
                end if;           
            else
                next_STATE <= one;
            end if;
        when final =>
            O <= '0';
            x <= "0000";
            firstInput <= '0';
            next_STATE <= final;
        end case;
    end process COMBINATIONAL;
end Behavioral;