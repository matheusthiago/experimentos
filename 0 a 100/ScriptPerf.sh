#!/bin/sh

# Script feito para fazer o tratamento dos arquivos de texto do perf. 
#entrada original:
# started on Thu May 16 13:23:23 2019
# Performance counter stats for 'R --save':
#     111394.607720      task-clock (msec)         #    0.910 CPUs utilized          
#            84,921      faults                    #    0.762 K/sec                  
#           18,165      cs                        #    0.163 K/sec                  
#             1,544      migrations                #    0.014 K/sec                  
#     122.417833332 seconds time elapsed

# A saída após o script é um arquivo com todos os valores de todos os 1200 arquivos de texto da seguinte forma exemplo entrada= alg_1.txt e alg_2.txt saída: 
# 111394.607720 task-clock (msec) # 0.910 CPUs utilized 
# 84,921 faults # 0.762 K/sec 
# 18,165 cs # 0.163 K/sec 
# 1,544 migrations # 0.014 K/sec 
# 122.417833332 seconds time elapsed
# 111949.073092 task-clock (msec) # 0.909 CPUs utilized 
# 79,298 faults # 0.708 K/sec 
# 18,260 cs # 0.163 K/sec 
# 1,655 migrations # 0.015 K/sec 
# 123.102566010 seconds time elapsed
# saida=data.txt



#Mas é muito comum, ao alterarmos um arquivo, queremos gravar estas alterações no próprio arquivo original. A tentativa intuitiva seria:
#Isso acontece porque ao fazer o redirecionamento >, o shell abre imediatamente o arquivo referenciado, antes mesmo de começar a executar o comando Sed. E como este é um redirecionamento destrutivo > e não incremental >>, se o arquivo já existir, ele será truncado, e seu conteúdo perdido. A essa altura, o Sed começará seu processamento já lendo um arquivo texto.txt vazio, e aplicados qualquer comandos Sed num arquivo vazio, o resultado será o próprio arquivo vazio.

getPerf(){
	for it in {1..9000}
	do
		cp -a $1"_"$it".txt" temp.txt
		# tirando todas as linhas com as palavras Performance e started e tirando todas as linhas vazias
		sed '/Performance/d; /started/d; /^$/d; s/[ ]\+/ /g' temp.txt > $1"_"$it".txt"
		#imprindo apenas os valores necessários
		#awk '{print $2}' tst.txt #> tst-temp.txt
		#cp -a tst-temp.txt tst.txt
		#removendo o arquivo temporário
		rm temp.txt
		#concatenando o arquivo da iteração no arquivo de saída data.txt
		cat $1"_"$it".txt" >>data.txt
	done
}



groupingPerf(){
		tc=`cat "data.txt" | awk '$2=="task-clock" {print $1}'`
		faults=`cat "data.txt" | awk '$2=="faults" {print $1} ' `
		cs=`cat "data.txt" | awk '$2=="cs" {print $1}'`
		migrations=`cat "data.txt" | awk '$2=="migrations" {print $1}'`
		time=`cat "data.txt" | awk '$2=="seconds" {print $1}'`
		rmse=`cat "rmse.txt" | awk 'NR>1{print $2}' `	
		paste <(echo "$tc")  <(echo "$faults") <(echo "$cs") <(echo "$migrations") <(echo "$time") <(echo "$rmse") >  ../../"grouped_"$1".txt"
}	



#nome do algoritmo a ser 
scriptPerfGrouping(){
	for (( i = 1; i <= 4; i++ )); do
		case "$i" 
		in 
			1)
				cd kal/perf/
				groupingPerf "kal"
		    	cd ../..
		    ;;
	        
	        2)
	        	cd maverage/perf/
				groupingPerf "mal"
				cd ../..   
	        ;;
	        3)
				cd spline/perf/
				groupingPerf "spl"
				cd ../..
	        ;;
	  		5)
				cd ssa/perf/
				groupingPerf "ssa"
				cd ../..
			;;
			4)
				cd stine/perf/
				groupingPerf "sti"
				cd ../..
		esac
	done
}



scriptPerf(){
	for (( i = 1; i <= 4; i++ )); do
		case "$i" 
		in 
			1)
				cd kal/perf/
				getPerf "kal"
		    	cd ../..
		    ;;
	        
	        2)
	        	cd maverage/perf/
	        	getPerf "mal"
	        	cd ../..   
	        ;;
	        3)
				cd spline/perf/
				getPerf "spl"
				cd ../..
	        ;;
	  		5)
				cd ssa/perf/
				getPerf "ssa"
				cd ../..
			;;
			4)
				cd stine/perf/
				getPerf "sti"
				cd ../..
		esac
	done
}


scriptPerf
scriptPerfGrouping