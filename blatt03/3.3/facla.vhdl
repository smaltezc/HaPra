library ieee;
use ieee.std_logic_1164.all;

entity facla is
  port (
    a : in std_logic;
    b : in std_logic;
    cin : in std_logic;
    g : out std_logic;
    p : out std_logic;
    sum : out std_logic
  );
end facla;

architecture rtl of facla is
	

begin
	g <= a and b;
	p <= a or b;
	sum <= a xor b xor cin;

end rtl;
