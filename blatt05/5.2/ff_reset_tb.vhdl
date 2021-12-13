library ieee;
use ieee.std_logic_1164.all;

entity ff_reset_tb is
end ff_reset_tb;

architecture testbench of ff_reset_tb is

--missing
	component ff_reset
		port (
		d, clk, reset: in std_logic;
		Q, not_Q : out std_logic
		);
	end component;


	signal d, clk, reset, Q, not_Q : std_logic;

begin
   
--missing
	ff: ff_reset port map(d => d, clk => clk, reset => reset, Q => Q, not_Q => not_Q); 

    process begin
		reset <= '0';
        clk <= '1';
        d <= '0';
        wait for 10 ns;
		reset <= '1';
        clk <= '0';
        d <= '0';
        wait for 10 ns;
		reset <= '0';
        clk <= '1';
        d <= '0';
        wait for 10 ns;
		reset <= '1';
        clk <= '0';
        d <= '1';
        wait for 10 ns;
		reset <= '0';
        clk <= '1';
        d <= '1';
        wait for 10 ns;
		reset <= '1';
		clk <= '0';
        d <= '0';
        wait for 10 ns;
        wait;
    end process;
   
end testbench;