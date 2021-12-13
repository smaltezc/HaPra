library ieee;
use ieee.std_logic_1164.all;

entity SIPO_tb is
  end SIPO_tb;
  
architecture testbench of SIPO_tb is

	component SIPO
		 port (
			d: in std_logic; 
			clk, reset: in std_logic;
			Q : inout	std_logic_vector(7 downto 0)
		);
	end component;
	
	signal d, clk: std_logic;
	signal Q : std_logic_vector(7 downto 0); 
	
begin
  
	sipo1: SIPO port map(d => d, clk => clk, reset => '0', Q => Q); 

    process begin
		d <= '1';
        clk <= '0';
        wait for 10 ns;
		d <= '1';
        clk <= '1'; -- 1.Clock
        wait for 10 ns;
		d <= '0';
        clk <= '0';
        wait for 10 ns;
		d <= '0';	
        clk <= '1';	-- 2.Clock
        wait for 10 ns;
		d <= '1';
        clk <= '0';	
        wait for 10 ns;
		d <= '1';
		clk <= '1';	-- 3.Clock
        wait for 10 ns;
		d <= '1';
		clk <= '0';	
        wait for 10 ns;
		d <= '1';
		clk <= '1';	-- 4.Clock
        wait for 10 ns;
		
		
        wait;
    end process;
   
end testbench;