#!/bin/sh

#1. zadatak
proba="Ovo je proba"
echo $proba

lista_datoteka="$(ls)"
echo "${lista_datoteka}"

proba3="$proba. $proba. $proba. "
echo $proba3

a=4
b=3
c=7
d=$((($a+4)*$b%$c))
echo $d

broj_rijeci=$(wc -w *.txt)
echo $broj_rijeci

ls ~hulejman

cut -d ":" -f 1,7,6 /etc/passwd --output-delimiter=" |||| "