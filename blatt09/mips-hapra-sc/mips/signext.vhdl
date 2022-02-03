-- Some portions of this code are based on code from the book "Digital Design and Computer Architecture" by Harris and Harris.
-- For educational purposes in TU Dortmund only.

library ieee; use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity signext is
  port(
    a: in std_logic_vector(15 downto 0);
    aext: out std_logic_vector(31 downto 0)
  );
end;

architecture behavior of signext is
begin
  aext <= x"ffff" & a when a(15) = '1' else x"0000" & a;
end;
