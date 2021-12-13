library ieee;
use ieee.std_logic_1164.all;

entity Bitmuster_tb is
  end Bitmuster_tb;
  
architecture testbench of Bitmuster_tb is

 constant half_period    : time    := 5 ns; -- for clock

	component Bitmuster
		 port(
		clk, reset : in std_logic;
		d: in std_logic;
		Y: out std_logic 
		);
	end component;
	
	signal clk, finished : std_logic := '0';
	signal d, Y: std_logic;
	
	
begin
  
	Bitmuster1: Bitmuster port map(d=> d, clk => clk, reset => '0', Y => Y); 


	clk <= not clk after half_period when finished /= '1' else '0'; -- for clock
    process begin
		d<= '1';
        wait for 10 ns;
		d<= '0';
        wait for 10 ns;
		d<= '1';	
        wait for 10 ns;
		d<= '1';
        wait for 10 ns;
		d<= '0';	
        wait for 10 ns;
		d<= '1';
		wait for 10 ns;
		d<= '0';
        wait for 10 ns;
		d<= '1';	
        wait for 10 ns;
		d<= '1';
        wait for 10 ns;
		d<= '0';	
        wait for 10 ns;
		d<= '1';
		wait for 10 ns;
		d<= '0';
        wait for 10 ns;
		d<= '1';	
        wait for 10 ns;
		d<= '1';
        wait for 10 ns;
		finished <= '1';
		
        wait;
    end process;
   
end testbench;