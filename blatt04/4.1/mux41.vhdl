LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
--the 4:1 multiplexer to be designed consists of four 3-bit inputs, i.e., i1, i2, i3 and i4.
--sel is a 2-bit select signal.
--y is the output
ENTITY mux41 IS
    PORT (
        i1 : IN std_logic_vector(2 DOWNTO 0); 
        i2 : IN std_logic_vector(2 DOWNTO 0);
        i3 : IN std_logic_vector(2 DOWNTO 0);
        i4 : IN std_logic_vector(2 DOWNTO 0);
        sel : IN std_logic_vector(1 DOWNTO 0); 
        y : OUT std_logic_vector(2 DOWNTO 0)
        );
END mux41;

ARCHITECTURE rtl OF mux41 IS
--you can add more components you need
--you can also increase the number of inputs, e.g., the "and" gate blow is extended to a 3-input gate.

    COMPONENT andgate IS
        PORT (input1 : IN std_logic;
            input2 : IN std_logic;
			input3 : IN std_logic;
            and_result : OUT std_logic);
    END COMPONENT;
	
	COMPONENT notgate IS
        PORT (input1 : IN std_logic;
            not_result : OUT std_logic);
    END COMPONENT;
	
	COMPONENT orgate IS
        PORT (input1 : IN std_logic;
			input2 : in std_logic;
			input3 : in std_logic;
			input4 : in std_logic;
            or_result : OUT std_logic);
    END COMPONENT;
	


--you can define more signals here if you need, e.g.,:
    signal not_sel : std_logic_vector(1 DOWNTO 0); 
	
	signal and_out1 : std_logic_vector(2 DOWNTO 0); 
	signal and_out2 : std_logic_vector(2 DOWNTO 0); 
	signal and_out3 : std_logic_vector(2 DOWNTO 0); 
	signal and_out4 : std_logic_vector(2 DOWNTO 0); 
	
	signal or_out : std_logic_vector(2 DOWNTO 0); 

BEGIN
	-- Select with Notgate 														-- 10 
	not_output1: notgate port map(input1 => sel(0), not_result => not_sel(0));  -- 
	not_output2: notgate port map(input1 => sel(1), not_result => not_sel(1));  -- 
																				-- 01

--bitwise operation for each logic gate because the input signals are multilple-bit signals.
--please complete the implementation based on the schema you designed.

	-- andgate
    and_gate_assignment : for i in 0 to 2 generate 
										--     000                1                      0                         000
        and_result1: andgate port map(input1 => i1(i), input2 => not_sel(0), input3 => not_sel(1), and_result => and_out1(i)); --
										--     001                0                      0                         000
        and_result2: andgate port map(input1 => i2(i), input2 => sel(0), input3 => not_sel(1), and_result => and_out2(i));
										--     010                1                      1                		   010 
        and_result3: andgate port map(input1 => i3(i), input2 => not_sel(0), input3 => sel(1), and_result => and_out3(i));
										--     011                0                      1                		   000
        and_result4: andgate port map(input1 => i4(i), input2 => sel(0), input3 => sel(1), and_result => and_out4(i));
    end generate and_gate_assignment;
	
	
	-- orgate
	or_gate_assignment : for i in 0 to 2 generate
									  --       000						000						010						000						010
        or_result1: orgate port map(input1 => and_out1(i), input2 => and_out2(i), input3 => and_out3(i), input4 => and_out4(i), or_result => or_out(i)); 
    end generate or_gate_assignment;
	
	y <= or_out; --missing
END rtl;