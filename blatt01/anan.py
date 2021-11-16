import sys
import subprocess



def func(strng, last):
    
    optns_list = ['-s', '-a', '-e', '-r']
    check_list = ['Syntax-check', 'Analysis', 'Build', 'VCD-Dump']
    
    for i in range(4): 
        if i < 2:
            p = subprocess.run(f"ghdl {optns_list[i]} {strng}")
            if p.returncode == 0:
                print(check_list[i] + ' OK')
            else:
                print(check_list[i] + ' Failed')
                sys.exit(0)
        else:       
            part = strng.split(".") # ohne .vhdl 
            if i == 2:
                p = subprocess.run(f"ghdl {optns_list[i]} {part[0]}")
            else:
                p = subprocess.run(f"ghdl {optns_list[i]} {part[0]} --vcd={last}")
            if p.returncode == 0:
                print(check_list[i] + ' OK')
            else:
                print(check_list[i] + ' Failed')
                sys.exit(0) 
    '''    
    
    p1 = subprocess.run(f"ghdl -s {strng}")
    if p1.returncode == 0:
        print('Syntax-check OK')
    else:
        print('Syntax-check Failed')
        sys.exit(0)
        
    p2 = subprocess.run(f"ghdl -a {strng}")
    if p2.returncode == 0:
        print('Analyse OK')
    else:
        print('Analyse Failed')
        sys.exit(0)
    
    part = strng.split(".") # ohne .vhdl 
    p3 = subprocess.run(f"ghdl -e {part[0]}")
    if p3.returncode == 0:
        print('Build OK')
    else:
        print('Build Failed')
        sys.exit(0)    

    p4 = subprocess.run(f"ghdl -r {part[0]} --vcd={last}")
    if p4.returncode == 0:
        print('VCD-Dump OK')
    else:
        print('VCD-Dump Failed')
        sys.exit(0)   
    '''    

    print('Starting GTKWave')
    p5 = subprocess.run(f"gtkwave {last}", stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    if p5.returncode != 0:
        print('Starting GTKWave Failed')
        sys.exit(0)   
    
    print()
    
input_list = sys.argv

for strng in input_list:
    if strng == input_list[0]:
        continue
    last = input_list[len(input_list)-1]
    if strng == input_list[len(input_list)-1]:
        continue
    func(strng, last)
    
