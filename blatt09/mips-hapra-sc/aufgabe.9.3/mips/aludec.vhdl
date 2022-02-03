-- Some portions of this code are based on code from the book "Digital Design and Computer Architecture" by Harris and Harris.
-- For educational purposes in TU Dortmund only.

library ieee;
use ieee.std_logic_1164.all;

entity aludec is
  port(
    funct: in std_logic_vector(5 downto 0);
    aluop: in std_logic_vector(1 downto 0);
    alucontrol: out std_logic_vector(2 downto 0)
  );
end;

architecture behavior of aludec is
begin
  process(funct, aluop) begin
    case aluop is
      when "00" => alucontrol <= "010"; -- add (for lw/sw/addi)
      when "01" => alucontrol <= "110"; -- sub (for beq)
      when others => case funct is
        when "100000" => alucontrol <= "010"; -- add
        when "100010" => alucontrol <= "110"; -- sub
        when "100100" => alucontrol <= "000"; -- and
        when "100101" => alucontrol <= "001"; -- or
        when "101010" => alucontrol <= "111"; -- slt
        when others => alucontrol <= "---"; -- wrong entry in funct
      end case;
    end case;
  end process;
end;
