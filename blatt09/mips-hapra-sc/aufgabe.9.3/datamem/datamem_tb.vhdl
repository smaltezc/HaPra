library ieee;
use ieee.std_logic_1164.all;
USE IEEE.NUMERIC_STD.ALL;

entity datamem_tb is
  end datamem_tb;
  
architecture testbench of datamem_tb is

 constant half_period  : time    := 5 ns; -- for clock

	component datamem
		port (clk, memwrite: in STD_LOGIC;
			aluout, writedata: in STD_LOGIC_VECTOR (31 downto 0);
			readdata: out STD_LOGIC_VECTOR (31 downto 0)
		);
	end component;
	
	signal clk, finished : std_logic := '0';
	signal aluout, writedata, readdata: std_logic_vector(31 downto 0);
	signal memwrite : std_logic;
	
begin
  
	datamem1: datamem port map(clk => clk, aluout => aluout, writedata => writedata,
								readdata => readdata, memwrite => memwrite); 

	clk <= not clk after half_period when finished /= '1' else '0'; -- for clock

    process begin
		aluout   <= x"10010000"; -- address
		writedata <= x"11112222";
		memwrite  <= '1';
		wait for 10 ns;
		memwrite <= '0';
		wait for 10 ns;
		aluout   <= x"10010004";
		writedata <= x"33334444";
		memwrite  <= '1';
		wait for 10 ns;
		memwrite <= '0';
		wait for 10 ns;
		-- read two memory locations
		aluout <= x"10010000";
		wait for 10 ns;
		aluout <= x"10010004";
		wait for 10 ns;
		finished <= '1';
		wait;
    end process;
   
end testbench;