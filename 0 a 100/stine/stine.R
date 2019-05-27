#experimento 5
#script para verificar a acurácia do método e o seu uso de recursos: Kalman Arima;
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
#		rmseKal=c()

# library para o cálculo do rmse
require(Metrics)
#usando imputTS para fazer imputações de dados
require(imputeTS)	

#print(paste("n:",n," interação:", interacao, " dia:",dia, " i:", i))

dadoDia=dfDados$dados[which(dfDados$dia==dia)]
#laço de tamanho do gap
#laço de divisão da série temporal (distribuição de gaps)
dadoTemp=dadoDia
piso=startPoint
teto=startPoint+n
dadoTemp[piso:teto]=NA #cria espaços em branco

# Perform imputation with KalmanSmoother and state space representation of arima model
sti= na.interpolation(dadoTemp,option="stine")

###################### Setando os vetores 

#Calculando o erro
rmseSti<-append(rmseSti,(rmse(dadoDia[piso:teto],(sti[piso:teto]))))

n=n+iteracao
if(n>100){
	n=1
	startPoint=startPoint+2160
	if(startPoint>6480){
		startPoint=2160
		dia=dia+1
	}
}
i=i+1
