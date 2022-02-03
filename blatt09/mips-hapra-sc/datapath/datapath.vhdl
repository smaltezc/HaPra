-- Some portions of this code are based on code from the book "Digital Design and Computer Architecture" by Harris and Harris.
-- For educational purposes in TU Dortmund only.

library ieee;
use ieee.std_logic_1164.all;

entity datapath is
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
end;

architecture structure of datapath is
  component alu
    port(
      a: in std_logic_vector(31 downto 0);
      b: in std_logic_vector(31 downto 0);
      alucontrol: in std_logic_vector(2 downto 0);
      result: buffer std_logic_vector(31 downto 0);
      zero: out std_logic
    );
    end component;

  component regfile
    port (
      clk: in std_logic;
      we3: in std_logic;
      a1: in std_logic_vector(4 downto 0);
      a2: in std_logic_vector(4 downto 0);
      a3: in std_logic_vector(4 downto 0);
      wd3: in std_logic_vector(31 downto 0);
      rd1: buffer std_logic_vector(31 downto 0);
      rd2: buffer std_logic_vector(31 downto 0)
    );
  end component;

  component adder
    port(
      a: in std_logic_vector(31 downto 0);
      b: in std_logic_vector(31 downto 0);
      y: out std_logic_vector(31 downto 0)
    );
  end component;

  component sl2
    port(
      a: in std_logic_vector(31 downto 0);
      y: out std_logic_vector(31 downto 0)
    );
  end component;

  component signext
    port(
      a: in std_logic_vector(15 downto 0);
      aext: out std_logic_vector(31 downto 0)
    );
  end component;

  component syncresff
    generic(w: integer);
    port(
      clk: in std_logic;
      reset: in std_logic;
      d: in std_logic_vector(w-1 downto 0);
      q: buffer std_logic_vector(w-1 downto 0)
    );
  end component;

  component mux2
    generic(w: integer := 8);
    port(
      d0: in std_logic_vector(w-1 downto 0);
      d1: in std_logic_vector(w-1 downto 0);
      s: in std_logic;
      y: out std_logic_vector(w-1 downto 0)
    );
  end component;

signal writereg: std_logic_vector(4 downto 0);
signal pcjump, pcnext, pcnextbr, pcplus4, pcbranch: std_logic_vector(31 downto 0);
signal signimm, signimmsh: std_logic_vector(31 downto 0);
signal srca, srcb, result: std_logic_vector(31 downto 0);
begin
  -- next pc logic
  pcjump <= pcplus4(31 downto 28) & instr(25 downto 0) & "00";
  -- pc register
  -- [1]
  pcreg: syncresff generic map(32) port map(clk, reset, pcnext, pc);
  -- adder for pc+4
  -- [2]
  pcadd1: adder port map(pc, x"00000004", pcplus4);
  -- shift left2
  -- [3]
  immsh: sl2 port map(signimm, signimmsh);
  -- adder to add immediate to pc+4 as an option for branch
  -- [4]
  pcadd2: adder port map(pcplus4, signimmsh, pcbranch);
  -- mux to chose between branch address or pc+4
  -- [5]
  pcbrmux: mux2 generic map(32) port map(pcplus4, pcbranch,
  pcsrc, pcnextbr);
  -- chose signimmsh+pc+4 or jump address as next pc value
  -- [6]
  pcmux: mux2 generic map(32) port map(pcnextbr, pcjump, jump,
  pcnext);
  -- register file logic
  -- [7]
  rf: regfile port map(clk, regwrite, instr(25 downto 21), instr(20 downto 16), writereg, result, srca, writedata);
  -- mux for deciding into which register (out of the two specified in the instruction) to write
  -- [8]
  wrmux: mux2 generic map(5) port map(instr(20 downto 16),
  instr(15 downto 11), regdst, writereg);
  -- chose to store value from alu or memory to register
  -- [9]
  resmux: mux2 generic map(32) port map(aluout, readdata, memtoreg, result);
  -- sign extender
  -- [10]
  se: signext port map(instr(15 downto 0), signimm);
  -- chose rd2 or sign extended value (add immediate to a register or add two values in registers)
  -- [11]
  srcbmux: mux2 generic map(32) port map(writedata, signimm,
  alusrc, srcb);
  -- alu
  --[12]
  mainalu: alu port map(srca, srcb, alucontrol, aluout, zero);
end;
