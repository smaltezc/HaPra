-- Some portions of this code are based on code from the book "Digital Design and Computer Architecture" by Harris and Harris.
-- For educational purposes in TU Dortmund only.

library ieee;
use ieee.std_logic_1164.all;

entity maindec is
  port(
    op: in std_logic_vector(5 downto 0);
    memtoreg: out std_logic;
    memwrite: out std_logic;
    branch: out std_logic;
    alusrc: out std_logic;
    regdst: out std_logic;
    regwrite: out std_logic;
    jump: out std_logic;
    aluop: out std_logic_vector(1 downto 0)
  );
end;

architecture behavior of maindec is
  signal controls: std_logic_vector(8 downto 0);
begin
  process(op) begin
    case op is
      when "000000" => controls <= "110000010"; -- rtype
      when "100011" => controls <= "101001000"; -- lw
      when "101011" => controls <= "001010000"; -- sw
      when "000100" => controls <= "000100001"; -- beq
      when "001000" => controls <= "101000000"; -- addi
      when "000010" => controls <= "000000100"; -- j
      when others => controls <= "---------"; -- illegal
    end case;
  end process;

  regwrite <= controls(8);
  regdst <= controls(7);
  alusrc <= controls(6);
  branch <= controls(5);
  memwrite <= controls(4);
  memtoreg <= controls(3);
  jump <= controls(2);
  aluop <= controls(1 downto 0);
end;
