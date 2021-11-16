import sys
import subprocess

def func(strng, last):
    # "strng" hat die Dateiennamen vollstaendig
    optns_list = ['-s', '-a', '-e', '-r'] # Liste der Befehle
    check_list = ['Syntax-check', 'Analysis', 'Build', 'VCD-Dump'] # Liste der Befehlsnamen
 
    withoutDot = strng.replace('.', ' ') # Dateiennamen werden ohne "." gespeichert              
    part = withoutDot.split(" ") # Dateien werden von " " gesplitet und in einer Liste gespeichert
            
    partWithoutVhdl = []   
    for pt in part: #  Dateiennamen werden ohne "vhdl" gespeichert  
        if pt == "":
            continue
        if pt == "vhdl":
            continue    
        partWithoutVhdl.append(pt) 
 
    for i in range(4): 
        if i < 2: # Für die Befehle -s , -a
            p = subprocess.run(f"ghdl {optns_list[i]} {strng}", stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            if p.returncode == 0: # Ueberpruefung der Prozesse, ob sie funktionieren
                print(check_list[i] + ' OK')
            else:
                print(check_list[i] + ' Failed')
                sys.exit(0)
                
        else:     # Für die Befehle -e , -r 
            if i == 2: # Für der Befehl -e
                for x in partWithoutVhdl:
                    p = subprocess.run(f"ghdl {optns_list[i]} {x}")               
                
            else: # Für der Befehl -r
                for x in partWithoutVhdl:
                    p = subprocess.run(f"ghdl {optns_list[i]} {x} --vcd={last}") 
                    
            if p.returncode == 0: # Ueberpruefung der Prozesse, ob sie funktionieren
                print(check_list[i] + ' OK')
            else:
                print(check_list[i] + ' Failed')
                sys.exit(0) 
   
    print('Starting GTKWave') # GTKWave Prozess
    p5 = subprocess.run(f"gtkwave {last}", stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    if p5.returncode != 0: # Ueberpruefung des GTKWave Prozesses
        print('Starting GTKWave Failed')
        sys.exit(0)   
    
input_list = sys.argv #  eine Liste der übergebenen Quellcode-Dateien

s =''
for strng in input_list:
    if strng == input_list[0]: # Skript-Datei wird nicht betrachtet
        continue
    last = input_list[len(input_list)-1] # die Testbench-Datei wird immer als letztes übergeben 
    if strng == input_list[len(input_list)-1]: # die Testbench-Datei wird nicht betrachtet
        continue
    s += strng + ' '  # um die VHDL-Dateien zu haben 
func(s, last)    