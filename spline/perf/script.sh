#!/bin/sh

for (( i = 1; i <=1260; i++ )); do
	#statements
	cat "spl1_"$i".txt" > "spl_"$i".txt" 
	rm "spl1_"$i".txt"
done