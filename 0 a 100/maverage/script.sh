#!/bin/bash
for it in {6967..9000}
do  
	echo "iteração="$it
	#primeira medição da memória antes de rodar o script 
	cat /proc/meminfo | awk 'NR<=5 {print}' >> "./memory/memory1_"$it".txt"& 
	#profiling -e  task-clock,faults,cs,migrations
	sudo  perf stat -e  task-clock,faults,cs,migrations -o "./perf/mal_"$it".txt"  R  < maverage.R  --save >/dev/null &
	sleep 0.1 # o sleep foi utilizado por que sem ele não estava fazendo a leitura do pid do R, logo dava erro
	pid_r=`pidof R -s &`
	pid_todos=`pidof R &`

	echo "ALL PID=" $pid_todos
	echo "PID R em uso: " $pid_r

	# enquanto o script estiver rodando façaa medição dos parâmetrsos de memória
	while s=`ps -p $pid_r -o s=` && [[ "$s" && "$s" != 'Z' ]]
			do
			#trecho de código que faz a medição dos parametros de memória 
			    cat /proc/meminfo | awk 'NR<=5 {print}' >> "./memory/memory_"$it".txt"&
			done
	#datamash mean 1 < "memory_"$it".txt" > "memory_"$it".txt" 
done
