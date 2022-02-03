use work.ram;
use work.ram_pack.all;
	--python script.py ram.vhdl aufgabeD_tb.vhdl tstbnch.vcd
entity aufgabeD_tb is
end aufgabeD_tb;

architecture structure of aufgabeD_tb is 
component ram
	generic (adr_breite:	Integer:=4);
	port (	adr:			in BIT_VECTOR(0 to adr_breite-1); 
			din:			in BYTE_4;
			do: 			out BYTE_4;
			read_write: 			in BIT);
end component;
Signal adresse:		BIT_VECTOR(0 to 3);
signal din,do:		BYTE_4;				  
signal read_write:		BIT:='0'; -- fallende Flanke, also nur schreiben
begin
Testobject: ram
	port map(
		adr		=> adresse,
		din		=> din,
		do		=> do,
		read_write	=> read_write
	);

adresse <= "0000" after 50 ns, "1000" after 100 ns;

din <=	"00000000000000000000000000000001" after 50 ns,
"00000000000000000000000010000001" after 100 ns;


end structure;
