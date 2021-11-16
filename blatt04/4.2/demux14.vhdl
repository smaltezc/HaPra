LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY demux14 IS
    PORT (
        y0 : IN std_logic_vector(2 DOWNTO 0); 
        sel : IN std_logic_vector(1 DOWNTO 0); 
        i0 : OUT std_logic_vector(2 DOWNTO 0);
        i1 : OUT std_logic_vector(2 DOWNTO 0);
        i2 : OUT std_logic_vector(2 DOWNTO 0);
        i3 : OUT std_logic_vector(2 DOWNTO 0)
        );
END demux14;

ARCHITECTURE rtl OF demux14 IS
--missing
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
	
	signal not_sel : std_logic_vector(1 DOWNTO 0); 
	
	signal and_out0 : std_logic_vector(2 DOWNTO 0); 
	signal and_out1 : std_logic_vector(2 DOWNTO 0); 
	signal and_out2 : std_logic_vector(2 DOWNTO 0); 
	signal and_out3 : std_logic_vector(2 DOWNTO 0); 

BEGIN 
	-- For Complement of sel
	not_output1: notgate port map(input1 => sel(0), not_result => not_sel(0));   
	not_output2: notgate port map(input1 => sel(1), not_result => not_sel(1));
	
	-- For Output
	and_gate_assignment : for i in 0 to 2 generate 
        and_result1: andgate port map(input1 => not_sel(1), input2 => not_sel(0), input3 => y0(i), and_result => i0(i)); 
        and_result2: andgate port map(input1 => not_sel(1), input2 => sel(0), input3 => y0(i), and_result => i1(i));
        and_result3: andgate port map(input1 => sel(1), input2 => not_sel(0), input3 => y0(i), and_result => i2(i));
        and_result4: andgate port map(input1 => sel(1), input2 => sel(0), input3 => y0(i), and_result => i3(i));
    end generate and_gate_assignment;

END rtl;