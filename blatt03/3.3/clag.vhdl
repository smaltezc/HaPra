library ieee;
use ieee.std_logic_1164.all;

entity clag is
  port (
    gin : in std_logic_vector(3 downto 0);
    pin : in std_logic_vector(3 downto 0);
    cin : in std_logic;
    cout : out std_logic_vector(3 downto 0);
    pout : out std_logic;
    gout : out std_logic
  );
end clag;

architecture rtl of clag is

	signal c: std_logic_vector(3 downto 0);
	

begin
	
	--cout_assignment : for i in 0 to 3 generate 
            --   1        0  = 1
	c(0) <= gin(0) or (pin(0) and cin);
	c(1) <= gin(1) or (pin(1) and (c(0)) );
	c(2) <= gin(2) or (pin(2) and (c(1)) );
	c(3) <= gin(3) or (pin(3) and (c(2)) );
	cout <= c;
										
    --end generate cout_assignment;
	
	
	pout <= pin(3) and pin(2) and pin(1) and pin(0);
	gout <= gin(3) or (pin(3) and gin(2)) or (pin(3) and pin(2) and gin(1)) or (pin(3) and pin(2) and pin(1) and gin(0));

end rtl;
