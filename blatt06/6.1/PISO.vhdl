library ieee;
use ieee.std_logic_1164.all;

entity PISO is
    port (
      d: in std_logic_vector(7 downto 0);
	  clk, reset: in std_logic;
      Q : out std_logic -- gleichzeitig input und output
    );
  end PISO;
  
architecture behavioral of PISO is

signal d_temp: std_logic_vector(7 downto 0);

begin 
	-- wir sind von der wahrheitstabelle in Datei text.pdf ausgegangen.
	process (clk)
	begin
		if reset = '1' then -- für reset
			Q <= '0';
		
		elsif (CLK'event and CLK='1') then -- für Clocks
			
			Q <= d(0); -- Input wird hier gefügt
			
			
		end if;
	end process;
	
end behavioral;