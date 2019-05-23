tamanhoGap= seq(100,4200,100) 
mediaSsa=c()
mediaSpl=c()
mediaKal=c()
mediaMal=c()
mediaSti=c()

for (i in seq(1,42,1)) {
	mediaSsa=append(mediaSsa,(mean(ssa$RMSE[seq(i,1260, 42)])))
	mediaSpl=append(mediaSpl,(mean(spl$RMSE[seq(i,1260, 42)])))
	mediaKal=append(mediaKal,(mean(kal$RMSE[seq(i,1260, 42)])))
	mediaMal=append(mediaMal,(mean(mal$RMSE[seq(i,1260, 42)])))
	mediaSti=append(mediaSti,(mean(sti$RMSE[seq(i,1260, 42)])))
}


plot(tamanhoGap, mediaSsa,col='red', xlab = "tamanho do gap", ylab = "media RMSE", main = "Media RMSE das lacunas" , ylim=c(min(mediaSsa, mediaSpl,mediaSti,mediaKal, mediaMal),max(mediaSsa, mediaSpl,mediaSti,mediaKal, mediaMal)))

points(tamanhoGap,mediaSpl, col='blue')
points(tamanhoGap,mediaKal, col='orange')
points(tamanhoGap,mediaMal, col='green')
points(tamanhoGap,mediaSti, col='purple')
legend(x = 'topleft', merge = TRUE, pch = c(16, 16, 16,16, 16), lty = c(1, 1, 1,1, 1), col = c( 'red', 'blue', 'orange', 'green', 'purple'), legend = c('SSA', 'Spline', 'Kalman Arima', 'Moving Average' ,'Stine'))

lines(tamanhoGap, mediaSsa, col='red')
lines(tamanhoGap,mediaSpl, col='blue')
lines(tamanhoGap,mediaKal, col='orange')
lines(tamanhoGap,mediaMal, col='green')
lines(tamanhoGap,mediaSti, col='purple')


#plot sem Spl e Sti
plot(tamanhoGap, mediaSsa,col='red', xlab = "tamanho do gap", ylab = "media RMSE", main = "Media RMSE das lacunas" , ylim=c(min(mediaSsa, mediaKal, mediaMal),max(mediaSsa, mediaKal, mediaMal)))
points(tamanhoGap,mediaKal, col='orange')
points(tamanhoGap,mediaMal, col='green')
legend(x = 'topleft', merge = TRUE, pch = c(16, 16, 16), lty = c(1, 1, 1), col = c( 'red', 'orange', 'green'), legend = c('SSA', 'Kalman Arima', 'Moving Average'))
