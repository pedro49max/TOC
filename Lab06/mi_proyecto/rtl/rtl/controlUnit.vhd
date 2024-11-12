library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity controlUnit is
  port(
    clk     : in  std_logic;
    rst_n   : in  std_logic;
    control : out std_logic_vector(15 downto 0);
    dbg_uc  : out std_logic_vector(31 downto 0);
    Zero    : in  std_logic;
    op      : in  std_logic_vector(5 downto 0)
  );
end controlUnit;

architecture controlUnitArch of controlUnit is

  signal control_aux : std_logic_vector(15 downto 0);
  alias PCWrite      : std_logic is control_aux(0);
  alias IorD         : std_logic is control_aux(1);
  alias MemWrite     : std_logic is control_aux(2);
  alias MemRead      : std_logic is control_aux(3);
  alias IRWrite      : std_logic is control_aux(4);
  alias RegDst       : std_logic is control_aux(5);
  alias MemtoReg     : std_logic is control_aux(6);
  alias RegWrite     : std_logic is control_aux(7);
  alias AWrite       : std_logic is control_aux(8);
  alias BWrite       : std_logic is control_aux(9);
  alias ALUScrA      : std_logic is control_aux(10);
  alias ALUScrB      : std_logic_vector(1 downto 0) is control_aux(12 downto 11);
  alias OutWrite     : std_logic is control_aux(13);
  alias ALUop        : std_logic_vector(1 downto 0) is control_aux(15 downto 14);

  TYPE states IS (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13, S14); --Homework
  SIGNAL currentState, nextState: states;

begin

  control <= control_aux;

  dbg_uc <= std_logic_vector(to_unsigned(0,32)) when currentState = s0 else
            std_logic_vector(to_unsigned(1,32)) when currentState = s1 else
            std_logic_vector(to_unsigned(2,32)) when currentState = s2 else
            std_logic_vector(to_unsigned(3,32)) when currentState = s3 else
            std_logic_vector(to_unsigned(4,32)) when currentState = s4 else
            std_logic_vector(to_unsigned(5,32)) when currentState = s5 else
            std_logic_vector(to_unsigned(6,32)) when currentState = s6 else
            std_logic_vector(to_unsigned(7,32)) when currentState = s7 else
            std_logic_vector(to_unsigned(8,32)) when currentState = s8 else
            std_logic_vector(to_unsigned(9,32)) when currentState = s9 else
            std_logic_vector(to_unsigned(10,32)) when currentState = s10 else
            std_logic_vector(to_unsigned(11,32)) when currentState = s11 else
            (others => '0');

  stateGen:
  PROCESS (currentState, op , zero)
  BEGIN
    nextState   <= currentState;
    control_aux <= (OTHERS=>'0');

    CASE currentState IS

      WHEN S0 =>
        PCWrite   <= '1';
        MemRead   <= '1';
        ALUScrB   <= "01";
        nextState <= S1;

      WHEN S1 =>
        IRWrite   <= '1';
        nextState <= S2;

      WHEN S2 =>
        AWrite <= '1';
        BWrite <= '1';
        if (op = "000000") then    -- R-type
          nextState <= S8;
        elsif (op = "100011") then -- lw
          nextState <= S3;
        elsif (op = "101011") then -- sw
          nextState <= S6;
        elsif (op = "000100") then -- beq
          nextState <= S10;
        elsif (op = "010000") then -- Homework, move instruction with immediate
          nextState <= S12;
        elsif (op = "010010") then -- Homework, move with register
          nextState <= S13;
        end if;

      WHEN S3 =>
        ALUScrA   <= '1';
        ALUScrB   <= "10";
        OutWrite  <= '1';
        nextState <= S4;

      WHEN S4 =>
        MemRead   <= '1';
        IorD      <= '1';
        nextState <= S5;

      WHEN S5 =>
        MemtoReg  <= '1';
        RegWrite  <= '1';
        nextState <= S0;

      WHEN S6 =>
        ALUScrA   <= '1';
        ALUScrB   <= "10";
        OutWrite  <= '1';
        nextState <= S7;

      WHEN S7 =>
        MemWrite  <= '1';
        IorD      <= '1';
        nextState <= S0;

      WHEN S8 =>
        ALUScrA   <= '1';
        ALUOp     <= "10";
        OutWrite  <= '1';
        nextState <= S9;

      WHEN S9 =>
        RegDst    <= '1';
        RegWrite  <= '1';
        nextState <= S0;

      WHEN S10 =>
        ALUScrA <= '1';
        ALUOp   <= "01";
        if (Zero = '0') then
          nextState <= S0;
        else
          nextState <= S11;
        end if;

      WHEN S11 =>
        PCWrite <= '1';
        ALUScrB <= "11";
        nextState <= S0;
        
      WHEN S12 => -- Homework, move instruction with immediate
        ALUScrA   <= '1';
        ALUScrB   <= "10";
        ALUop <= "11";
        OutWrite  <= '1';
        nextState <= S14;
      
      WHEN S13 => -- Homework, move with register
        ALUScrA   <= '1';
        ALUScrB   <= "10";
        OutWrite  <= '1';
        nextState <= S14; 
         
      WHEN S14 => -- Homework, update rt
        RegDst    <= '0';
        RegWrite  <= '1';
        nextState <= S0;
                  
    END CASE;
  END PROCESS stateGen;

  state:
  PROCESS (rst_n, clk)
  BEGIN
    IF (rst_n = '0') THEN
      currentState <= S0;
    ELSIF RISING_EDGE(clk) THEN
      currentState <= nextState;
    END IF;
  END PROCESS state;

end controlUnitArch;
