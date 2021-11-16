library ieee;
use ieee.std_logic_1164.all;

entity deneme is
end deneme;

architecture test of deneme is
  signal a, b, c, d : std_logic;
begin
	c <= a and b;
	d <= a or b;
  process begin
    a <= '0';
    b <= '0';
    wait for 10 ns;
    a <= '0';
    b <= '1';
    wait for 10 ns;
    a <= '1';
    b <= '0';
    wait for 10 ns;
    a <= '1';
    b <= '1';
    wait for 10 ns;
    a <= 'X';
    b <= 'W';
    wait for 10 ns;
    assert false report "End of test";
    wait;
  end process;
end test;
