library ieee;
use ieee.std_logic_1164.all;

entity cla is
  port (
    a : in std_logic_vector(3 downto 0);
    b : in std_logic_vector(3 downto 0);
    cin : in std_logic;
    cout : out std_logic;
    sum : out std_logic_vector(3 downto 0)
  );
end cla;

architecture behavioral of cla is
 
	component clag
		Port ( 
			gin : in std_logic_vector(3 downto 0);
			pin : in std_logic_vector(3 downto 0);
			cin : in std_logic;
			cout : out std_logic_vector(3 downto 0);
			pout : out std_logic;
			gout : out std_logic
		);
	end component;
	
	component facla
		port (
			a : in std_logic;
			b : in std_logic;
			cin : in std_logic;
			g : out std_logic;
			p : out std_logic;
			sum : out std_logic
		);
	end component;
 
	--signal c1,c2,c3: std_logic;
	signal coco: std_logic_vector(3 downto 0);
	signal pout, gout: std_logic_vector(3 downto 0);
	signal pol, gol : std_logic;
begin
	
	PFA1: facla port map( a => a(0), b => b(0), cin => cin, g => gout(0), p => pout(0), sum => sum(0));
	PFA2: facla port map( a => a(1), b => b(1), cin => coco(0), g => gout(1), p => pout(1), sum => sum(1));
	PFA3: facla port map( a => a(2), b => b(2), cin => coco(1), g => gout(2), p => pout(2), sum => sum(2));
	PFA4: facla port map( a => a(3), b => b(3), cin => coco(2), g => gout(3), p => pout(3), sum => sum(3));

	uut : clag port map(gin => gout, pin => pout, cin => cin, cout => coco, pout => pol, gout => gol); 

	--clag_assignment : for i in 0 to 3 generate
		
	--	uut : clag port map(gin => gout(i), pin => pout(i), cin => cin, cout => coco(i), pout => pol, gout => gol); 
    
	--end generate clag_assignment;
	
	cout <= coco(3);

end behavioral;
