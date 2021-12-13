library ieee;
use ieee.std_logic_1164.all;

--Three blocks are provided in this template(block_1, block_2 and block_3), 
--you can complete the design of this multiplier by connecting these blocks,
--or you can also design your own block based on your implementation.

entity parallel_mult is
  port (
    x,y : in std_logic_vector(3 downto 0);
	z : out std_logic_vector(7 downto 0)
  );
end parallel_mult;

architecture rtl of parallel_mult is

	signal wire : std_logic_vector(8 downto 0);
	signal c_out : std_logic_vector(10 downto 0);
	signal z_out : std_logic_vector(7 downto 0);
	
	component block_1
	port (
    andgate_in_1: in std_logic;
    andgate_in_2: in std_logic;
    andgate_out: out std_logic
	);
	end component;
	
    component block_2
	port (
    a,b,c,cin : in std_logic;
    cout,sum : out std_logic
	);
	end component;
    
	component block_3 
	port (
    a,b,c: in std_logic;
    cout,sum: out std_logic
	);
	end component;
	 
begin
	row_0_0 : block_1 port map(andgate_in_1 => x(0), andgate_in_2 => y(0), andgate_out => z_out(0));
    row_0_1 : block_1 port map(andgate_in_1 => x(1), andgate_in_2 => y(0), andgate_out => wire(0));
    row_0_2 : block_1 port map(andgate_in_1 => x(2), andgate_in_2 => y(0), andgate_out => wire(1));
    row_0_3 : block_1 port map(andgate_in_1 => x(3), andgate_in_2 => y(0), andgate_out => wire(2));
	
	row_1_0 : block_3 port map(a => wire(0), b => x(0), c => y(1), cout => c_out(0), sum => z_out(1));
	row_1_1 : block_2 port map(a => wire(1), b => x(1), c => y(1), cin => c_out(0) , cout => c_out(1), sum => wire(3));
	row_1_2 : block_2 port map(a => wire(2), b => x(2), c => y(1), cin => c_out(1) , cout => c_out(2), sum => wire(4));
	row_1_3 : block_3 port map(a => c_out(2), b => x(3), c => y(1), cout => c_out(3), sum => wire(5));
	
	row_2_0 : block_3 port map(a => wire(3), b => x(0), c => y(2), cout => c_out(4), sum => z_out(2));
	row_2_1 : block_2 port map(a => wire(4), b => x(1), c => y(2), cin => c_out(4) , cout => c_out(5), sum => wire(6));
	row_2_2 : block_2 port map(a => wire(5), b => x(2), c => y(2), cin => c_out(5) , cout => c_out(6), sum => wire(7));
	row_2_3 : block_2 port map(a => c_out(3), b => x(3), c => y(2), cin => c_out(6) , cout => c_out(7), sum => wire(8));
	
	row_3_0 : block_3 port map(a => wire(6), b => x(0), c => y(3), cout => c_out(8), sum => z_out(3));
	row_3_1 : block_2 port map(a => wire(7), b => x(1), c => y(3), cin => c_out(8) , cout => c_out(9), sum => z_out(4));
	row_3_2 : block_2 port map(a => wire(8), b => x(2), c => y(3), cin => c_out(9) , cout => c_out(10), sum => z_out(5));
	row_3_3 : block_2 port map(a => c_out(7), b => x(3), c => y(3), cin => c_out(10) , cout => z_out(7), sum => z_out(6));
	
	z(0) <= z_out(0);
	z(1) <= z_out(1);
	z(2) <= z_out(2);
	z(3) <= z_out(3);
	z(4) <= z_out(4);
	z(5) <= z_out(5);
	z(6) <= z_out(6);
	z(7) <= z_out(7);
end rtl;

--first block
library ieee;
use ieee.std_logic_1164.all;

entity block_1 is 
  port (
    andgate_in_1: in std_logic;
    andgate_in_2: in std_logic;
    andgate_out: out std_logic
  );
end block_1;

architecture rtl of block_1 is
begin
	andgate_out <= andgate_in_1 and andgate_in_2;
end rtl;

--second block.
library ieee;
use ieee.std_logic_1164.all;

entity block_2 is
  port (
    a,b,c,cin : in std_logic;
    cout,sum : out std_logic
  );
end block_2;

architecture rtl of block_2 is
  signal d : std_logic;
begin
	d <= b and c;
	cout <= (a and d) or (a and cin) or (d and cin);
	sum <= a xor d xor cin;
end rtl;

--third block.
library ieee;
use ieee.std_logic_1164.all;

entity block_3 is 
  port (
    a,b,c: in std_logic;
    cout,sum: out std_logic
  );
end block_3;

architecture rtl of block_3 is
	signal d : std_logic;
begin
	d <= b and c;
	sum <= a xor d;
	cout <= a and d;
end rtl;
