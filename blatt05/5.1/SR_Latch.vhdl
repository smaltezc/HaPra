library ieee;
use ieee.std_logic_1164.all;

entity SR_Latch is
    port (
      S,R : in std_logic; --0 1
      Q,not_Q : out std_logic -- 0 1
    );
  end SR_Latch;

architecture Behavioral of SR_Latch is

--missing
	signal outQ, out_notQ, prev_Q, prev_not_Q, prevS, prevR : std_logic;
	
begin
	
	process(S,R)
	begin
		prev_Q <= R nand prev_not_Q;
		prev_not_Q <= S nand prev_Q;
		
		if (S = '1' and R = '1') then
			outQ <= prevR nand prev_not_Q;
			out_notQ <= prevS nand prev_Q;
		elsif (S = '0' and R = '1') then
			outQ <= '0';
			out_notQ <= '1';
			prevR <= R;
			prevS <= S;
		elsif (S = '1' and R = '0') then
			outQ <= '1';
			out_notQ <= '0';
			prevR <= R;
			prevS <= S;
		elsif (S = '0' and R = '0') then
			outQ <= '1';
			out_notQ <= '1';
			prevR <= R;
			prevS <= S;
		end if;
		
	end process;
	
	Q <= outQ;
	not_Q <= out_notQ;
	

end Behavioral;
