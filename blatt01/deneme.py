import sys
import subprocess

n = len(sys.argv)

if n <= 2:
    print("Failed")
else:
    vhdlArguments = sys.argv.copy()
    vhdlArguments.pop(n-1)
    vhdlArguments.pop(0)
    
    p = subprocess.run(["ghdl", "-s"] + vhdlArguments, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    if p.returncode != 0:
        print("Syntax-check Failed")
    else:
        print("Syntax-check OK")
        
        p = subprocess.run(["ghdl", "-a"] + vhdlArguments, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        if p.returncode != 0:
            print("Analysis Failed")
        else:
            print("Analysis OK")
            
            #BUILD
            vhdlArgumentShortend = [] # without .vhdl
            for x in vhdlArguments:
                x = x.rstrip('.vhdl')
                vhdlArgumentShortend.append(x)
                
            buildFailed = False 
            for x in vhdlArgumentShortend:
                p = subprocess.run(["ghdl", "-e", x], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
                if p.returncode != 0:
                    buildFailed = True
            
            if buildFailed == True:
                print("Build Failed")
            else:
                print("Build OK")
                
                #VCD-Dump
                testbenchString = "--vcd=" + sys.argv[n-1]
                vcdFailed = False
                for x in vhdlArgumentShortend:
                    p = subprocess.run(["ghdl", "-r", x, testbenchString])
                    if p.returncode != 0:
                        vcdFailed = True
                        
                if buildFailed == True:
                    print("VCD-Dump Failed")
                else:
                    print("VCD-Dump OK")      
                    #print(p.stderr)
                    
                    #GTKWave
                    print('Starting GTKWave', end="", flush=True)
                    ps = subprocess.run(["gtkwave", sys.argv[n-1]], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
                    if ps.returncode != 0:
                        print("Failed")