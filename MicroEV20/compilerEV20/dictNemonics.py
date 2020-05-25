def validRegister(rx):
    if (int(rx) < 28) and int(rx >= 0):
        return True
    else:
        return False

def jump(dict, lineSplitted):

    if len(lineSplitted) == 2:
        opcode = lineSplitted[0]
        operand = lineSplitted[1]
        binNemonic = dict[opcode][0] + int(operand)
        return "{0:22b}".format(binNemonic)
    else:
        return -1

def moveToFromMemory(dict, lineSplitted):
    cells = []
    operand = 0
    opcode = 0
    if len(lineSplitted) == 2:
        cells = lineSplitted[1].split(',', 2)
        if len(cells) == 2:
            
            if cells[0] == "W": #Means that is from memory to working register 
                operand = 0x40000
                opcode = int(cells[1])
            else:               #Means that is from working register to memory
                opcode = int(cells[0])

            operand = operand + dict[lineSplitted[0]][0]
        else:
            return -1

    else:
        return -1

    return "{0:22b}".format(operand + opcode)

def rirj(dict, lineSplitted):
    regs = []
    ri = 0
    rj = 0
    opcode = 0
    operand = 0
    if len(lineSplitted) == 2:
        regs = lineSplitted[1].split(',', 2)
        opcode = dict[lineSplitted[0]][0]
        if (len(regs) == 2) and (regs[0][0] == 'R') and (regs[1][0] == 'R'):
            #print(regs)
            #print(regs[0][1:])
            ri = int(regs[0][1:])
            rj = int(regs[1][1:]) 
            operand = rj + (ri<<5)
            if not (validRegister(ri) and validRegister(rj)):
                return -1 
        else:
            return -1
    else:
        return -1

    return "{0:22b}".format(operand + opcode)

nem2binDict = {"JMP":[0x200000, jump], 
                "JZE":[0x280000, jump], 
                "JNE":[0x300000, jump], 
                "JCY":[0x380000, jump], 
                "MOM":[0x100000, moveToFromMemory],
                "ADW":[0x180000, rirj]}




#print(jump(nem2binDict, "JMP 10".split()))
#print(len("JMP 10".split()))
