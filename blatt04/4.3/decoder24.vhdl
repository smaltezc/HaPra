library ieee;
use ieee.std_logic_1164.all;

entity decoder24 is 
	port (
		i : in  std_logic_vector(1 downto 0);
		y : out std_logic_vector(3 downto 0)
		);
end decoder24;

architecture rtl of decoder24 is

begin
	-- nach Schaltbild
	y(3) <= i(1) and i(0);
	y(2) <= i(1) and ( not i(0) );
	y(1) <= ( not i(1) ) and i(0);
	y(0) <= ( not i(1) ) and ( not i(0) );
end rtl;