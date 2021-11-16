library ieee;
use ieee.std_logic_1164.all;
 
entity ripple_carry_adder_2_FA is
  port (
    i_add_term1  : in std_logic_vector(1 downto 0);
    i_add_term2  : in std_logic_vector(1 downto 0);
    --
    o_result   : out std_logic_vector(2 downto 0)
    );
end ripple_carry_adder_2_FA;
 
 
architecture rtl of ripple_carry_adder_2_FA is
 
  component full_adder is
    port (
      i_bit1  : in  std_logic;
      i_bit2  : in  std_logic;
      i_carry : in  std_logic;
      o_sum   : out std_logic;
      o_carry : out std_logic);
  end component full_adder;
 
  signal w_CARRY : std_logic_vector(2 downto 0);
  signal w_SUM   : std_logic_vector(1 downto 0);
 
   
begin
 
  w_CARRY(0) <= '0';                    -- no carry input on first full adder
   
  FULL_ADDER_1_INST : full_adder
    port map (
      i_bit1  => i_add_term1(0),
      i_bit2  => i_add_term2(0),
      i_carry => w_CARRY(0),
      o_sum   => w_SUM(0),
      o_carry => w_CARRY(1)
      );
 
  FULL_ADDER_2_INST : full_adder
    port map (
      i_bit1  => i_add_term1(1),
      i_bit2  => i_add_term2(1),
      i_carry => w_CARRY(1),
      o_sum   => w_SUM(1),
      o_carry => w_CARRY(2)
      );
   
  o_result <= w_CARRY(2) & w_SUM;  -- VHDL Concatenation
   
end rtl;