library ieee;
use ieee.std_logic_1164.all;

entity maindec_tb is
  end maindec_tb;
  
architecture testbench of maindec_tb is

	component maindec
	  port(
		op: in std_logic_vector(5 downto 0);
		memtoreg: out std_logic;
		memwrite: out std_logic;
		branch: out std_logic;
		alusrc: out std_logic;
		regdst: out std_logic;
		regwrite: out std_logic;
		jump: out std_logic;
		aluop: out std_logic_vector(1 downto 0)
	  );
	end component;
	
	signal op : std_logic_vector(5 downto 0);
	signal aluop : std_logic_vector(1 downto 0);
	signal memtoreg, memwrite, branch, alusrc, regdst, regwrite, jump : std_logic;
	
	
begin
  
	maindec1: maindec port map(op => op, memtoreg => memtoreg, memwrite => memwrite, 
						branch => branch, alusrc => alusrc, regdst => regdst, 
						regwrite => regwrite, jump => jump, aluop => aluop); 

    process begin
		op <= "000000"; -- rtype
        wait for 10 ns; 
		op <= "100011"; -- lw
        wait for 10 ns;
		op <= "101011"; -- sw
		wait for 10 ns;
		op <= "000100"; -- beq
		wait for 10 ns;
		op <= "001000"; -- addi
		wait for 10 ns;
		op <= "000010"; -- jump
		wait for 10 ns;
		op <= "111111"; -- illegal
		wait for 10 ns;
        wait;
    end process;
   
end testbench;