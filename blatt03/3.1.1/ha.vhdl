library ieee;
use ieee.std_logic_1164.all;

entity ha is
  port (
    a: in std_logic;
    b: in std_logic;
    o: out std_logic;
    c: out std_logic
  );
end ha;

architecture rtl of ha is
begin
-- MISSING
-- MISSING
	o <= a xor b;
	c <= a and b;
end rtl;
