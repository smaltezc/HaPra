library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity mult_add_shift is
  port (
    x,y : in std_logic_vector(3 downto 0);
	z : out std_logic_vector(7 downto 0)
  );
end mult_add_shift;

architecture rtl of mult_add_shift is
	

begin
	
	process(x,y)
	variable multiplicand, LSB: std_logic_vector(7 downto 0);
	variable product: std_logic_vector(7 downto 0);
    variable add_to_product: std_logic_vector(7 downto 0);
	begin
	
	
	product 	 := "00000000";
	LSB 		 := "0000" & y; -- multiplier 
	multiplicand := "0000" & x;

	
		for i in 0 to 3 loop -- bits of Multiplier(y): 4
			if(LSB(0) = '1') then -- if LSB of Multiplier is 1, then update add_to_product 
				--add_to_product <= multiplicand;
				add_to_product := multiplicand;
			else				  -- otherwise add_to_product is unchanged
				--add_to_product <= "00000000";
				add_to_product := "00000000";
			end if;
			-- Arithmetich Addition
			product := std_logic_vector(unsigned(product) + unsigned(add_to_product));	
			
			multiplicand := multiplicand(6 downto 0) & '0'; -- left shift multiplicand
			LSB := '0' & LSB(7 downto 1); -- right shift LSB(multiplier)
		end loop;
	
		z <= product;
	end process;

end rtl;