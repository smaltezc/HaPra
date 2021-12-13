library ieee;
use ieee.std_logic_1164.all;

entity SIPO is
    port (
      d: in std_logic; 
	  clk, reset: in std_logic;
      Q : inout	std_logic_vector(7 downto 0) -- gleichzeitig input und output
    );
  end SIPO;
  
architecture behavioral of SIPO is

begin 
	-- wir sind von der wahrheitstabelle in Datei text.pdf ausgegangen.
	process (clk)
	begin
		if reset = '1' then -- für reset
			Q <= "00000000";
		
		elsif (CLK'event and CLK='1') then -- für Clocks
			Q(7 downto 1) <= Q(6 downto 0); -- hier wird mit 'u' gefüllt
			
			for i in 0 to 7 loop 
				if(Q(i) = 'U') then 
					Q(i) <= '0' ; -- 0 ersetzen statt U
				end if;
				
			end loop;
			Q(0) <= d; -- Input wird hier gefügt
			
			
		end if;
	end process;
	
end behavioral;