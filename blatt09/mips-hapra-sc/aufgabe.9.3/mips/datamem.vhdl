library IEEE;
use IEEE.STD_LOGIC_1164.all; 
USE IEEE.NUMERIC_STD.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.all; 
--use IEEE.STD_LOGIC_ARITH.all;
entity datamem is -- data memory
	port (clk: in STD_LOGIC;
		we: buffer STD_LOGIC;
		aluout, writedata: buffer STD_LOGIC_VECTOR(31 downto 0);
		readdata: buffer STD_LOGIC_VECTOR(31 downto 0)
	);
end;
architecture behave of datamem is
begin
	process is
	type ramtype is array (63 downto 0) of STD_LOGIC_VECTOR (31 downto 0);
	variable mem: ramtype;
	begin
	-- read or write memory
		loop
			if clk'event and clk = '1' then
				if (we = '1') then 
					mem(to_integer(unsigned(aluout(7 downto 2)))):= writedata;
				end if;
			end if;
			readdata <= mem(to_integer(unsigned(aluout(7 downto 2))));
		wait on clk, aluout;
		end loop;
	end process;
end;