library ieee;
use ieee.std_logic_1164.all;

entity encoder42_tb is
end encoder42_tb;

architecture testbench of encoder42_tb is
--missing

	component encoder42
		port (
			i : in  std_logic_vector(3 downto 0);
			y : out std_logic_vector(1 downto 0)
		);
	end component;

	signal i : std_logic_vector(3 DOWNTO 0); 
	signal y : std_logic_vector(1 DOWNTO 0); 

begin
	resul: encoder42 port map(i => i, y => y);
	
	process begin
		i <= "0001";
        wait for 10 ns;
        i <= "0010";
        wait for 10 ns;
		i <= "0100";
        wait for 10 ns;
		i <= "1000";
        wait for 10 ns;
        wait;
	end process;

end testbench;