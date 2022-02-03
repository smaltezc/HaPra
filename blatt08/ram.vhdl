---------------------------------------------------------------------------------------
----------------------------------Package Definition-----------------------------------
---------------------------------------------------------------------------------------
-- 1. Please create the package "ram_pack" by completing the following codes.
-- 1. Bitte erstellt ein Package "ram_pack" indem Ihr den folgenden Code vervollständigt.

-- 2. Please check Chapter 4 in the "VHDL script" on Moodle to learn how to create a subtype, 
-- and then complete the subtype "BYTE_4", that consists of 4 BYTE (32 bits).
-- 2. Guckt Euch Kapitel 4 im VHDL Skript im Moodle an. Dort wird subtype erklärt. 
-- Vervollständigt den subtype "BYTE_4" der aus 4 BYTE (32 Bits) besteht.

-- 3. Please check Chapter 4 in the "VHDL script" on Moodle to learn how to create a type, 
-- and then complete the type "SPEICHER_MATRIX", which is the storage units of RAM and 
-- belongs to "BYTE_4".
-- 3. Guckt Euch Kapitel 4 im VHDL Skript im Moodle an. Dort wird type erläutert. 
-- Vervollständigt den type "SPEICHER_MATRIX" der den Speicher des RAM darstellt und zu "BYTE 4" gehört.

package ram_pack is
	subtype BYTE_4 is BIT_VECTOR(0 to 31); --missing
	type SPEICHER_MATRIX is array(INTEGER range <>) of BYTE_4; -- missing
end ram_pack;

---------------------------------------------------------------------------------------
----------------------------------Entity Definition------------------------------------
---------------------------------------------------------------------------------------
-- 1. The way of recalling "ram_pack" is similar to the way of recalling other packages.
-- 1. Das package "ram_pack" wird wie andere packages aufgerufen.

-- 2. "adr_breite" is an adjustable integer, that describes the length of the address,
-- "adr" is the address, "din" is the input, "do" is the output, "read_write" controls 
-- whether signals need to be read or written, the rising edge indicates "read" while the 
-- falling edge indicates "write".
-- 2. Der Integer "adr_breite" ist die Laenge der Addresse, "adr" die Addresse, "din" der Input, 
-- "do" der output und "read_write" bestimmt ob Signale gelesen oder geschrieben werden. Die
-- steigende Flanke fuer "read", die fallende Flanke fuer "write".

use work.ram_pack.ALL; 
entity ram is
	generic (adr_breite : INTEGER :=4); -- Je nach verwendetem script bricht die Kompilierung mit "ghdl-mcode:error: overflow detected" ab wenn hier der Wert nicht bereits gesetzt wird. 
	                                     -- In diesem Fall kann die ram_tb manuell ausgeführt werden. Alternativ kann im Rahmen der Aufgabe hier (adr_breite : INTEGER := 4) verwendet werden.
	port (adr : in BIT_VECTOR (0 to adr_breite-1);
			din : in BYTE_4;
			do : out BYTE_4; 
			read_write : in BIT);
end ram;
architecture ram_behave of ram is

---------------------------------------------------------------------------------------
-----------------------------BitsToInteger Function------------------------------------
---------------------------------------------------------------------------------------
-- 1. You can directly use the function "to_integer", that can convert address fed 
-- as bits into an integer.
-- 1. Die Funktion "to_integer" konvertiert eine in Bit angegebene Adresse in ein Integer.

-- 2. With this converted integer, you can specify the position in SPEICHER_MATRIX 
-- where the data are read or written.
-- 2. Dieses Integer kann die Position in SPEICHER_MATRIX gelesen/geschrieben werden angeben.

function to_integer (constant i : in BIT_VECTOR) return INTEGER is
	-- Funktion: Umwandeln eines Bit-Vektor-Wertes in eine Integer-Zahl
	variable i_tmp : BIT_VECTOR (0 to i'length-1);
	variable int_tmp : INTEGER := 0;	
begin
	i_tmp := i;
	for m in 0 to i'length-1 loop
		if i_tmp(m) = '1' then
			int_tmp := int_tmp + 2**(i'length-1 - m); 
		end if;
	end loop;
	return int_tmp;
end to_integer;

-----------------------------------------------------------------------------------------
-----------------------------Lesezugriff Process-----------------------------------------
-----------------------------------------------------------------------------------------
-- 1. The signal "ram_m" is an instance of SPEICHER_MATRIX.
-- 1. Das Signal "ram_m" ist eine Instanz von SPEICHER_MATRIX.

-- 2. In the "Lesezugriff process", data are extracted from RAM (SPEICHER_MATRIX).
-- 2. Im Prozess "Lesezugriff" werden Daten aus dem RAM gelesen (SPEICHER_MATRIX).

-- 3. In the "Lesezugriff process", we need to check whether the signals satisfy the 
-- requirements (time constraints) in the assignments.
-- 3. Dabei muss ueberprueft werden ob die Signale die zeitlichen Voraussetzungen in aus 
-- der Aufgabenstellung erfuellen.

-- 4. If the above requirements (time constraints) are not satisfied, "Fehler beim Lesen"
-- is reported.
-- 4. Wenn diese nicht erfuellt sind, wird "Fehler beim Lesen" ausgegeben. 

-- 5. The following codes demonstrates how the "Lesezugriff process" works, please read them
-- carefully. 
-- 5. Der nachfolgende Code zeigt wie der "Lesezugriff" process funktioniert. Bitte studiert diesen genau.


	signal ram_m : SPEICHER_MATRIX (0 to (2**adr_breite)-1);
begin
	Lesezugriff: process 
	variable t_read, t_akt : TIME;
	begin
		wait on adr;
		wait for 6 ns; 
		if read_write = '1' then
			do <= ram_m(to_integer(adr));
		end if;
		
		wait for 44 ns; 
		t_read := read_write'last_event; 
		if t_read < 44 ns then
			report "Fehler beim Lesen"
			severity WARNING;
		end if;
	end process;

-----------------------------------------------------------------------------------------
-----------------------------Schreibzugriff Process--------------------------------------
-----------------------------------------------------------------------------------------
-- 1. According to the requirements in the assignment, please complete the "Schreibzugriff" 
-- process where the data are fed into RAM (SPEICHER_MATRIX). 
-- 1. Vervollstaendigt den Prozess "Schreibzugriff" in dem Daten in dem RAM gespeichert werden.
-- Beachtet dabei die Voraussetzungen die auf dem Uebungsblatt angegeben werden.

-- 2. In the "Schreibzugriff process", different time constraints should be satisfied. 
-- E.g., the data input should be shorter than 25ns after the address signal changed, and
-- longer than 20ns before the read_write signal changes from "high" to "low".
-- 2. Im "Schreibzugriff" Prozess muessen verschiedene zeitliche Bedingungen erfuelt werden.
-- Zum Beispiel sollen die Daten weniger als 25ns gehalten werden nachdem das Adresssignal 
-- veraendert wurde und sollten für mindestens 20ns stabil anliegen bevor Read/Write auf 0 sinkt.

-- 3. If the data input is shorter than 20ns before the read_write changes from "high" to "low", please report 
-- "Daten liegen noch nicht lang genug an".
-- 3. Wenn die Daten nicht mindestens 20ns vor dem Wechsel von read_write von "high" nach "low" 
-- anlagen, gebt bitte "Daten liegen noch nicht lang genug an" aus.

-- 4. If the data input is longer than 25ns after the address changed, 
-- please report "Daten lagen nicht schnell genug an".
-- 4. Wenn die Daten mehr als 25ns nach dem Adresswechsel noch anliegen, gebt bitte
-- "Daten lagen nicht schnell genug an" aus.


	Schreibzugriff: process
	-- missing
	variable t0,t1,t2,t4, t5 : TIME;
	begin
	-- missing
		-- Die Funktion "now" gibt die bisher verstrichene Zeit aus.
		wait on adr;
		--wait for 25 ns;
		t0:=now; -- gibt die bis zum Adresswechsel verstrichene Zeit aus.
		wait on din; 
		t1:=now; -- gibt die bis zum Datawechsel verstrichene Zeit aus.
		wait until read_write='0';
		t2:=now;  -- gibt die Zeit aus, die bis read_write=0 verstrichen ist.
		
		t4:=t1-t0; -- 4 in Abbildung 2
		if t4 > 25 ns then
			report "Daten lagen nicht schnell genug an"
			severity WARNING;
		end if;
		
		t5:=t2-t1; -- 5 in Abbildung 2
		if t5 < 20 ns then
			report "Daten liegen noch nicht lang genug an"
			severity WARNING;
		end if;	
		
		if read_write='0' then -- Data(in) schreiben
			ram_m(to_integer(adr)) <= din;
		end if;	
	end process;

-----------------------------------------------------------------------------------------
------------------------Zyklus_Pruefen und Schreibimpulse_Pruefen------------------------
-----------------------------------------------------------------------------------------
-- 1. According to the requirements in the assignment, please complete the "Zyklus_Pruefen" 
-- process and "Schreibimpulse_Pruefen". 
-- 1. Vervollstaendigt die Prozesse "Zyklus_Pruefen" und "Schreibimpulse_Pruefen" mit den
-- auf dem Uebungsblatt beschriebenen Voraussetzungen.

-- 2. In both processes, the time constraints need to be checked.
-- 2. In beiden Prozessen muessen zeitliche Bedingungen erfuelt sein.

-- 3. If the address is not held for 100ns after the address changed, please report 
-- "Zykluszeit wurde nicht eingehalten".
-- 3. Wenn die Adresse nicht mindestens 100ns nachdem sie das letzte Mal veraendert wurde gehalten wird
-- soll "Zykluszeit wurde nicht eingehalten" ausgegeben werden.

-- 4. If the Schreibimpulse (the period where the read_write signal equals "0") is shorter
-- than 15 ns, please report "Schreib-Impuls zu kurz".
-- 4. Wenn der Schreibimpuls (die Zeit die das read_write signal auf "0" steht) kuerzer als
-- 15ns ist soll "Schreib-Impuls zu kurz" ausgegeben werden.

-- 5. If the data input is not stable during Schreibimpulse (data changed), please report 
-- "Daten waren beim Schreiben nicht stabil!".
-- 5. Falls sich die Daten waehrend des Schreibimpulses aendern soll		
-- "Daten waren beim Schreiben nicht stabil!" ausgegeben werden.

	Zyklus_Pruefen: process 
	-- missing
	variable t0, t1, t : TIME;
	begin
	-- missing
		t0 := now; -- gibt die bisher verstrichene Zeit aus.
		wait on adr;
		t1 := now; -- gibt die bis zum Adresswechsel verstrichene Zeit aus.
		t := t1 - t0; -- Zykluszeit
		if t < 100 ns then
			report "Zykluszeit wurde nicht eingehalten"
			severity WARNING;
		end if;
				
	end process;


	Schreibimpulse_Pruefen: process
	-- missing
	variable din_temp : BYTE_4; -- für den Datenvergleich, ob die Daten geändert werden.
	variable t0, t1, t6 : TIME;
	begin
	-- missing
		wait until read_write = '0';
		t0 := now; -- gibt die Zeit aus, die bis read_write=0 verstrichen ist.
		din_temp:=din;
		
		wait until read_write = '1';
		t1 := now; -- gibt die Zeit aus, die bis read_write=1 verstrichen ist.
		
		if din_temp /= din then -- hier wird geprüft, ob die Daten geändert werden.
			report "Daten waren beim Schreiben nicht stabil!"
			severity WARNING;
		end if;  
		t6 := t1 - t0; -- 6 in Abbildung 2
		if t6 < 15 ns then
			report "Schreib-Impuls zu kurz"
			severity WARNING;
		end if;
	end process;
	
end ram_behave;