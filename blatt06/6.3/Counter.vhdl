library ieee;
use ieee.std_logic_1164.all; 

entity Counter is
	port(
		clk, reset : in std_logic;
		count, down : in std_logic;
	    Q : out std_logic_vector(1 downto 0)
	);
end Counter;

architecture arch of Counter is 

	component jk_ff
		 port( 
		 J,K: in  std_logic;
         Reset: in std_logic;
         Clock_enable: in std_logic;
         Clock: in std_logic;
         Output: out std_logic
		 );
	end component;

    type stateMealy_type is (s0, s1, s2, s3); -- 4 states are required for Mealy
    signal current_state, next_state : stateMealy_type;
    
	signal J0, J1, K0, K1 : std_logic;
	
	signal q_n, next_q_n : std_logic_vector(1 downto 0);
	
begin   

		J1 <= q_n(1) xor next_q_n(1);
		K1 <= q_n(1) xor next_q_n(1);
	
		J0 <= q_n(0) xor next_q_n(0);
		K0 <= q_n(0) xor next_q_n(0);

	--JK flip flop
    jk_ff0 : jk_ff port map(J => J0, K => K0, Reset => reset, Clock_enable => '1', 
								Clock => clk, Output => q_n(0) );
	
	jk_ff1 : jk_ff port map(J => q_n(0), K => q_n(0), Reset => reset, Clock_enable => '1', 
								Clock => clk, Output => q_n(1) );

	Q <= q_n;
    -- Mealy Design
    process(current_state, count, down)
    begin 
        if count='1' then
			case current_state is 
				when s0 =>  
					--q_n <= "00";
					if down = '0' then 
						next_state <= s1; 
						next_q_n <= "01";
					else
						next_state <= s3;
						next_q_n <= "11";
					end if; 
				when s1 => 
					--q_n <= "01";		
					if down = '0' then 
						next_q_n <= "10";
						next_state <= s2; 
					else
						next_q_n <= "00";
						next_state <= s0;
					end if;
				when s2 =>
					--q_n <= "10";
					if down = '0' then 
						next_q_n <= "11";
						next_state <= s3; 
					else
						next_q_n <= "01";
						next_state <= s1;
					end if;
				when s3 =>  
					--q_n <= "11";
					if down = '0' then 
						next_q_n <= "00";
						next_state <= s0; 
					else
						next_q_n <= "10";
						next_state <= s2;
					end if;
			
			end case; 
		else
            null;
        end if;
		
    end process;
	    	
  
end arch; 