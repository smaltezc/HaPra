library ieee;
use ieee.std_logic_1164.all;

entity signals_tb is
end signals_tb;

architecture test of signals_tb is
  signal a, b, c, d : std_logic; -- c for and 
								 -- d for or
begin
  process begin
    a <= '0';
    b <= '0';
	c <= '0' and '0'; -- c = 0
	d <= '0' or '0';  -- d = 0
    wait for 10 ns;
    a <= '0';
    b <= '1';
	c <= '0' and '1'; -- c = 0
	d <= '0' or '1';  -- d = 1
    wait for 10 ns;
    a <= '1';
    b <= '1';
	c <= '1' and '1'; -- c = 1
	d <= '1' or '1';  -- d = 1
    wait for 10 ns;
    a <= 'X';
    b <= 'W';
	c <= 'X' and 'W'; -- c = x
	d <= 'X' or 'W';  -- d = x
    wait for 10 ns;
	a <= '1';
    b <= 'H';
	c <= '1' and 'H'; -- c = 1
	d <= '1' or 'H';  -- d = 1
    wait for 10 ns;
	a <= 'W';
    b <= 'Z';
	c <= 'W' and 'Z'; -- c = x
	d <= 'W' or 'Z';  -- d = x
    wait for 10 ns;
	a <= 'L';
    b <= 'H';
	c <= 'L' and 'H'; -- c = 0
	d <= 'L' or 'H';  -- d = 1
    wait for 10 ns; 
	a <= 'L';
    b <= 'W';
	c <= 'L' and 'W'; -- c = 0
	d <= 'L' or 'W';  -- d = x
    wait for 10 ns; 
	a <= 'Z';
    b <= '0';
	c <= 'Z' and '0'; -- c = 0
	d <= 'Z' or '0';  -- d = x
    wait for 10 ns;
    assert false report "End of test";
    wait;
  end process;
end test;
