library ieee;
use ieee.std_logic_1164.all;

entity regfile_tb is
  end regfile_tb;
  
architecture testbench of regfile_tb is

 constant half_period  : time    := 5 ns; -- for clock

	component regfile
		port (
		clk: in std_logic;
		we3: in std_logic;
		a1: in std_logic_vector(4 downto 0);
		a2: in std_logic_vector(4 downto 0);
		a3: in std_logic_vector(4 downto 0);
		wd3: in std_logic_vector(31 downto 0);
		rd1: buffer std_logic_vector(31 downto 0);
		rd2: buffer std_logic_vector(31 downto 0)
		);
	end component;
	
	signal clk, finished : std_logic := '0';
	signal a1, a2, a3 : std_logic_vector(4 downto 0);
	signal wd3, rd1, rd2 : std_logic_vector(31 downto 0);
	signal we3 : std_logic;
	
	
begin
  
	regfile1: regfile port map(clk => clk, we3 => we3, a1 => a1, a2 => a2, a3 => a3,
								wd3 => wd3, rd1 => rd1, rd2 => rd2); 


	clk <= not clk after half_period when finished /= '1' else '0'; -- for clock
    process begin
		we3 <= '1';
		wd3 <= "00000000000000000000000001010000";
		a3 <= "00100";
        wait for 10 ns;
		we3 <= '1';
		wd3 <= "00000000011000010000000001010000";
		a3 <= "00010";
        wait for 10 ns;
		a1 <= "00100";
		a2 <= "00010";
		wait for 10 ns;
		finished <= '1';
		
        wait;
    end process;
   
end testbench;