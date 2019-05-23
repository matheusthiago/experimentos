#!/bin/sh

ManipulatePerfOutput(){

		cat $1 | awk 'END{printf "%.2f\n", $1}' > $1"_"$2".time" 
		echo $2 >> $1"_"$2".time"           

		#Remover aquelas linhas do perf que iniciam com # pois não servem
		sed '/^#/ d' $1 > aux
		rm $1
		mv aux $1    

		#Aqui você vai pegar todas as linhas de um dado performance counter e colocar em uma variável  
		for ((k = 0; k < ${#PMUs[@]}; k++));
		do  
			groups[$k]=$(grep ${PMUs[$k]} $1 | awk '{print $2}')  
		done 

		#Aqui você converte para um array e faz um arquivo para cada PMC
		for ((k = 0; k < ${#PMUs[@]}; k++));
		do	                	  
			array=(${groups[$k]})  
			for ((i = 0; i < ${#array[@]}; i++)); do
			       echo ${array[$i]} >> aux$k                       
		done            	
		done 

		#Aqui você junta os pmcs em um file
		STR=" "
		for ((k = 0; k < ${#PMUs[@]}; k++));
		do
			STR=$STR"aux"$k" "
		done        
		paste $STR -d "\t" > aux

		rm $1
		mv aux $1
		     
		rm aux*


		#Ao final, você tem um arquivo transformado em que cada coluna corresponde a um pmc
}



getMemory(){
	for it in {1..1}
	do
		cache=`cat "memory/memory1_"$it".txt" | awk '$1=="Cached:" {print $2}'`
		memFree=`cat "memory/memory1_"$it".txt" | awk '$1=="MemFree:" {print $2} ' `
		memAvailable=`cat "memory/memory1_"$it".txt" | awk '$1=="MemAvailable:" {print $2}'`
		buffers=`cat "memory/memory1_"$it".txt" | awk '$1=="Buffers:" {print $2}'`
	done

	paste <(echo "$memFree")  <(echo "$memAvailable") <(echo "$buffers") <(echo "$cache")


#sed sed '/Performance/d'; '/started/d'; '/^$/d'; 's/[ ]\+/ /g'  tst.txt 
# tirando todas as linhas vazias
#sed '/^$/d' tst.txt > tst.txt
#sed 's/[ ]\+/ /g'tst.txt > tst.txt
#cat tst.txt

}

#a = "$(sed '/Performance/d'  tst.txt)"
#echo "$a"
# aux= $(sed '/^#/ d' $aux)
# echo "$aux"


#cat $1 | awk 'END{printf}' > tst.txt


#Mas é muito comum, ao alterarmos um arquivo, queremos gravar estas alterações no próprio arquivo original. A tentativa intuitiva seria:
#Isso acontece porque ao fazer o redirecionamento >, o shell abre imediatamente o arquivo referenciado, antes mesmo de começar a executar o comando Sed. E como este é um redirecionamento destrutivo > e não incremental >>, se o arquivo já existir, ele será truncado, e seu conteúdo perdido. A essa altura, o Sed começará seu processamento já lendo um arquivo texto.txt vazio, e aplicados qualquer comandos Sed num arquivo vazio, o resultado será o próprio arquivo vazio.

getPerf(){
	for it in {1..2}
	do
		cp -a $1"_"$it".txt" temp.txt
		# tirando todas as linhas com as palavras Performance e started e tirando todas as linhas vazias
		sed '/Performance/d; /started/d; /^$/d; s/[ ]\+/ /g' temp.txt > $1"_"$it".txt"
		#imprindo apenas os valores necessários
		#awk '{print $2}' tst.txt #> tst-temp.txt
		#cp -a tst-temp.txt tst.txt
		rm temp.txt
		cat $1"_"$it".txt" >>data.txt
	done
}


getPerf "ssa"