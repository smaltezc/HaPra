library ieee;
use ieee.std_logic_1164.all;

entity PISO_tb is
  end PISO_tb;
  
architecture testbench of PISO_tb is

	component PISO
		 port (
		  d: in std_logic_vector(7 downto 0);
		  clk, reset: in std_logic;
		  Q : out	std_logic 
    );
	end component;
	
	signal Q, clk: std_logic;
	signal d : std_logic_vector(7 downto 0); 
	
begin
  
	piso1: PISO port map(d => d, clk => clk, reset => '0', Q => Q); 

    process begin
		d <= "00001011";
        clk <= '0';
        wait for 10 ns;
		d <= "00001011";
        clk <= '1'; -- 1.Clock
        wait for 10 ns;
		d <= "00000101";
        clk <= '0';
        wait for 10 ns;
		d <= "00000101";
        clk <= '1';	-- 2.Clock
        wait for 10 ns;
		d <= "00000010";
        clk <= '0';	
        wait for 10 ns;
		d <= "00000010";
		clk <= '1';	-- 3.Clock
        wait for 10 ns;
		d <= "00000001";
		clk <= '0';	
        wait for 10 ns;
		d <= "00000001";
		clk <= '1';	-- 4.Clock
        wait for 10 ns;
		
		
        wait;
    end process;
   
end testbench;