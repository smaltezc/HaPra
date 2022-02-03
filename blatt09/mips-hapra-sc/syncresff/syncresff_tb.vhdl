library ieee;
use ieee.std_logic_1164.all;

entity syncresff_tb is
  end syncresff_tb;
  
architecture testbench of syncresff_tb is

 constant half_period  : time    := 5 ns; -- for clock

	component syncresff
		generic (w :	Integer:=32);
		port(
		clk: in std_logic;
		reset: in std_logic;
		d: in std_logic_vector(w-1 downto 0);
		q: buffer std_logic_vector(w-1 downto 0)
		);
	end component;
	
	signal clk, finished : std_logic := '0';
	signal d, q : std_logic_vector(31 downto 0);
	signal reset : std_logic;
	
	
begin
  
	syncresff1: syncresff port map(clk => clk, reset => reset, d=> d, q => q); 


	clk <= not clk after half_period when finished /= '1' else '0'; -- for clock
    process begin
		reset <= '0';
		d <= "00000000011000010000000001010000";
        wait for 10 ns;
		reset <= '1';
		wait for 10 ns;
		finished <= '1';
		
        wait;
    end process;
   
end testbench;