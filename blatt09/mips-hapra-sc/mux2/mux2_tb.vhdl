library ieee;
use ieee.std_logic_1164.all;

entity mux2_tb is
  end mux2_tb;
  
architecture testbench of mux2_tb is
	
	component mux2
		generic(w: integer := 8);
		port(
		d0: in std_logic_vector(w-1 downto 0);
		d1: in std_logic_vector(w-1 downto 0);
		s: in std_logic;
		y: out std_logic_vector(w-1 downto 0)
		);
	end component;
	
	signal d0, d1, y: std_logic_vector(7 downto 0);
	signal s : std_logic;
	
begin
  
	mux21: mux2 port map(d0 => d0, d1 => d1, s => s, y => y); 

    process begin
		d0 <= "00000000";
		d1 <= "01001000";
		s  <= '1';
        wait for 10 ns;
		s  <= '0';
        wait for 10 ns;
        wait;
    end process;
   
end testbench;