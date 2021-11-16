library ieee;
use ieee.std_logic_1164.all;

entity signals_tb is
end signals_tb;

architecture test of signals_tb is
  signal a, b, c, d : std_logic; -- c for and 
								 -- d for or
begin
	c <= a and b;
	d <= a or b;
  process begin
    a <= '0'; -- c=0
    b <= '1'; -- d=1
    wait for 10 ns;
    a <= 'X'; -- c=0
    b <= '0'; -- d=x
    wait for 10 ns;
    a <= 'X'; -- c=x
    b <= 'W'; -- d=x
    wait for 10 ns;
	a <= '0'; -- c=0
    b <= 'Z'; -- d=x
    wait for 10 ns;
	a <= '1'; -- c=x 
    b <= 'W'; -- d=1
    wait for 10 ns;
	a <= 'W'; -- c=0
    b <= 'L'; -- d=x
    wait for 10 ns;
	a <= 'W'; -- c=x
    b <= 'H'; -- d=1
    wait for 10 ns;
	a <= 'L'; -- c=0
    b <= 'Z'; -- d=x
    wait for 10 ns;
    assert false report "End of test";
    wait;
  end process;
end test;
