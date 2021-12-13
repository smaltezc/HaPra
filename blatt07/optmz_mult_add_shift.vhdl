library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity optmz_mult_add_shift is
  port (
    x,y : in std_logic_vector(3 downto 0);
	z : out std_logic_vector(7 downto 0)
  );
end optmz_mult_add_shift;

architecture rtl of optmz_mult_add_shift is
	

begin
	
	process(x,y)
	variable multiplicand : std_logic_vector(3 downto 0);
	variable product: std_logic_vector(7 downto 0);
    variable add_to_product: std_logic_vector(7 downto 0);
	begin
	
	
	product 	 := "0000" & y; -- multiplier 
	multiplicand := x;
	
		for i in 0 to 3 loop -- bits of Multiplier(y): 4
			if(product(0) = '1') then -- if LSB of Product is 1, then update add_to_product 
				--add_to_product <= multiplicand;
				add_to_product := multiplicand & "0000";
				product := std_logic_vector(unsigned(product) + unsigned(add_to_product));	
				product := '0' & product(7 downto 1); -- right shift product
			else
				product := '0' & product(7 downto 1); -- right shift product
			end if;
			
		end loop;
	
		z <= product;
	end process;

end rtl;