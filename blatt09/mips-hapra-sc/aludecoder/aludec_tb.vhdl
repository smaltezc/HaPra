library ieee;
use ieee.std_logic_1164.all;

entity aludec_tb is
  end aludec_tb;
  
architecture testbench of aludec_tb is

	component aludec
		port(
		funct: in std_logic_vector(5 downto 0);
		aluop: in std_logic_vector(1 downto 0);
		alucontrol: out std_logic_vector(2 downto 0)
		);
	end component;
	
	signal funct : std_logic_vector(5 downto 0);
	signal aluop : std_logic_vector(1 downto 0);
	signal alucontrol : std_logic_vector(2 downto 0);
	
	
begin
  
	aludec1: aludec port map(funct => funct, aluop => aluop, alucontrol => alucontrol); 

    process begin
		aluop <= "00"; -- add
        wait for 10 ns; -- sub
		aluop <= "01";
        wait for 10 ns;
		aluop <= "11";
		funct <= "100000"; -- add
		wait for 10 ns;
		funct <= "100010"; -- sub
		wait for 10 ns;
		funct <= "100100"; -- and
		wait for 10 ns;
		funct <= "100101"; -- or
		wait for 10 ns;
		funct <= "101010"; -- slt
		wait for 10 ns;
		funct <= "111111"; -- wrong entry
		wait for 10 ns;
        wait;
    end process;
   
end testbench;