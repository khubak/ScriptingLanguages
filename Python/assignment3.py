import os
import sys

studenti = []
studenti_dict = {}

script_file = sys.argv[0].split("/")

file1 = "studenti.txt"
r = open(file1)

for line in r:
    entry = line.rstrip().split(" ")
    imeprez = entry[2] + ', ' + entry[1]
    studenti.append((entry[0], imeprez))

for student in studenti:
    studenti_dict[student[0]] = []
    studenti_dict[student[0]].append(student[1])

datoteke = os.listdir(".")
pronaden = 0

for datoteka in datoteke:
    r = open(datoteka)
    if(datoteka == file1 or datoteka == script_file[-1]):
        continue
    labos = datoteka.split("Lab")
    labos = labos[1].split("_")
    grupa = int(labos[0])
    for line in r:
        line = line.rstrip().split(" ")
        #line[0] jmbag, line[1] broj bodova
        dict_key = line[0]
        broj_bodova = line[1]
        pair = (grupa, broj_bodova)

        for k,v in studenti_dict.items():
            if(k == dict_key):
                for entry in v:
                    if(entry[0] == pair[0]):
                        print("Duplikat! JMBAG, bodovi, grupa: " + str(line[0])
                             + "\t" + str(pair))
                        exit(1)
                else:
                    studenti_dict[k].append(pair)
                    pronaden = 1

        if(pronaden == 0):
            print("Studenta nema u glavnom popisu! JMBAG: " + line[0])
            exit(1)
        else:
            pronaden = 0

print(studenti_dict)