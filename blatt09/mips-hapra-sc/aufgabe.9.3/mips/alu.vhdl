-- Some portions of this code are based on code from the book "Digital Design and Computer Architecture" by Harris and Harris.
-- For educational purposes in TU Dortmund only.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
  port(
    a: in std_logic_vector(31 downto 0);
    b: in std_logic_vector(31 downto 0);
    alucontrol: in std_logic_vector(2 downto 0);
    result: buffer std_logic_vector(31 downto 0);
    zero: out std_logic
  );
end;

architecture behavior of alu is
begin
  process(a, b, alucontrol)
    begin case alucontrol is
      when "000" => result <= a and b;
      when "001" => result <= a or b;
      when "010" => result <= std_logic_vector(unsigned(a) + unsigned(b));
      when "110" => result <= std_logic_vector(unsigned(a) - unsigned(b));
      when "111" =>
        if(a < b) then
          result <= x"00000001";
        else
          result <= x"00000000";
        end if;
      when others => null;
    end case;
  end process;
  zero <= '1' when result = x"00000000" else '0';
end;
