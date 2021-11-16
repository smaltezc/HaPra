library ieee;
use ieee.std_logic_1164.all;

entity function_81_tb is
end function_81_tb;

architecture testbench of function_81_tb is
  component function_81
    port (
		abc : in std_logic_vector(2 downto 0);
		y : out std_logic_vector(2 downto 0)
		);
  end component;


	signal abc : std_logic_vector(2 DOWNTO 0); 
	signal y : std_logic_vector(2 DOWNTO 0);

begin
    func81: function_81 port map(abc => abc, y => y);

    process begin
        abc <= "000";
        wait for 10 ns;
        abc <= "111";
        wait for 10 ns;
        abc <= "110";
        wait for 10 ns;
        abc <= "101";
        wait for 10 ns;
        wait;
    end process;
end testbench;