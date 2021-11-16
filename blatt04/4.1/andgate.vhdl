
library ieee;
use ieee.std_logic_1164.all;

entity andgate is
  port (
    input1 : in std_logic;
    input2 : in std_logic;
	input3 : in std_logic;
    and_result : out std_logic
  );
end andgate;


architecture rtl of andgate is

  signal and_gate : std_logic;
begin
  and_gate <= input1 and input2 and input3;
  and_result <= and_gate;
end rtl;
