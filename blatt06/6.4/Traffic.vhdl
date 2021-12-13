library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity Traffic is
	port(
    Clk         : in std_logic;
	t        	: in std_logic; -- timer
    reset        : in std_logic; 
    red_a1_a3    : out std_logic;
    yellow_a1_a3 : out std_logic;
    green_a1_a3  : out std_logic;
    red_a2_a4     : out std_logic;
    yellow_a2_a4  : out std_logic;
    green_a2_a4   : out std_logic);
end entity;
 
architecture rtl of Traffic is
 
 
    type t_State is (s0, s1, s2, s3, s4, s5, s6, s7);
    signal State : t_State;
 
 
begin
 
    process(Clk) is
    begin
        if rising_edge(Clk) then
            if reset = '1' then
                -- Reset values
                State   <= s0;
                --t <= '0';
                red_a1_a3    <= '1';
                yellow_a1_a3 <= '0';
                green_a1_a3  <= '0';
				
                red_a2_a4     <= '1';
                yellow_a2_a4  <= '0';
                green_a2_a4   <= '0';
 
            else
                -- Default values
                red_a1_a3    <= '0';
                yellow_a1_a3 <= '0';
                green_a1_a3  <= '0';
				
                red_a2_a4     <= '0';
                yellow_a2_a4  <= '0';
                green_a2_a4   <= '0';
 
                --t <= '1';
 
                case State is
 
                    -- Red in all directions
                    when s0 =>
                        red_a1_a3 <= '1';
                        red_a2_a4  <= '1';
                        
                        if t = '1' then
                            State   <= s1;
                        end if;
 
                    -- Red and yellow in s2/south direction
                    when s1 =>
                        red_a1_a3    <= '1';
                        yellow_a1_a3 <= '1';
                        red_a2_a4     <= '1';
                      
                        if t = '0' then
                            State   <= s2;
                        end if;
 
                    -- Green in s2/south direction
                    when s2 =>
                        green_a1_a3 <= '1';
                        red_a2_a4    <= '1';
             
                        if t = '0'  then
                            State   <= s3;
                        end if;
 
                    -- Yellow in s2/south direction
                    when s3 =>
                        yellow_a1_a3 <= '1';
                        red_a2_a4     <= '1';
                    
                        if t = '0'  then
                            State   <= s4;
                        end if;
 
                    -- Red in all directions
                    when s4 =>
                        red_a1_a3 <= '1';
                        red_a2_a4  <= '1';
              
                        if t = '0' then
                            State   <= s5;
                        end if;
 
                    -- Red and yellow in s6/east direction
                    when s5 =>
                        red_a1_a3   <= '1';
                        red_a2_a4    <= '1';
                        yellow_a2_a4 <= '1';
                    
                        if t = '0' then
                            State   <= s6;
                        end if;
 
                    -- Green in s6/east direction
                    when s6 =>
                        red_a1_a3  <= '1';
                        green_a2_a4 <= '1';
                       
                        if t = '0' then
                            State   <= s7;
                        end if;
 
                    -- Yellow in s6/east direction
                    when s7 =>
                        red_a1_a3   <= '1';
                        yellow_a2_a4 <= '1';
                      
                        if t = '0'  then
                            State   <= s0;
                        end if;
 
                end case;
 
            end if;
        end if;
    end process;
 
end architecture;