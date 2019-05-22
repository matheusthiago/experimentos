#experimento 5
#script para verificar a acurácia do método e o seu uso de recursos: Splman Arima;
#O experimento foi feito  para a verificação de lacunas de 100 a 4300 gaps seguidos ao passo de 100
# com o total de 42 experimentos por dia.
#Para cada experimento, a lacuna foi  colocada a partir do ponto 2160 


#itens salvos: 
#R <kalman.r --save
#dia=1 
#i=1
#dfDados=readRDS(file="dfDadosESC.norm.rds")
#		n=100
#		iteracao=500
#		rmseSpl=c()

# library para o cálculo do rmse
require(Metrics)
#library para o uso do SSA
require(spectral.methods)


	dadoDia=dfDados$dados[which(dfDados$dia==dia)]
	#laço de tamanho do gap
		#laço de divisão da série temporal (distribuição de gaps)
		startPoint=2160
			dadoTemp=dadoDia
			piso=startPoint
			teto=startPoint+n
			dadoTemp[piso:teto]=NA #cria espaços em branco


			##########Parte do SSA##########
			data.filled <- gapfillSSA(amnt.artgaps = c(0.05, 0.05), DetBestIter = ".getBestIteration", series = dadoTemp, plot.results = FALSE, open.plot =FALSE, SSA.methods = c("nutrlan", "propack", "eigen", "svd"),tresh.convergence = 0.001, )
			dt1 <- data.filled$filled.series

			#Adaptação para não dar valores faltantes no Spline e não dar valores negativos no SSA
				for(i in 1:length(dt1)){
					if((dt1[i])<0 || is.na(dt1[i])){
						dt1[i]=0
					}
				}

			#Calculando o erro
			rmseSsa<-append(rmseSsa,(rmse(dadoDia[piso:teto],(dt1[piso:teto]))))
n=n+iteracao
if (n>=4300){
        n=100
        dia=dia+1
}
i=i+1
