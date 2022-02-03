library ieee;
use ieee.std_logic_1164.all;

entity alu_tb is
  end alu_tb;
  
architecture testbench of alu_tb is

	component alu
		port(
		a: in std_logic_vector(31 downto 0);
		b: in std_logic_vector(31 downto 0);
		alucontrol: in std_logic_vector(2 downto 0);
		result: buffer std_logic_vector(31 downto 0);
		zero: out std_logic
		);
	end component;
	
	signal a, b, result: std_logic_vector(31 downto 0);
	signal alucontrol :  std_logic_vector(2 downto 0);
	signal zero : std_logic;
	
begin
  
	alu1: alu port map(a => a, b => b, alucontrol => alucontrol, result => result, zero => zero); 

    process begin
		alucontrol <= "000"; -- And
		a <= "00000000010100000000000001010000";
		b <= "00000000101101001001010000100000";
        wait for 10 ns;
		alucontrol <= "001"; -- Or
		wait for 10 ns;
		alucontrol <= "010"; -- Addition
        wait for 10 ns;
		alucontrol <= "110"; -- Subtraction
		wait for 10 ns;
		alucontrol <= "111"; -- 111
        wait for 10 ns;
		
        wait;
    end process;
   
end testbench;