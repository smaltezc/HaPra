-- Some portions of this code are based on code from the book "Digital Design and Computer Architecture" by Harris and Harris.
-- For educational purposes in TU Dortmund only.

library ieee;
use ieee.std_logic_1164.all;

entity syncresff is
  generic (w: integer:=32);
  port(
    clk: in std_logic;
    reset: in std_logic;
    d: in std_logic_vector(w-1 downto 0);
    q: buffer std_logic_vector(w-1 downto 0)
  );
  end;

architecture behavior of syncresff is
begin
  process(clk, reset) begin
    if reset = '1' then q <= (others => '0');
    elsif rising_edge(clk) then
      q <= d;
    end if;
  end process;
end;
