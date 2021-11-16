LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY function_41 IS
    PORT (
--missing
		abc : in std_logic_vector(2 downto 0);
		y : out std_logic_vector(2 downto 0)
    );
END function_41;

ARCHITECTURE rtl OF function_41 IS

    component mux41 is 
        PORT (
		i1 : IN std_logic_vector(2 DOWNTO 0); 
        i2 : IN std_logic_vector(2 DOWNTO 0);
        i3 : IN std_logic_vector(2 DOWNTO 0);
        i4 : IN std_logic_vector(2 DOWNTO 0);
        sel : IN std_logic_vector(1 DOWNTO 0); 
        y : OUT std_logic_vector(2 DOWNTO 0)
		);
    end component mux41;
	
	signal ab:std_logic_vector(1 DOWNTO 0);
    signal c : std_logic_vector(2 DOWNTO 0);

begin
--missing
	ab(0) <= abc(1);
	ab(1) <= abc(2);
	-- c = abc(0)
	c <= "000" when abc="100" else
	     "001" when abc="101";

	-- nach Schaltbild
	mux_result: mux41 port map(i1 => "000", i2 => "000", i3 => c, i4 => abc,
									sel => ab, y => y);
end rtl;