library ieee;
use ieee.std_logic_1164.all;

entity signal_levels is --signals_tb
end signal_levels;

architecture test of signal_levels is
  signal a, b, c_and, c_or : std_logic;
begin
  process begin
    a <= '0';
    b <= '0';
	c_and <= a and b;
	c_or <= a or b;
    wait for 10 ns;
    a <= '0';
    b <= '1';
	c_and <= a and b;
	c_or <= a or b;
    wait for 10 ns;
    a <= '1';
    b <= '0';
	c_and <= a and b;
	c_or <= a or b;
    wait for 10 ns;
    a <= '1';
    b <= '1';
	c_and <= a and b;
	c_or <= a or b;
    wait for 10 ns;
    a <= 'X';
    b <= 'W';
	c_and <= a and b;
	c_or <= a or b;
    wait for 10 ns;
    assert false report "End of test";
    wait;
  end process;
end test;
