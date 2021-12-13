library ieee;
use ieee.std_logic_1164.all;

entity ms_ff is
    port (
      d, clk: in std_logic; -- 0 1
      Q, not_Q : out std_logic
    );
  end ms_ff;

architecture behavioral of ms_ff is

--missing
	component D_Latch
		port(
			d, clk : in std_logic;
			Q, not_Q : out std_logic
		);
	end component;
--missing

	signal Qm , Dm, Qs, Ds, notQ , in_clk, empty : std_logic;

begin

--missing
	-- 0
	--in_clk <= not clk;
							--     0         0             u            u
	--MLatch : D_Latch port map(d => d, clk => in_clk , Q => Qm, not_Q => empty );
	--                             u          1 
	--SLatch : D_Latch port map(d => Qm, clk => clk, Q => Qs, not_Q => not_Q);
	
	
	--process(clk)
	--begin
	--	if(rising_edge(clk)) then
			
	--		Q <= d; 
	--	else
	--		Q <= Qs;
	--	end if;
		
	--end process;
	
	process (clk, d)
	begin
		if(clk'event and clk='1') then
			Q <= d;
			not_Q <= (not d);
		end if;
	end process;
	

end behavioral ;