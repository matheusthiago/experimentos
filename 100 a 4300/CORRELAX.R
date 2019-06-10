
mx.mediaSsaDia=matrix(data=mediaSsa, nrow=20, ncol = 30)
mx.mediaSsaLac=t(mx.mediaSsaDia)

df.mediaSsaDia=as.data.frame((mx.mediaSsaDia))
df.mediaSsaLac=as.data.frame(mx.mediaSsaLac)

names(df.mediaSsaDia)=paste('Dia', 1:ncol(df.mediaSsaDia), sep='')
names(df.mediaSsaLac)=paste('Lac',1:ncol(df.mediaSsaLac), sep='')



#o c2 indica media por coluna, o 1 media por linha 
test=apply(df.mediaSsaLac, c(2),mean)
test=data.frame(apply(df.mediaSsaLac, c(2),mean))

#pegando a media das lacunas 
test=data.frame(apply(df.mediaSsaLac, c(2),mean))


#media do RMSE de cada lacuna de 10 de todos os dias até 2000 de todos os dias 
mediaTotalSsaDia= data.frame(tipoLac=names(test), media=test, row.names=NULL)


#diagrama de dispersão 
plot(seq(100,2000,100), mediaTotalSsaDia$media, xlab = "tamanho do gap", ylab = "media RMSE Ssa", main = "Diagrama de dispersão" )

#correlação entre o tamanho do gap e o rmse

tamanhoGap= seq(100,2000,100)
cor(mediaTotalSsaDia$media , tamanhoGap) 

#Observe que o R retornou o valor 0.9516391 o que evidencia uma forte relação linear entre as variáveis em estudo. Para avaliar se esse resultado é significativo, pode-se realizar um Teste de Hipóteses para a o Coeficiente de Correlação (supondo que as suposições do teste sejam satisfeitas):


cor.test(mediaTotalSsaDia$media , tamanhoGap) 

#Pearson's product-moment correlation

#data:  mediaTotalSsaDia$media and tamanhoGap
#t = 13.142, df = 18, p-value = 1.152e-10
#alternative hypothesis: true correlation is not equal to 0
#95 percent confidence interval:
# 0.8794887 0.9810289
#sample estimates:
#      cor 
#0.9516391 

#Como o Valor P do teste (p-value = 1.152e-10) é bem pequeno, conclui-se que o valor do Coeficiente de Correlação Linear de Pearson tem significância Estatística.


#------------------------------------
#ajuste do modelo Linear 

#Para ajustar um modelo de regressão linear no R utiliza-se a função lm

media=mediaTotalSsaDia$media 

ajuste=lm(media ~ tamanhoGap)

#Note que função lm() é chamada com o formato lm(y ˜ x), ou seja, a variável resposta é y e a preditora é x, sempre nessa ordem.

ajuste

#Call:
#lm(formula = media ~ tamanhoGap)

Coefficients:
(Intercept)   tamanhoGap  
  1.543e-01    7.153e-05  

> summary(ajuste)

#Call:
#lm(formula = media ~ tamanhoGap)

#Residuals:
#       Min         1Q     Median         3Q        Max 
#-0.0219349 -0.0119356  0.0008345  0.0101519  0.0281958 

#Coefficients:
#             Estimate Std. Error t value Pr(>|t|)    
#(Intercept) 1.543e-01  6.520e-03   23.67 5.15e-15 ***
#tamanhoGap  7.153e-05  5.443e-06   13.14 1.15e-10 ***
#---
#Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

#Residual standard error: 0.01404 on 18 degrees of freedom
#Multiple R-squared:  0.9056,	Adjusted R-squared:  0.9004 
#F-statistic: 172.7 on 1 and 18 DF,  p-value: 1.152e-10

anova(ajuste)
#Analysis of Variance Table

#Response: media
#           Df   Sum Sq  Mean Sq F value    Pr(>F)    
#tamanhoGap  1 0.034023 0.034023  172.71 1.152e-10 ***
#Residuals  18 0.003546 0.000197                      
---
#Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1


# reta ajustada no diagrama de dispersão
plot(seq(100,2000,100), mediaTotalSsaDia$media, xlab = "tamanho do gap", ylab = "media RMSE Ssa", main = "Diagrama de dispersão com a reta ajustada" )

abline(lm(media~tamanhoGap))


#INTERVALOS DE CONFIANÇA 

confint(ajuste)

#confint(ajuste)
#                   2.5 %       97.5 %
#(Intercept) 1.406422e-01 1.680379e-01
#tamanhoGap  6.009349e-05 8.296293e-05


#Testes de Hipóteses
#Para proceder o Teste F da Significâcnia da Regressão e os Testes t individuais, verifique o Valor P para  cada caso através da saída da função summary:



#Para avaliar as suposições de que os erros possuem variância constante e são não correlacionados entre
#si, construa os gráficos de “Resíduos versus Valores Ajustados da Variável Resposta” e “Resíduos versus
#Valores da Variável Explicativa":


plot(fitted(ajuste),residuals(ajuste),xlab="Valores Ajustados",ylab="Resíduos", main="Resíduos versus Valores Ajustados da Variável Resposta")
abline(h=0)
plot(tamanhoGap,residuals(ajuste),xlab="tamanhoGap",ylab="Resíduos", main="Resíduos versus Valores da Variável Explicativa")
abline(h=0)


#Na Figura 3, observa-se a violação da suposição de homocedasticidade dos erros. Para corroborar esse
#resultado, pode-se dividir o conjunto de dados em duas partes, utilizando a mediana por exemplo, e
#realizar um teste para comparar as variâncias de cada subconjunto:




#Outra maneira de avaliar a heterocedasticidade dos erros é realizar algum teste de homocedasticidade.
#Na biblioteca lmtest do R, a função bptest realiza o teste de Breusch-Pagan. Ressalta-se, entretanto,
#que tal teste não é muito poderoso e pode levar à
#Para avaliar a suposição de normalidade dos erros, deve-se construir o gráfico da “Probabilidade Normal
#dos Resíduos”:

 #median(tamanhoGap)
#[1] 1050

#Para avaliar a suposição de normalidade dos erros, deve-se construir o gráfico da “Probabilidade Normal dos Resíduos”:

qqnorm(residuals(ajuste), ylab="Resíduos",xlab="Quantis teóricos",main="")
qqline(residuals(ajuste))

#Pela Figura 4 (página seguinte), observa-se a violação da suposição de que os erros aleatórios têm distribuição Normal. Considere, também o Teste de Normalidade de Shapiro Wilk :

shapiro.test(residuals(ajuste))

#Shapiro-Wilk normality test

#data:  residuals(ajuste)
#W = 0.96111, p-value = 0.5663

#?????Portanto, como o Valor P do teste é pequeno, rejeita-se a hipótese de normalidade dos resíduos e, por
#consequência, conclui-se que os erros não são normalmente distribuídos



#------Intervalos de Confiança para Resposta Média e Individua


#Se X0 é um vetor, por exemplo, X0 = (0, 1, ..., 34, 35), pode-se contruir gráficos com as estimativas
#pontuais e intervalares das respostas médias e individuais, por meio dos respectivos comandos:

par(mfrow=c(1,2))
x0=data.frame(tamGap=seq(100,2000, 100))
p1=predict(ajuste, x0, interval = "confidence", se=T)
p2=predict(ajuste, x0, interval = "prediction", se=T)

#Estimativas pontuais e Intervalos de Confiança de 95% para as respostas médias e individuais

 matplot(x0, p1$fit, lty=c(1,2,2), type="l", xlab="tamGap", ylab="RMSE Médio")
 matplot(x0, p2$fit, lty=c(1,2,2), type="l", xlab="tamGap", ylab="RMSE Médio")



