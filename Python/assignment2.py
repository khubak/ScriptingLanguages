#ucitaj niz
import sys
import pathlib

input_file = ''
input_list = []
max_len = 0

def header():
    print("Hyp", end='')
    for i in range(10, 91, 10):
        print("#Q" + str(i), end='')
    print()

if(len(sys.argv) != 2):
    print("nije dobar broj argumenata!")
    exit(1)

input_file = pathlib.Path(sys.argv[1])

if input_file.exists() == False:
    print("file nije dobar")
    exit(1)
try:
    r = open(sys.argv[1])
except OSError:
    print("Nije uspio open")
    exit(1)

for line in r:
    if line == '\n':
        print("nije citka!")
        exit(1)
    entry = line.rstrip("\n").split(" ")
    entry = [float(x) for x in entry]
    entry.sort()
    input_list.append(entry)

header()

#račun
#odaberi jedan broj

hyp_no = 1

for entry in input_list:
    duljina = len(entry)
    print(str(hyp_no).zfill(3), end='')
    for q in range(10, 91, 10):
        a = (q * 0.01) * (duljina - 1)
        a = int(a)
        print("#" + str(entry[int(a)]), end='')
    print()
    hyp_no = hyp_no + 1