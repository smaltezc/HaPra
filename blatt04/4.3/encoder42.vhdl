library ieee;
use ieee.std_logic_1164.all;

entity encoder42 is 
	port (
		i : in  std_logic_vector(3 downto 0);
		y : out std_logic_vector(1 downto 0)
		);
end encoder42;

architecture rtl of encoder42 is
--missing
begin
	-- nach Schaltbild
	y(1) <= i(3) or i(2);
	y(0) <= i(3) or ( (not i(2)) and i(1) );
end rtl;