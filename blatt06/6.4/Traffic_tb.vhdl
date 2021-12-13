library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity Traffic_tb is
end entity;
 
architecture sim of Traffic_tb is
 
   constant half_period    : time    := 5 ns; -- for clock

	component Traffic
		 port(
		Clk         : in std_logic;
		t        	: in std_logic; -- timer
		reset        : in std_logic; 
		red_a1_a3    : out std_logic;
		yellow_a1_a3 : out std_logic;
		green_a1_a3  : out std_logic;
		red_a2_a4     : out std_logic;
		yellow_a2_a4  : out std_logic;
		green_a2_a4   : out std_logic
		);
	end component;
 
    signal Clk, finished : std_logic := '0';
    signal reset        : std_logic := '1';
	signal t        : std_logic;
    signal red_a1_a3    : std_logic;
    signal yellow_a1_a3 : std_logic;
    signal green_a1_a3  : std_logic;
    signal red_a2_a4     : std_logic;
    signal yellow_a2_a4  : std_logic;
    signal green_a2_a4   : std_logic;
 
begin
 		
	Traffic1 : Traffic port map (
        Clk         => Clk,
		t 			=> t,
        reset        => reset,
        red_a1_a3    => red_a1_a3,
        yellow_a1_a3 => yellow_a1_a3,
        green_a1_a3  => green_a1_a3,
        red_a2_a4     => red_a2_a4,
        yellow_a2_a4  => yellow_a2_a4,
        green_a2_a4   => green_a2_a4
		);
 
    clk <= not clk after half_period when finished /= '1' else '0'; -- for clock
    process begin
		t <= '1';
		reset <= '0';
        wait for 10 ns;
		t <= '0';
		reset <= '0';
		wait for 10 ns;
        t <= '0';
		reset <= '0';
        wait for 10 ns;
		t <= '0';
		reset <= '0';
        wait for 10 ns;
		t <= '0';
		reset <= '0';
        wait for 10 ns;
		t <= '0';
		reset <= '0';
        wait for 10 ns;
		t <= '0';
		reset <= '0';	
        wait for 10 ns;
		t <= '0';
		reset <= '0';
        wait for 10 ns;
		finished <= '1';
		
        wait;
    end process;
 
end architecture;