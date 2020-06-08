def validRegister(rx):
    if (int(rx) < 28) and int(rx >= 0):
        return True
    else:
        return False

def validPort(px):
    if (int(px) < 2) and int(px >= 0):
        return True
    else:
        return False

def validConst(c):
    if (int(c) < (2**16)) and int((c) >= (-1 * ((2**15) - 1))):
        return True
    else:
        return False

def jump(dict, lineSplitted):

    if len(lineSplitted) == 2:
        opcode = lineSplitted[0]
        operand = lineSplitted[1]
        binNemonic = dict[opcode][0] + int(operand)
        return "{0:0022b}".format(binNemonic)
    elif (len(lineSplitted) == 1) and (lineSplitted[0] == "END"):
        return -1
    else:
        return -1

def simpleParser(dict, lineSplitted):

    if len(lineSplitted) == 2:
        opcode = lineSplitted[0]
        operand = lineSplitted[1]
        if ((opcode == "CPL") and (operand == "W")) or ((opcode == "CLR") and (operand == "CY")) or ((opcode == "SET") and (operand == "CY")):
            binNemonic = dict[opcode][0]
        
    elif lineSplitted[0] == "RET":
        binNemonic = dict[lineSplitted[0]][0]
    else:
        
        return -1
    print(binNemonic)
    return "{0:0022b}".format(binNemonic)

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

    return "{0:0022b}".format(operand + opcode)

def rirj(opcode_, ri_, rj_):
    ri = int(ri_)
    rj = int(rj_) 
    operand = rj + (ri<<5)
    if not (validRegister(ri) and validRegister(rj)):
        return -1

    return "{0:022b}".format(operand + opcode_)

def poirj(opcode_, poi_, rj_):
    poi = int(poi_)
    rj = int(rj_)
    if not (validPort(poi) and validRegister(rj)):
        return -1
    operand = rj + ((30 + poi) << 5)
    return "{0:022b}".format(operand + opcode_)

def ripij(opcode_, ri_, pij_):
    pij = int(pij_)
    ri = int(ri_)
    if not (validPort(pij) and validRegister(ri)):
        return -1
    operand = (ri << 5) + (28 + pij)
    return "{0:022b}".format(operand + opcode_)

def poipij(opcode_, poi_, pij_):
    poi = int(poi_)
    pij = int(pij_)
    if not (validPort(pij) and validPort(poi)):
        return -1
    operand = ((30 + poi)<<5) + (28 + pij)
    return "{0:022b}".format(operand + opcode_)

def riFromW(opcode_, ri_):
    ri = int(ri_)
    if not validRegister(ri):
        return -1

    operand = (ri << 5)
    return "{0:022b}".format(operand + (opcode_ >> 1) + opcode_)

def rjToW(opcode_, rj_):
    rj = int(rj_)
    if not validRegister(rj):
        return -1

    operand = rj
    return "{0:022b}".format(operand + (opcode_ >> 2))

def pijtoW(opcode_, pij_):
    pij = int(pij_)
    if not validPort(pij):
        return -1

    operand = pij + 28
    return "{0:022b}".format(operand + (opcode_ >> 2))


def poiFromW(opcode_, poi_):
    poi = int(poi_)
    if not validPort(poi):
        return -1
    operand = (32 << 5) + ((poi + 30) << 5)
    return "{0:022b}".format(operand + (opcode_ >> 1) + opcode_)

def constW(opcode_, c_):
    c = int(c_)
    if not validConst(c):
        return -1
    operand = c
    return "{0:022b}".format(operand + opcode_)


def genericComaSeparated(dict, lineSplitted):
    aux = []
    if len(lineSplitted) == 2:
        aux = lineSplitted[1].split(',', 2)
        opcode = dict[lineSplitted[0]][0]
        if len(aux) == 2:

            if (len(aux[0]) > 1) and (len(aux[1]) > 1) and (aux[0][0] == 'R') and (aux[1][0] == 'R'):

                return rirj(opcode, aux[0][1:], aux[1][1:])

            elif (len(aux[0]) > 2) and (len(aux[1]) > 1) and (aux[0][0:2] == 'PO') and (aux[1][0] == 'R'):

                return poirj(opcode, aux[0][2], aux[1][1:])

            elif (len(aux[0]) > 1) and (len(aux[1]) > 2) and (aux[0][0] == 'R') and (aux[1][0:2] == 'PI'):
                
                return ripij(opcode, aux[0][1:], aux[1][2])

            elif (len(aux[0]) > 2) and (len(aux[1]) > 2) and (aux[0][0:2] == 'PO') and (aux[1][0:2] == 'PI'):

                return poipij(opcode, aux[0][2], aux[1][2])

            elif (len(aux[0]) > 1) and (len(aux[1]) > 0) and (aux[0][0] == 'R') and (aux[1][0] == 'W'):

                return riFromW(opcode, aux[0][1:])

            elif (len(aux[0]) > 0) and (len(aux[1]) > 1) and (aux[0][0] == 'W') and (aux[1][0] == 'R'):

                return rjToW(opcode, aux[1][1:])

            elif (len(aux[0]) > 0) and (len(aux[1]) > 2) and (aux[0][0] == 'W') and (aux[1][0:2] == 'PI'):

                return pijtoW(opcode, aux[1][2])
            
            elif (len(aux[0]) > 2) and (len(aux[1]) > 0) and (aux[0][0:2] == 'PO') and (aux[1][0] == 'W'):

                return poiFromW(opcode, aux[0][2])

            elif (len(aux[0]) > 0) and (len(aux[1]) > 1) and (aux[0][0] == 'W') and (aux[1][0] == '#'):

                return constW(opcode, aux[1][1:])
            else:
                return -1

            
        else:
            return -1 
    else:
        return -1



nem2binDict = {"JMP":[0x200000, jump], 
                "JZE":[0x280000, jump], 
                "JNE":[0x300000, jump], 
                "JCY":[0x380000, jump], 
                "MOM":[0x100000, moveToFromMemory],
                "ADW":[0x180000, genericComaSeparated],
                "BSR":[0x1C0000, jump],
                "MOV":[0x080000, genericComaSeparated],
                "MOK":[0x040000, genericComaSeparated],
                "ANK":[0x050000, genericComaSeparated],
                "ORK":[0x060000, genericComaSeparated],
                "ADK":[0x070000, genericComaSeparated],
                "ANR":[0x0A0000, genericComaSeparated],
                "ORR":[0x0B0000, genericComaSeparated],
                "ADR":[0x0E0000, genericComaSeparated],
                "CPL":[0x000000, simpleParser],
                "CLR":[0x008000, simpleParser],
                "SET":[0x010000, simpleParser],
                "RET":[0x018000, simpleParser],
                "END":[0x200000, jump]}


