import sys
import re
import json

REGDICT = {}
INSTRUCTION_DICT = {}
OUTPUT_FILE = open("output", "w")

def two_comp(num,nbits):
    '''
    gives nbit long two complement representation of number
    '''
    if num>=0:
        return f"{num:0{nbits}b}"
    else:
        return f"{((1<<nbits)+num):0{nbits}b}"

def spit_line(line):
    try:
        print("[DEBUG]", line)
        #print("[**DEBUG]", opc)
        opcode=INSTRUCTION_DICT[line[0]][0]
        opc=int(opcode, 2)
        opcode=two_comp(opc,4)
        print("[**DEBUG] opcode ", opcode)
        print("[<DEBUG>]", opc)
        if opc==1:
            if len(line)!=3:
                print(f"error in line {line}")
                return
            else:
                rs=f"{REGDICT[line[1]]:06b}"
                rt=f"{0:06b}"
                print("[REGS INIT]")
                print("[REGS] rs: ", rs, " rt: ", rt)
                shamt=f"{0:05b}"
                funct=f"{INSTRUCTION_DICT[line[0]][-1]}"
                funct_int=int(funct,2)
                print("[SHAMT FUNCT_INIT]")
                if funct_int==4 or funct_int==5 or funct_int==8:
                    print("[SHAMT_LOG]")
                    shamt=f"{int(line[2]):05b}"
                    print("[SHAMT_LOG]")
                else:
                    rt=f"{REGDICT[line[2]]:06b}"
                print(f"{opcode}{rs}{rt}{shamt}{funct},", file = OUTPUT_FILE)    
        elif opc==2 or opc==3:
            if len(line)!=3:
                print(f"error in line {line}")
            else:
                rs=f"{REGDICT[line[1]]:06b}"
                imm_dec=int(line[2])
                print("[REGS] rs: ", rs)
                print("[IMM] ", imm_dec)
                imm=two_comp(imm_dec,22)
                print(f"{opcode}{rs}{imm},", file = OUTPUT_FILE)
        elif opc==4 or opc==5:
            if len(line)!=4:
                print(f"error in line {line}")
            else:
                rt=f"{REGDICT[line[1]]:06b}"
                rs=f"{REGDICT[line[-1]]:06b}"
                imm_dec=int(line[2])
                imm=two_comp(imm_dec,16)
                print(f"{opcode}{rs}{rt}{imm},", file = OUTPUT_FILE)
        elif opc==6 or opc==11 or opc==12 or opc==13:
            if len(line)!=2:
                print(f"error in line {line}")
                return
            else:
                addr=f"{int(line[1]):028b}"
                print("[ADDR] ", addr)
                print(f"{opcode}{addr},", file = OUTPUT_FILE)          
        elif opc==7:
            if len(line)<2:
                print(f"error in line {line}")
                return
            else:
                addr=f"{0:028b}"
                print("[ADDR] ", addr)
                print(f"{opcode}{addr},", file = OUTPUT_FILE)
        elif opc==8 or opc==9 or opc==10:
            if len(line)<2:
                print(f"error in line {line}")
                return
            else:
                rs=f"{REGDICT[line[1]]:06b}"
                addr=f"{int(line[2]):022b}"
                print("[ADDR] ", addr)
                print(f"{opcode}{rs}{addr},", file = OUTPUT_FILE)
        elif opc==14:
            if len(line)!=3:
                print(f"error in line {line}")
                return
            else:
                rs=f"{REGDICT[line[1]]:06b}"
                rt=f"{REGDICT[line[2]]:06b}"
                print("[REGS INIT DIFF]")
                print("[REGS] rs: ", rs, " rt: ", rt)
                shamt=f"{0:05b}"
                funct=f"{0:011b}"
                print(f"{opcode}{rs}{rt}{shamt}{funct},", file = OUTPUT_FILE)
    except:
        print(f"EError in line {line}")


def bin_comm(string):
    string = re.sub(re.compile("/'''.*?\'''", re.DOTALL), "", string)
    string = re.sub(re.compile("#.*?\n"), "", string)
    return string


def process(filename):
    print("memory_initialization_radix=2;", file = OUTPUT_FILE)
    print("memory_initialization_vector=", file = OUTPUT_FILE)
    #print(f"{0:032b},", file = OUTPUT_FILE)
    with open(filename, 'r') as f:
        print(f"{0:032b},", file = OUTPUT_FILE)
        print(f"{0:032b},", file = OUTPUT_FILE)
        lines = f.readlines()
        for line in lines:
            line.strip()
            line = bin_comm(line)
            
            line = line.replace(',',' ').replace(')',' ').replace('(',' ').split()
            if len(line):
                spit_line(line)
    print(f"{0:032b};", file = OUTPUT_FILE)

if __name__ == '__main__':
    with open('instruc.json', 'r') as f:
        INSTRUCTION_DICT = json.load(f)
    with open('registers.json', 'r') as f:
        REGDICT = json.load(f)
    process(sys.argv[1])
