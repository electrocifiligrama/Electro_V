
def jump(dict, lineSplitted):

    if len(lineSplitted) == 2:
        opcode = lineSplitted[0]
        operand = lineSplitted[1]
        binNemonic = dict[opcode][0] + int(operand)
        return "{0:22b}".format(binNemonic)
    else:
        return -1

nem2binDict = {"JMP":[0x200000, jump], 
                "JZE":[0x280000, jump], 
                "JNE":[0x300000, jump], 
                "JCY":[0x380000, jump]}#, 
                ##"MOM":[0x100000, moveOfMemory]}




#print(jump(nem2binDict, "JMP 10".split()))
#print(len("JMP 10".split()))
