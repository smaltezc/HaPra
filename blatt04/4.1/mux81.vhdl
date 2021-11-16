LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY mux81 IS
    PORT (
        i1_81 : IN std_logic_vector(2 DOWNTO 0); 
        i2_81 : IN std_logic_vector(2 DOWNTO 0);
        i3_81 : IN std_logic_vector(2 DOWNTO 0);
        i4_81 : IN std_logic_vector(2 DOWNTO 0);
        i5_81 : IN std_logic_vector(2 DOWNTO 0);
        i6_81 : IN std_logic_vector(2 DOWNTO 0);
        i7_81 : IN std_logic_vector(2 DOWNTO 0);
        i8_81 : IN std_logic_vector(2 DOWNTO 0);
        sel_81 : IN std_logic_vector(2 DOWNTO 0); 
        y_81 : OUT std_logic_vector(2 DOWNTO 0));
END mux81;

ARCHITECTURE rtl OF mux81 IS

    COMPONENT mux41 IS
        PORT (
            i1 : IN std_logic_vector(2 DOWNTO 0); 
            i2 : IN std_logic_vector(2 DOWNTO 0);
            i3 : IN std_logic_vector(2 DOWNTO 0);
            i4 : IN std_logic_vector(2 DOWNTO 0);
            sel : IN std_logic_vector(1 DOWNTO 0); 
            y : OUT std_logic_vector(2 DOWNTO 0)
        );
    END COMPONENT;
	
	signal selex : std_logic_vector(1 DOWNTO 0); -- 
	
	signal y0 : std_logic_vector(2 DOWNTO 0); -- for the output of first 4:1 mux
	signal y1 : std_logic_vector(2 DOWNTO 0); -- for the output of second 4:1 mux
	
begin
	selex(0) <= sel_81(0); -- s0 and s1 are sel for mux 4:1
	selex(1) <= sel_81(1); 

	
	-- 2 4:1 mux here
	mux_result0: mux41 port map(i1 => i1_81, i2 => i2_81, i3 => i3_81, i4 => i4_81, sel => selex, y => y0 ); 
	mux_result1: mux41 port map(i1 => i5_81, i2 => i6_81, i3 => i7_81, i4 => i8_81, sel => selex, y => y1 ); 

	
    y_81 <= y0 when sel_81(2) = '0' else -- sel_81(2) is like enable
			y1;

end rtl;