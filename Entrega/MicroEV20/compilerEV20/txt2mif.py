from dictNemonics import nem2binDict

def discardComments(nemLine):
    uncommented = nemLine.split("//")[0]
    print(uncommented)
    return uncommented
def nem2binFun(nemLines):   
    binLines = []
    for i in range(len(nemLines)):
        #print(i)
        uncommentedLine = discardComments(nemLines[i])
        j = -1
        lineSplitted = uncommentedLine.split()
        print(lineSplitted)
        print(len(lineSplitted))
        if len(lineSplitted) > 0:  #ignore enter
            
            if lineSplitted[0] in nem2binDict:
                binLines.append(nem2binDict[lineSplitted[0]][1](nem2binDict, lineSplitted))
                j = j + 1
                if binLines[j] == -1:
                    return [-1, "Error en la línea " + str(i)]
            else:
                return [-1, "Error en la línea " + str(i)]
    
    
    ##if for loop is done with success, all the nemLines were decoded correctly... so return binLines...
    return binLines

def generateMifList(binLines):
    mifList = []
    #preamble...
    mifList.append("DEPTH = " + str(len(binLines) + 1) + ";\n")  #The size of memory in words
    mifList.append("WIDTH = 22;\n")                     #The size of data in bits
    mifList.append("ADDRESS_RADIX = HEX;\n")           #The radix for address values
    mifList.append("DATA_RADIX = BIN;\n")              #The radix for data values
    mifList.append("CONTENT\n")                        #start of (address : data pairs)
    mifList.append("BEGIN\n")                          #
    mifList.append("\n")

    #-- memory address : data
    lastDIR = 0
    for i in range(len(binLines)):
        mifList.append("{0:0>4X}".format(i) + " : " + binLines[i] + ";\n")
        lastDIR = i

    #FINISH
    lastINSTRUCCION = nem2binDict["JMP"][1](nem2binDict, ["JMP", str(lastDIR + 1)])
    mifList.append("{0:0>4X}".format(lastDIR + 1) + " : " + lastINSTRUCCION + ";\n")
    mifList.append("END;")
    print(mifList)
    return mifList

nemFileName = "nemsE5.txt"
nemFileMode = 'r'

nemFile = open(nemFileName, nemFileMode)

if nemFile.mode == 'r':
    nemLines = nemFile.readlines()

    binLines = nem2binFun(nemLines)
    
nemFile.close()

if binLines[0] == -1:
    print(binLines[1])

else:
    print(binLines)

memoryFileName = "instructionData.mif"
memoryFileMode = 'w'

memoryFile = open(memoryFileName, memoryFileMode)

memoryFile.writelines(generateMifList(binLines))

memoryFile.close()


#def nem2binFun(nemLines):
    #AGARRO LINEA POR LINEA:
    #ME FIJO SI LA PRIMER PALABRA DE LA LINEA ESTA EN EL DICCIONARIO DE NEMONICOS (SI ES ASI, SIGO, SINO TIRO ERROR EN NUMERO DE LINEA)
    #PARSEO LA LINEA SEGUN EL CALLBACK DE PARSEO QUE ME INDICA EL DICCIONARIO. 
#    return 0

#def generateMemoryFile(binLines):

    #ESCRIBO PREAMBULO
    #VOY ESCRIBIENDO LINEA POR LINEA, LLEVANDO UN CONTADOR QUUE SE TRADUCE EN EL ADRESS DE LA MEMORIA.