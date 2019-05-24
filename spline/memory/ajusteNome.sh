#!bin/sh

for (( i = 1; i < 1260; i++ )); do
	#statements
	cp "memory1_"$i".txt" "memory_"$i".txt"
	rm "memory1_"$i".txt"
done