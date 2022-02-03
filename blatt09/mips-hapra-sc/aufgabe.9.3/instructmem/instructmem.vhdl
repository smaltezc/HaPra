LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY instructmem IS
	PORT (
		readAddress : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		instruction : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
END instructmem;
ARCHITECTURE Behavioral OF instructmem IS
	TYPE RAM_16_x_32 IS ARRAY(0 TO 15) OF std_logic_vector(31 DOWNTO 0);
	SIGNAL IM : RAM_16_x_32 := (
					 -- Adresse		 Inst	Assembly	
		x"8c020050", -- 0x0040 0000: lw 	$2, 80($0)			 
		x"ac670044", -- 0x0040 0004: sw 	$7, 68($3)
		x"1211fffb", -- 0x0040 0008: beq 	$s0, 	$s1, 	$L1		(1210fffb for $s1, $s1)
		x"08100000", -- 0x0040 000C: j 0x00400000 => 0000 1000 0001 0000 0000 0000 0000 (jump to address 0x00400000 (to lw Instruct))
		x"00000000", 
		x"00000000", 
		x"00000000", 
		x"00000000", 
		x"00000000", 
		x"00000000", 
		x"00000000", 
		x"00000000", 
		x"00000000",
		x"00000000",
		x"00000000",
		x"00000000"
	);
BEGIN
	-- Note: 4194304 = 0x0040 0000
	-- reset when address is 003FFFFC else if readAddress is 0040 0000 then reset also
	instruction <= x"00000000" when readAddress = x"003FFFFC" else 
		IM(( to_integer(unsigned(readAddress)) - 4194304) /4); -- IM(4k / 4)
END Behavioral;