# iz datoteke učitaj 2 rijetke matrice
# ispisi umnozak u punom obliku
# pohrani ga u drugu datoteku u rijetkom obliku
import sys

retci1 = 0;
stupci1 = 0;
retci2 = 0;
stupci2 = 0;
matrix1 = {};
matrix2 = {};
matrix_res = {}


def matrix_input(file, matrix, retci, stupci, flag):
    # ways to skip until first row?!

    r = open(file)
    newLine = 0
    # dva slucaja
    ##prvi slucaj - zastavica 0 ==>ucitavaj do novog reda, na novom redu breakaj
    ##drugi slucaj - zastavica 1 ==> continue sve do novog reda
    if (flag == 0):
        for line in r:
            if line == '\n':
                break
            entry = line.rstrip("\n").split(" ")
            if (retci == 0 and stupci == 0):
                retci = int(entry[0])
                stupci = int(entry[1])
                continue
            key = (int(entry[0]), int(entry[1]))
            matrix[key] = float(entry[2])
    else:
        for line in r:
            if line != '\n' and newLine == 0:
                continue
            if line == '\n':
                newLine = 1
                continue
            entry = line.rstrip().split(" ")
            if (retci == 0 and stupci == 0):
                retci = int(entry[0])
                stupci = int(entry[1])
                continue

            key = (int(entry[0]), int(entry[1]))
            matrix[key] = float(entry[2])

    r.close()

    return retci, stupci

def provjera(input_matrix1, input_matrix2,
             retci_input1, stupci_input1, retci_input2, stupci_input2):
    if(stupci_input1 != retci_input2):
        print("Dimenzije matrica nisu valjane")
        exit(1)
    #provjera elementa
    #provjera prve matrice
    for key, value in input_matrix1.items():
        if(key[0] > retci_input1 or key[1] > stupci_input1):
            print("Neispravan unos elemenata"
                  "u prvoj matrici")
            exit(1)
    #provjera druge matrice
    for key, value in input_matrix2.items():
        if(key[0] > retci_input2 or key[1] > stupci_input2):
            print("Neispravan unos elemenata"
                  "u drugoj matrici")
            exit(1)



#inputoutputfilenames
file_input = sys.argv[1]
file_output = sys.argv[2]

retci1, stupci1 = matrix_input(file_input, matrix1, retci1, stupci1, 0)
retci2, stupci2 = matrix_input(file_input, matrix2, retci2, stupci2, 1)

provjera(matrix1, matrix2, retci1, stupci1, retci2, stupci2)

# iterate through rows of X
for i in range(1, retci1 + 1):
    # iterate through columns of Y
    for j in range(1, stupci2 + 1):
        # iterate through rows of Y
        for k in range(1, retci2 + 1):
            try:
                X = matrix1.get((i,k), 0)
            except KeyError:
                X = 0
            try:
                Y = matrix1.get((k, j), 0)
            except KeyError:
                Y = 0
            key = (i, j)
            matrix_res[key] = matrix_res.get(key, 0) + (X * Y)

dat = open(file_output, 'w', encoding = 'utf8')
toWrite = ' '.join(map(str,[retci1, stupci2, "\n"]))
dat.write(toWrite)

#ispis u potpunom obliku
#zapis u drugu datoteku sa stdin u rijetkom obliku
for i in range(1, retci1 + 1):
    for j in range(1, stupci2 + 1):
        print(matrix_res[i,j], end = " ")
        if(matrix_res[i, j] != 0):
            toWrite = ' '.join(map(str, [i, j, matrix_res[i, j]]))
            toWrite = toWrite + '\n'
            dat.write(toWrite)
    #dat
    print("\n")

dat.close()


