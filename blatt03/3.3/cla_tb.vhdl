library ieee;
use ieee.std_logic_1164.all;

entity cla_tb is
end cla_tb;

ARCHITECTURE test OF cla_tb IS

	COMPONENT cla
		PORT(
			a : in std_logic_vector(3 downto 0);
			b : in std_logic_vector(3 downto 0);
			cin : in std_logic;
			cout : out std_logic;
			sum : out std_logic_vector(3 downto 0)
			);
	END COMPONENT;

--Inputs
signal A : std_logic_vector(3 downto 0);
signal B : std_logic_vector(3 downto 0);
signal Cin : std_logic ;--:= '0';

--Outputs
signal S : std_logic_vector(3 downto 0);
signal Cout : std_logic;

BEGIN

 
	uut: cla PORT MAP (
		a => A,
		b => B,
		cin => cin,
		cout => Cout,
		sum => S
		);

	process is 
	begin
		a <= "1101";
		b <= "1011";
		cin <= '0';
		--   11000
		wait for 10 ns;
		a <= "1100";
		b <= "1011";
		cin <= '0';
		wait for 10 ns;
		--   10111
		wait;
	end process;

END test;
