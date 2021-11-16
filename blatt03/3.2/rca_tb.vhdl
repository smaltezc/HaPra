library ieee;
use ieee.std_logic_1164.all;

entity rca_tb is
end rca_tb;

architecture test of rca_tb is
  component rca
      port (
		a : in std_logic_vector(7 downto 0);
		b : in std_logic_vector(7 downto 0);
		--s : in std_logic; -- select
		
		sum : out std_logic_vector(7 downto 0);
		cout: out std_logic
      );
  end component;
  
	signal a : std_logic_vector(7 downto 0);
	signal b : std_logic_vector(7 downto 0);
	signal cout : std_logic;
	signal sum : std_logic_vector(7 downto 0);
  begin
  
  uut:rca port map (
		a => a,
		b => b,
		--s => s,
		sum => sum,
		cout => cout
	);
    
   process 
   begin
   a<="00001111";
   b<="00001111";
   --s <= '0';
   wait for 10 ns;
   
   a<="00000011";
   b<="00001001";
   --s <= '1';
   wait for 10 ns;
   a<="01000010";
   b<="10010001";
   --s <= '0';
   wait for 10 ns;
   
   a<="10000010";
   b<="10000001";
   --s <= '1';
   wait for 10 ns;
   wait;
  end process;
  
 
 end test;