-- Some portions of this code are based on code from the book "Digital Design and Computer Architecture" by Harris and Harris.
-- For educational purposes in TU Dortmund only.

library ieee;
use ieee.std_logic_1164.all;

entity mux2 is
  generic(w: integer := 8);
  port(
    d0: in std_logic_vector(w-1 downto 0);
    d1: in std_logic_vector(w-1 downto 0);
    s: in std_logic;
    y: out std_logic_vector(w-1 downto 0)
  );
end;

architecture behavior of mux2 is
begin
  y <= d1 when s = '1' else d0;
end;
