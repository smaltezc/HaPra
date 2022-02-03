library ieee;
use ieee.std_logic_1164.all;

entity adder_tb is
  end adder_tb;
  
architecture testbench of adder_tb is

	component adder
		port(
		a: in std_logic_vector(31 downto 0);
		b: in std_logic_vector(31 downto 0);
		y: out std_logic_vector(31 downto 0)
		);
	end component;
	
	signal a, b, y: std_logic_vector(31 downto 0);
	
begin
  
	adder1: adder port map(a => a, b => b, y => y); 

    process begin
		a <= "00000000000000000000000000000000";
		b <= "00000000000000000000000000000100";
        wait for 10 ns;
		a <= "00000000000000000000000000001000";
		b <= "00000000000000000000000000000100";
        wait for 10 ns;
        wait;
    end process;
   
end testbench;