from dictNemonics import nem2binDict

def nem2binFun(nemLines):   ##AUN FALLA SI HAY ENTERSSSS ENTRE LINEAS
    binLines = []
    for i in range(len(nemLines)):
        #print(i)
        lineSplitted = nemLines[i].split()
        if lineSplitted[0] in nem2binDict:
            binLines.append(nem2binDict[lineSplitted[0]][1](nem2binDict, lineSplitted))
            if binLines[i] == -1:
                return [-1, "Error en la línea " + str(i)]
        else:
            return [-1, "Error en la línea " + str(i)]
    ##if for loop is done with success, all the nemLines were decoded correctly... so return binLines...
    return binLines

def generateMifList(binLines):
    mifList = []
    #preamble...
    mifList.append("DEPTH = " + str(len(binLines)) + ";\n")  #The size of memory in words
    mifList.append("WIDTH = 22;\n")                     #The size of data in bits
    mifList.append("ADDRESS_RADIX = HEX;\n")           #The radix for address values
    mifList.append("DATA_RADIX = BIN;\n")              #The radix for data values
    mifList.append("CONTENT\n")                        #start of (address : data pairs)
    mifList.append("BEGIN\n")                          #
    mifList.append("\n")

    #-- memory address : data
    for i in range(len(binLines)):
        mifList.append("{0:0>4X}".format(i) + " : " + binLines[i] + ";\n")

    #FINISH
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