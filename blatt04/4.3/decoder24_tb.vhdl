library ieee;
use ieee.std_logic_1164.all;

entity decoder24_tb is
end decoder24_tb;

architecture testbench of decoder24_tb is
--missing

	component decoder24
		port (
			i : in  std_logic_vector(1 downto 0);
			y : out std_logic_vector(3 downto 0)
		);
	end component;

	signal i : std_logic_vector(1 DOWNTO 0); 
	signal y : std_logic_vector(3 DOWNTO 0); 

begin
	resul: decoder24 port map(i => i, y => y);
	
	process begin
		i <= "00";
        wait for 10 ns;
        i <= "01";
        wait for 10 ns;
		i <= "10";
        wait for 10 ns;
		i <= "11";
        wait for 10 ns;
        wait;
	end process;

end testbench;