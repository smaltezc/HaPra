library ieee;
use ieee.std_logic_1164.all;

-- create testbench for and_gate
-- can be left empty, since test bench (this file) has no inputs or outputs
entity notgate_tb is
end notgate_tb;

architecture test of notgate_tb is
  -- component declaration, so that it can be instantiated later
  -- must have same name and port list as the entity
  component notgate
      port (
        input1 : in std_logic;
        not_result : out std_logic
      );
  end component;
-- define the signals that will be used in test
  signal a, b : std_logic;
-- begin test code
begin
  -- creates an instance of notgate
  not_g: notgate port map(input1 => a, not_result => b);

  process begin
    a <= '0';
    wait for 10 ns;
    a <= '1';
    wait for 10 ns;
    assert false report "End of test";
    wait;
  end process;
end test;
