library ieee;
use ieee.std_logic_1164.all;

entity datapath_tb is
  end datapath_tb;
  
architecture testbench of datapath_tb is

 constant half_period  : time    := 5 ns; -- for clock

	component datapath
	  port(
		clk: in std_logic;
		reset: in std_logic;
		memtoreg: std_logic;
		pcsrc: std_logic;
		alusrc: in std_logic;
		regdst: in std_logic;
		regwrite: in std_logic;
		jump: in std_logic;
		alucontrol: in std_logic_vector(2 downto 0);
		readdata: in std_logic_vector(31 downto 0);
		instr: in std_logic_vector(31 downto 0);
		zero: out std_logic;
		pc: buffer std_logic_vector(31 downto 0);
		aluout: buffer std_logic_vector(31 downto 0);
		writedata: buffer std_logic_vector(31 downto 0)
	  );
	end component;
	
	signal clk, finished : std_logic := '0';
	signal alucontrol : std_logic_vector(2 downto 0);
	signal readdata, instr, pc, aluout, writedata : std_logic_vector(31 downto 0);
	signal memtoreg, pcsrc, alusrc, regdst, regwrite, jump, zero : std_logic;
	signal reset : std_logic := '1'; -- für beq
	
begin
  
	datapath1: datapath port map(clk => clk, reset => reset, memtoreg => memtoreg, 
							pcsrc => pcsrc, alusrc => alusrc, regdst => regdst,
							regwrite => regwrite, jump => jump, alucontrol => alucontrol,
							readdata => readdata, instr => instr, zero => zero,
							pc => pc, aluout => aluout, writedata => writedata); 


	clk <= not clk after half_period when finished /= '1' else '0'; -- for clock
    process begin
		regwrite <= '1';
		jump <= '1'; -- Jz wird jump korrekt ausgefuehrt.
		reset <= '0'; -- Jz wird beq korrekt ausgefuehrt.
		--              |---||---||---|
		instr <= "00000000000000100000000000000000"; -- 00000 00010 00000
		memtoreg <= '1';
		readdata <= "00000000000000000000000000000011"; -- 3
        wait for 10 ns;
		--              |---||---||---|
		instr <= "00000000000001100000000000000000"; -- 00000 00110 00000
		
        readdata <= "00000000000000000000000000000111"; -- 7
		wait for 10 ns;
		--              |---||---||---|
		instr <= "00000000010001100000000000000000";
		wait for 10 ns; -- bis hier 9.2.1.a
		alucontrol <= "010";
		memtoreg <= '0';
		--              |---||---||---|
		instr <= "00000000010001100011100000000000";
		regdst <= '1';
		wait for 10 ns;
		--              |---||---||---|
		instr <= "00000000111000000000000000000000";
		wait for 10 ns; -- bis hier 9.2.1.b
		--              |---||---||---|
		instr <= "00000000111000010000000000000101"; -- 5
		alusrc <= '1';
		regdst <= '0';
		wait for 10 ns;
		--              |---||---||---|
		instr <= "00000000001000000000000000000000";
		wait for 10 ns; -- bis hier 9.2.1.c
		finished <= '1';
		
        wait;
    end process;
   
end testbench;