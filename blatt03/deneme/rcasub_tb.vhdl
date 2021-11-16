--please note that you will have to compile all files in this path including twoc for this to work
-- to choose whether it's a subtraction or an addition choose Zero for addition or One for subtraction
-- with simple logic i can say that A-B is equal to A+(-B)
--i'll be using two's complement
library ieee;
use ieee.std_logic_1164.all;

entity rcasub_tb is
end rcasub_tb;

architecture test of rcasub_tb is
  component rcasub
      port (
    a : in std_logic_vector(7 downto 0);
    b : in std_logic_vector(7 downto 0);
	
    sum : out std_logic_vector(7 downto 0);
	cout: out std_logic
      );
  end component;
  
  component twoc
  port(
	din : in std_logic_vector(7 downto 0);
	decider:in bit;-- this one will decide it's an addition or a subtraction, if 0 addition if 1 subtraction
	dout : out std_logic_vector(7 downto 0)
 );
   
  end component;
  
  signal a, b,bneg,sum : std_logic_vector(7 downto 0);
  signal cin,cout :std_logic;
  signal decider: Bit;
  begin
  
  U0:twoc port map (din=>b,decider=>decider,dout=>bneg);
  
  U1:rcasub port map(a => a, b => bneg, cin=>cin,sum=>sum,cout=>cout);
  
   process begin
   a<="00000010";
   b<="00000001";
   cin<='0';
   decider<='0';
   
   wait for 10 ns;
   
   a<="00000010";
   b<="00000001";
   cin<='0';
   decider<='1';
   wait for 10 ns;
   
   
    wait;
  end process;
  
  
  
  
  
  end test;