library ieee;
use ieee.std_logic_1164.all;

entity D_Latch is
    port(
        d, clk : in std_logic;
        Q, not_Q : out std_logic
    );
end D_Latch;

architecture Behavioral of D_Latch is
    
--missing
	component SR_Latch
		port (
		  S,R : in std_logic; 
		  Q,not_Q : out std_logic 
		);
	end component;

	signal R_out_dlatch, S_out_dlatch, outQ, out_notQ : std_logic;

begin

--missing
	
	R_out_dlatch <= clk nand (not d);
	S_out_dlatch <= clk nand d;
	
	srlatch: SR_Latch port map(S => S_out_dlatch, R => R_out_dlatch, Q => Q, not_Q => not_Q);   

	--outQ <= R_out_dlatch nor out_notQ;
	--out_notQ <= S_out_dlatch nor outQ;
	
	--Q <= outQ;
	--not_Q <= out_notQ;

end Behavioral;