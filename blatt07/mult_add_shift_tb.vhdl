library ieee;
use ieee.std_logic_1164.all;

entity mult_add_shift_tb is
end mult_add_shift_tb;

architecture rtl of mult_add_shift_tb is

component mult_add_shift 
	port (
    x,y : in std_logic_vector(3 downto 0); 
	z : out std_logic_vector(7 downto 0)
	);
	end component;
	signal x,y : std_logic_vector(3 downto 0);
	signal z : std_logic_vector(7 downto 0);
begin
	mult_add_shift_1 : mult_add_shift port map (x => x, y => y, z => z);
	process begin
	x <= "1010";
	y <= "1101";
	wait for 10 ns;
	x <= "1001";
	y <= "0111";
	wait for 10 ns;
	x <= "1101";
	y <= "1100";
	wait for 10 ns;
	wait;
	end process;
end rtl;

