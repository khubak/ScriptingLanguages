#!/bin/sh

grep -i -E 'jabuka|banana|jagoda|dinja|lubenica' namirnice.txt
grep -i -Ev 'jabuka|banana|jagoda|dinja|lubenica' namirnice.txt
grep -i -Ev 'jabuka|banana|jagoda|dinja|lubenica' namirnice.txt > ne-voce.txt
grep -rn '[A-Z]{3}\d{6}' ~/projekti/
find . -mtime +6 -mtime -15
for i in $(seq 15)
do
  echo "$i"
done