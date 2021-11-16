library ieee;
use ieee.std_logic_1164.all;

entity rca is
  port (
    a : in std_logic_vector(7 downto 0);
    b : in std_logic_vector(7 downto 0);
	--s: in std_logic; -- select eingang
    --
	cout: out std_logic; --
    sum : out std_logic_vector(7 downto 0)
  );
end rca;

architecture rtl of rca is
  component fa
    port (
      a : in std_logic;
      b : in std_logic;
      cin : in std_logic;
      cout : out std_logic;
      sum : out std_logic
    );
  end component;
  signal wire_1 : std_logic;
  signal wire_2 : std_logic;
  signal wire_3 : std_logic;
  signal wire_4 : std_logic;
  signal wire_5 : std_logic;
  signal wire_6 : std_logic;
  signal wire_7 : std_logic;
  --signal bt: std_logic_vector(7 downto 0);
  --signal wire_8 : std_logic;
  -- more wires ?
begin
	
	-- 2's complement
	--process(s)
	--begin
	--	if s='1' then
	--		bt(0) <= b(0) xor s; bt(1) <= b(1) xor s;
	--		bt(2) <= b(2) xor s; bt(3) <= b(3) xor s;
	--		bt(4) <= b(4) xor s; bt(5) <= b(5) xor s;
	--		bt(6) <= b(6) xor s; bt(7) <= b(7) xor s;
	--	end if;
	--end process;
	
	add0 : fa port map(a => a(0), b => b(0), cin => '0', cout => wire_1, sum => sum(0));
	add1 : fa port map(a => a(1), b => b(1), cin => wire_1, cout => wire_2, sum => sum(1));
	add2 : fa port map(a => a(2), b => b(2), cin => wire_2, cout => wire_3, sum => sum(2));
	add3 : fa port map(a => a(3), b => b(3), cin => wire_3, cout => wire_4, sum => sum(3));
	add4 : fa port map(a => a(4), b => b(4), cin => wire_4, cout => wire_5, sum => sum(4));
	add5 : fa port map(a => a(5), b => b(5), cin => wire_5, cout => wire_6, sum => sum(5));
	add6 : fa port map(a => a(6), b => b(6), cin => wire_6, cout => wire_7, sum => sum(6));
	add7 : fa port map(a => a(7), b => b(7), cin => wire_7, cout => cout, sum => sum(7));

-- ?
end rtl;
