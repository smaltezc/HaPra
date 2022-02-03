library ieee;
use ieee.std_logic_1164.all;

entity sl2_tb is
  end sl2_tb;
  
architecture testbench of sl2_tb is
	
	component sl2
		port(
			a: in std_logic_vector(31 downto 0);
			y: out std_logic_vector(31 downto 0)
		  );
	end component;
	
	signal a, y: std_logic_vector(31 downto 0);
	
begin
  
	sl21: sl2 port map(a => a, y => y); 

    process begin
		a <= "11111111111111111111111111111111";
        wait for 10 ns;
		a <= "11111111111000000000001111111111";
        wait for 10 ns;
        wait;
    end process;
   
end testbench;