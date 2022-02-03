-- Some portions of this code are based on code from the book "Digital Design and Computer Architecture" by Harris and Harris.
-- For educational purposes in TU Dortmund only.

library ieee;
use ieee.std_logic_1164.all;

entity mips is
  port(
    clk: in std_logic;
    reset: in std_logic;
    pc: buffer std_logic_vector(31 downto 0);
    instr: buffer std_logic_vector(31 downto 0);
    readdata: buffer std_logic_vector(31 downto 0);
    aluout: buffer std_logic_vector(31 downto 0);
    writedata: buffer std_logic_vector(31 downto 0);
    memwrite: buffer std_logic
  );
end;

architecture structure of mips is
  component controller
  port(
    op: in std_logic_vector(5 downto 0);
    funct: in std_logic_vector(5 downto 0);
    zero: in std_logic;
    memtoreg: out std_logic;
    memwrite: buffer std_logic;
    pcsrc: out std_logic;
    alusrc: out std_logic;
    regdst: out std_logic;
    regwrite: out std_logic;
    jump: out std_logic;
    alucontrol: out std_logic_vector(2 downto 0)
  );
  end component;

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
      readdata: buffer std_logic_vector(31 downto 0);
      instr: buffer std_logic_vector(31 downto 0);
      zero: out std_logic;
      pc: buffer std_logic_vector(31 downto 0);
      aluout: buffer std_logic_vector(31 downto 0);
      writedata: buffer std_logic_vector(31 downto 0)
    );
  end component;
  
  
 -- MIPS Extended
	-- Data Memory
   component datamem
		port (
			clk: in STD_LOGIC;
			we: buffer STD_LOGIC;
			aluout, writedata: buffer STD_LOGIC_VECTOR (31 downto 0);
			readdata: buffer STD_LOGIC_VECTOR (31 downto 0)
		);
	end component;
	
	-- Instruction Memory
	component instructmem
		port (
			readAddress : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			instruction : buffer STD_LOGIC_VECTOR (31 DOWNTO 0)
		);
	end component;
  
  

  signal memtoreg, alusrc, regdst, regwrite, jump, pcsrc: std_logic;
  signal zero: std_logic;
  signal alucontrol: std_logic_vector(2 downto 0);
begin
  mips_control: controller port map(
    instr(31 downto 26),
    instr(5 downto 0),
    zero,
    memtoreg,
    memwrite,
    pcsrc,
    alusrc,
    regdst,
    regwrite,
    jump,
    alucontrol
    );
  mips_datapath: datapath port map(
    clk,
    reset,
    memtoreg,
    pcsrc,
    alusrc,
    regdst,
    regwrite,
    jump,
    alucontrol,
    readdata,
    instr,
    zero,
    pc,
    aluout,
    writedata
  );
  -- MIPS Extended
  mips_datamem: datamem port map(
    clk,
    memwrite,
	aluout,
	writedata,
	readdata
  );  
  
  mips_instructmem: instructmem port map(
    pc,
    instr
  );  
  
end;
