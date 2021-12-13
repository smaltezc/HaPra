library ieee;
use ieee.std_logic_1164.all;

entity ff_reset is
    port (
      d, clk, reset: in std_logic;
      Q, not_Q : out std_logic
    );
  end ff_reset;

architecture behavioral of ff_reset is

--missing

--missing

begin

--missing

	process (clk,d,reset)
    begin
		if(reset='1') then
			Q <='0';
			not_Q <='0';
		elsif(clk'event and clk='1') then
			Q <= d;
			not_Q <= not d;
		end  if;
     end process;

end behavioral ;