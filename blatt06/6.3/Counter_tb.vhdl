library ieee;
use ieee.std_logic_1164.all;

entity Counter_tb is
  end Counter_tb;
  
architecture testbench of Counter_tb is

 constant half_period    : time    := 5 ns; -- for clock

	component Counter
		 port(
		clk, reset : in std_logic;
		count, down : in std_logic;
	    Q : out std_logic_vector(1 downto 0)
		);
	end component;
	
	signal clk, finished : std_logic := '0';
	signal reset, count, down: std_logic;
	signal Q : std_logic_vector(1 downto 0);
	
	
begin
  
	Counter1 : Counter port map(clk => clk, reset => '0', count => count, 
								down => down, Q => Q );


	clk <= not clk after half_period when finished /= '1' else '0'; -- for clock
    process begin
		count <= '1';
		down <= '0';
        wait for 10 ns;
		count <= '1';
		down <= '0';
		wait for 10 ns;
        count <= '1';
		down <= '0';
        wait for 10 ns;
		count <= '1';
		down <= '0';
        wait for 10 ns;
		count <= '1';
		down <= '1';
        wait for 10 ns;
		count <= '1';
		down <= '1';
        wait for 10 ns;
		count <= '1';
		down <= '1';	
        wait for 10 ns;
		count <= '1';
		down <= '1';
        wait for 10 ns;
		finished <= '1';
		
        wait;
    end process;
   
end testbench;