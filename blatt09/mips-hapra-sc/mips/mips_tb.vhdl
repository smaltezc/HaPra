library ieee;
use ieee.std_logic_1164.all;

entity mips_tb is
  end mips_tb;
  
architecture testbench of mips_tb is

 constant half_period  : time    := 5 ns; -- for clock

	component mips
	   port(
		clk: in std_logic;
		reset: in std_logic;
		pc: buffer std_logic_vector(31 downto 0);
		instr: in std_logic_vector(31 downto 0);
		readdata: in std_logic_vector(31 downto 0);
		aluout: buffer std_logic_vector(31 downto 0);
		writedata: buffer std_logic_vector(31 downto 0);
		memwrite: out std_logic
		);
	end component;
	
	signal clk, finished : std_logic := '0';
	signal pc, readdata, aluout, writedata : std_logic_vector(31 downto 0);
	signal memwrite : std_logic;
	signal reset : std_logic:= '1'; -- für beq
	signal instr : std_logic_vector(31 downto 0) ;
begin
  
	mips1: mips port map(clk => clk, reset => reset, pc => pc, instr => instr, 
		 					readdata => readdata, aluout => aluout, 
							writedata => writedata, memwrite => memwrite); 


	clk <= not clk after half_period when finished /= '1' else '0'; -- for clock
    process begin
		--regwrite <= '1';
		--jump <= '1'; -- 
		reset <= '0'; -- Jz wird beq korrekt ausgefuehrt.
		--              |---||---||---|
		instr <= "10001100000000100000000000000000" ; -- 00000 00010 00000 lw
		--memtoreg <= '1';
		readdata <= "00000000000000000000000000000011"; -- 3
        wait for 10 ns;
		--              |---||---||---|
		instr <= "10001100000001100000000000000000"; -- 00000 00110 00000
		
        readdata <= "00000000000000000000000000000111"; -- 7
		wait for 10 ns;
		--              |---||---||---|
		instr <= "00000000010001100000000000000000";
		wait for 10 ns; -- bis hier 9.2.2.d.1
		--alucontrol <= "010";
		--memtoreg <= '0';
		--              |---||---||---|
		instr <= "00000000010001100011100000100000";
		--regdst <= '1';
		wait for 10 ns;
		--              |---||---||---|
		instr <= "00000000111000000000000000000000";
		wait for 10 ns; -- bis hier 9.2.2.d.2
		instr <= "00001000111000000000000000000000"; -- jump
		wait for 10 ns;
		finished <= '1';
		
        wait;
    end process;
   
end testbench;