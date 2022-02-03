library ieee;
use ieee.std_logic_1164.all;
USE IEEE.NUMERIC_STD.ALL;

entity instructmem_tb is
  end instructmem_tb;
  
architecture testbench of instructmem_tb is

	component instructmem
		PORT (
			readAddress : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			instruction : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
		);
	end component;
	
	signal readAddress: std_logic_vector(31 downto 0) := x"003fffff";
	signal  instruction : std_logic_vector(31 downto 0);
	
begin
  
	instructmem1: instructmem port map(readAddress => readAddress, instruction => instruction); 


    process begin
		readAddress <= x"00400000"; 
        wait for 10 ns;
		readAddress <= x"00400004"; 
		wait for 10 ns;
		readAddress <= x"00400008"; 
		wait for 10 ns;
		readAddress <= x"0040000C"; 
		wait for 10 ns;
        wait;
    end process;
   
end testbench;