library ieee;
use ieee.std_logic_1164.all;

entity signext_tb is
  end signext_tb;
  
architecture testbench of signext_tb is

	component signext
		port(
		a: in std_logic_vector(15 downto 0);
		aext: out std_logic_vector(31 downto 0)
		);
	end component;
	
	signal a: std_logic_vector(15 downto 0);
	signal aext :  std_logic_vector(31 downto 0);
	
	
begin
  
	signext1: signext port map(a => a, aext => aext); 

    process begin
		a <= "0000000001010000";
        wait for 10 ns;
		a <= "1100000001010000";
		wait for 10 ns;
		
        wait;
    end process;
   
end testbench;