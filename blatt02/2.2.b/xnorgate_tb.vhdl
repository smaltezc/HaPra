library ieee;
use ieee.std_logic_1164.all;

-- create testbench for and_gate
-- can be left empty, since test bench (this file) has no inputs or outputs
entity xnorgate_tb is
end xnorgate_tb;

architecture test of xnorgate_tb is
  -- component declaration, so that it can be instantiated later
  -- must have same name and port list as the entity
  component xnorgate
      port (
        input1 : in std_logic;
        input2 : in std_logic;
        xnor_result : out std_logic
      );
  end component;
-- define the signals that will be used in test
  signal a, b, c : std_logic;
-- begin test code
begin
  -- creates an instance of xnorgate
  xnor_g: xnorgate port map(input1 => a, input2 => b, xnor_result => c);

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
