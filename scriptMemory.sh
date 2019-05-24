#!/bin/sh
groupingMemory(){
	for it in {1..1260}
	do
		cache=`cat "memory_"$it".txt" | awk '$1=="Cached:" {print $2}' | datamash mean 1`
		memFree=`cat "memory_"$it".txt" | awk '$1=="MemFree:" {print $2} ' | datamash mean 1 `
		memAvailable=`cat "memory_"$it".txt" | awk '$1=="MemAvailable:" {print $2}' | datamash mean 1`
		buffers=`cat "memory_"$it".txt" | awk '$1=="Buffers:" {print $2}' | datamash mean  1`
		paste <(echo "$memFree")  <(echo "$memAvailable") <(echo "$buffers") <(echo "$cache"$'\r') >> ../../"memory_"$1".txt"
	done
}

scriptMemoryGrouping(){
	for (( i = 1; i <= 5; i++ )); do
		case "$i" 
		in 
			1)
				cd kal/memory/
				groupingMemory "kal"
		    	cd ../..
		    ;;
	        
	        2)
	        	cd maverage/memory/
				groupingMemory "mal"
				cd ../..   
	        ;;
	        3)
				cd spline/memory/
				groupingMemory "spl"
				cd ../..
	        ;;
	  		4)
				cd ssa/memory/
				groupingMemory "ssa"
				cd ../..
			;;
			5)
				cd stine/memory/
				groupingMemory "sti"
				cd ../..
		esac
	done
}

scriptMemoryGrouping

