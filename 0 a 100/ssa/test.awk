# !/usr/bin/awk -f
# My first awk scriptawk '{print $0}'

#awk 'print"1",$1," 2: ",$2}' memory/memory_1.txt

awk 'NR % 4==0 {print NR"", $1, " ",$2}' memory/memory_1.txt

