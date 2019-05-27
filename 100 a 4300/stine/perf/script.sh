#!/bin/sh

for (( i = 1; i <=1260; i++ )); do
	#statements
	cat "sti1_"$i".txt" > "sti_"$i".txt" 
	rm "sti1_"$i".txt"
done