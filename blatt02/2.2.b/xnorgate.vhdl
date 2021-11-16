-- from the ieee libary we use std_logic_1164
-- defines a standard for logic values used in electronic design
-- for more info check the std_logic_1164.vhdl file in ghdl/libraries/ieee
-- ieee libary also defines operators and keywords
library ieee;
use ieee.std_logic_1164.all;
-- define signal (fundamental unit in vhdl) of type std_logic, called xnor_gate
-- xnor_gate gets assigned "input1 and input2"
--
--signal xnor_gate: std_logic;
--xnor_gate <= input1 and input2;

-- inputs and outputs of a file (xnorgate.vhdl) are defined in entities (black boxes)
-- entity has port that defines all inputs and outputs of file
-- like a header file (.h)
-- std_logic can have 9 different values, it is part of std_logic_1164 package
-- you can think of it as a single bit
entity xnorgate is
  port (
    input1 : in std_logic;
    input2 : in std_logic;
    xnor_result : out std_logic
  );
end xnorgate;

-- architecture describes functionality of particular entity
-- like .c implementation of a function
-- actually describes the "internal wiring" of block
architecture rtl of xnorgate is
  -- interconnection signals, constants, or other components
  signal xnor_gate : std_logic;
begin
  xnor_gate <= input1 xnor input2;
  xnor_result <= xnor_gate;
end rtl;
