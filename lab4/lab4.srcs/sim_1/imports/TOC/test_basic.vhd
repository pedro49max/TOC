LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.NUMERIC_STD.all;
--use work.definitions.all;

ENTITY simu IS
    generic (
n : natural := 8;
m: natural := 4);
END simu;
 
ARCHITECTURE behavior OF simu IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT division

    PORT(
       clk : IN  std_logic;
	    reset : IN  std_logic;
		 dividend : IN  std_logic_vector(N - 1 downto 0);
       divisor : IN  std_logic_vector(M-1 downto 0);
		 start : IN  std_logic;
	    ready : OUT  std_logic;
		 quotient : OUT  std_logic_vector(N-1 downto 0)
    );
    END COMPONENT;
    

   --Inputs
   signal dividend : std_logic_vector(N-1 downto 0) := (others => '0');
   signal divisor : std_logic_vector(M-1 downto 0) := (others => '0');
   signal start : std_logic := '0';
   signal reset : std_logic := '0';
   signal clk : std_logic := '0';

 	--Outputs
   signal quotient : std_logic_vector(N-1 downto 0);
   signal ready: std_logic;

   -- Clock period definitions
   constant clk_period : time := 2 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: division 
	PORT MAP (
	       clk => clk,
          reset => reset,
          dividend => dividend,
          divisor => divisor,
			 start => start,
	       ready => ready,
			 quotient => quotient
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

  -- Stimulus process
   stim_proc: process
   begin		
      reset <= '1';
		wait for 80 ns;
		
		--61/5=12
		reset <= '0';	
		start <= '1';
		dividend <= "00111101";
		divisor <= "0101";
      wait for 2*clk_period;
		
		start <= '0';
		wait for 100 ns;

		reset <= '1';
      wait for 100 ns;

		--61/7=8
		reset <= '0';
		start <= '1';
		dividend <= "11110110";
		divisor <= "0101";
		wait for 2*clk_period;
		
		start <= '0';
		wait for 100 ns;

		reset <= '1';
      wait for 100 ns;

		--29/7=4
		reset <= '0';		
		start <= '1';
		dividend <= "01110100";
		divisor <= "0101";
		wait for 2*clk_period;
		
		start <= '0';
		wait for 50*clk_period;

		reset <= '1';
      wait for 100 ns;

		--41/5=8
		reset <= '0';		
		start <= '1';
		dividend <= "10100001";
		divisor <= "0001";
		wait for 2*clk_period;
		
		start <= '0';
		wait for 50*clk_period;

		reset <= '1';
      wait for 100 ns;

		--35/7=5
		reset <= '0';		
		start <= '1';
		dividend <= "10001100";
		divisor <= "1101";
		wait for 2*clk_period;
		
		start <= '0';
      wait;

   end process;

END;