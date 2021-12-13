library ieee;
use ieee.std_logic_1164.all; 

entity Bitmuster is
	port(
		clk, reset : in std_logic;
		d : in std_logic;
	    Y : out std_logic 
	);
end Bitmuster;

architecture arch of Bitmuster is 

    type stateMealy_type is (q0, q1, q2, q3); -- 4 states are required for Mealy
    signal current_state, next_state : stateMealy_type;
    
begin   
	-- flip flop
    process(clk, reset)
    begin
        if (reset = '1') then -- go to state q0 if reset
            
            current_state <= q0;
        elsif (clk'event and clk = '1') then -- otherwise update the states
            -- Robot moves from left to right
            current_state <= next_state;
        else
            null;
        end if; 
    end process;

    -- Mealy Design
    process(current_state, d)
    begin 
        
        case current_state is 
            when q0 =>  -- set 'tick = 1' if state = q0 and d = '1'
                
				if d = '1' then -- if d is 1, then go to state q1,
                    Y <= '0';
					next_state <= q1; -- otherwise remain in q0(same) state.
                else
					Y <= '0';
					next_state <= q0;
                end if; 
            when q1 => 
						
                if d = '0' then  -- if d is 0, then go to q2 state,
                    Y <= '0';
					next_state <= q2; -- otherwise remain in q1(same) state.	
				else
					Y <= '0';
					next_state <= q1;	
				end if;
			when q2 =>  
                
				if d = '1' then  -- if d is 1, then go to q3 state,
                    Y <= '0';
					next_state <= q3;
                else  				-- otherwise go to q0 state.
					Y <= '0'; 
					next_state <= q0;
					--Y <= 'U';
					
				end if;
			when q3 =>  
                
				if d = '1' then  -- if d is 1, then go to q0 state,
                    Y <= '1';
					next_state <= q0;					
					
                else				-- otherwise go to q2 state.
					Y <= '0';
					next_state <= q2;
			
				end if;
				
        end case; 
    end process;
  
end arch; 