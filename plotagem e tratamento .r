tamanhoGap= seq(100,4200,100) 
mediaRmseSsa=c()
mediaRmseSpl=c()
mediaRmseKal=c()
mediaRmseMal=c()
mediaRmseSti=c()

for (i in seq(1,42,1)) {
	mediaRmseSsa=append(mediaRmseSsa,(mean(ssa$RMSE[seq(i,1260, 42)])))
	mediaRmseSpl=append(mediaRmseSpl,(mean(spl$RMSE[seq(i,1260, 42)])))
	mediaRmseKal=append(mediaRmseKal,(mean(kal$RMSE[seq(i,1260, 42)])))
	mediaRmseMal=append(mediaRmseMal,(mean(mal$RMSE[seq(i,1260, 42)])))
	mediaRmseSti=append(mediaRmseSti,(mean(sti$RMSE[seq(i,1260, 42)])))
}


plot(tamanhoGap, mediaRmseSsa,col='red', xlab = "tamanho do gap", ylab = "media RMSE", main = "Media RMSE das lacunas" , ylim=c(min(mediaRmseSsa, mediaRmseSpl,mediaRmseSti,mediaRmseKal, mediaRmseMal),max(mediaRmseSsa, mediaRmseSpl,mediaRmseSti,mediaRmseKal, mediaRmseMal)))

points(tamanhoGap,mediaRmseSpl, col='blue')
points(tamanhoGap,mediaRmseKal, col='orange')
points(tamanhoGap,mediaRmseMal, col='green')
points(tamanhoGap,mediaRmseSti, col='purple')
legend(x = 'topleft', merge = TRUE, pch = c(16, 16, 16,16, 16), lty = c(1, 1, 1,1, 1), col = c( 'red', 'blue', 'orange', 'green', 'purple'), legend = c('SSA', 'Spline', 'Kalman Arima', 'Moving Average' ,'Stine'))

lines(tamanhoGap, mediaRmseSsa, col='red')
lines(tamanhoGap,mediaRmseSpl, col='blue')
lines(tamanhoGap,mediaRmseKal, col='orange')
lines(tamanhoGap,mediaRmseMal, col='green')
lines(tamanhoGap,mediaRmseSti, col='purple')


#plot sem Spl e Sti
plot(tamanhoGap, mediaRmseSsa,col='red', xlab = "tamanho do gap", ylab = "mediaRmse RMSE", main = "Media RMSE das lacunas" , ylim=c(min(mediaRmseSsa, mediaRmseKal, mediaRmseMal),max(mediaRmseSsa, mediaRmseKal, mediaRmseMal)))
points(tamanhoGap,mediaRmseKal, col='orange')
points(tamanhoGap,mediaRmseMal, col='green')
legend(x = 'topleft', merge = TRUE, pch = c(16, 16, 16), lty = c(1, 1, 1), col = c( 'red', 'orange', 'green'), legend = c('SSA', 'Kalman Arima', 'Moving Average'))
lines(tamanhoGap, mediaRmseSsa, col='red')
lines(tamanhoGap,mediaRmseKal, col='orange')
lines(tamanhoGap,mediaRmseMal, col='green')




#plot sem Mal e Kal



plot(tamanhoGap, mediaRmseSsa,col='red', xlab = "tamanho do gap", ylab = "Media RMSE", main = "Media RMSE das lacunas" , ylim=c(min(mediaRmseSsa, mediaRmseSpl,mediaRmseSti),max(mediaRmseSsa, mediaRmseSpl,mediaRmseSti)))

points(tamanhoGap,mediaRmseSpl, col='blue')
points(tamanhoGap,mediaRmseSti, col='purple')
legend(x = 'topleft', merge = TRUE, pch = c(16, 16, 16), lty = c(1, 1, 1), col = c( 'red', 'blue', 'purple'), legend = c('SSA', 'Spline', 'Stine'))

lines(tamanhoGap, mediaRmseSsa, col='red')
lines(tamanhoGap,mediaRmseSpl, col='blue')
lines(tamanhoGap,mediaRmseSti, col='purple')




tamanhoGap= seq(100,4200,100) 
mediaTempoSsa=c()
mediaTempoSpl=c()
mediaTempoKal=c()
mediaTempoMal=c()
mediaTempoSti=c()

for (i in seq(1,42,1)) {
	mediaTempoSsa=append(mediaTempoSsa,(mean(ssa$time[seq(i,1260, 42)])))
	mediaTempoSpl=append(mediaTempoSpl,(mean(spl$time[seq(i,1260, 42)])))
	mediaTempoKal=append(mediaTempoKal,(mean(kal$time[seq(i,1260, 42)])))
	mediaTempoMal=append(mediaTempoMal,(mean(mal$time[seq(i,1260, 42)])))
	mediaTempoSti=append(mediaTempoSti,(mean(sti$time[seq(i,1260, 42)])))
}


plot(tamanhoGap, mediaTempoSsa,col='red', xlab = "tamanho do gap", ylab = "mediaTempo", main = "Media de tempo das lacunas" , ylim=c(min(mediaTempoSsa, mediaTempoSpl,mediaTempoSti,mediaTempoKal, mediaTempoMal),max(mediaTempoSsa, mediaTempoSpl,mediaTempoSti,mediaTempoKal, mediaTempoMal)))

points(tamanhoGap,mediaTempoSpl, col='blue')
points(tamanhoGap,mediaTempoKal, col='orange')
points(tamanhoGap,mediaTempoMal, col='green')
points(tamanhoGap,mediaTempoSti, col='purple')
legend(x = 'topleft', merge = TRUE, pch = c(16, 16, 16,16, 16), lty = c(1, 1, 1,1, 1), col = c( 'red', 'blue', 'orange', 'green', 'purple'), legend = c('SSA', 'Spline', 'Kalman Arima', 'Moving Average' ,'Stine'))

lines(tamanhoGap, mediaTempoSsa, col='red')
lines(tamanhoGap,mediaTempoSpl, col='blue')
lines(tamanhoGap,mediaTempoKal, col='orange')
lines(tamanhoGap,mediaTempoMal, col='green')
lines(tamanhoGap,mediaTempoSti, col='purple')




# sem ssa
plot(tamanhoGap,mediaTempoSpl, col='blue', xlab = "tamanho do gap", ylab = "mediaTempo de tempo", main = "Media tempo de respostas" , ylim=c(min(mediaTempoSpl,mediaTempoSti,mediaTempoKal, mediaTempoMal),max(mediaTempoSpl,mediaTempoSti,mediaTempoKal, mediaTempoMal)))
points(tamanhoGap,mediaTempoKal, col='orange')
points(tamanhoGap,mediaTempoMal, col='green')
points(tamanhoGap,mediaTempoSti, col='purple')
legend(x = 'topleft', merge = TRUE, pch = c(16,16, 16,16, 16), lty = c(1,1, 1,1, 1), col = c('red', 'blue', 'orange', 'green', 'purple'), legend = c('SSA','Spline', 'Kalman Arima', 'Moving Average' ,'Stine'))
lines(tamanhoGap,mediaTempoSpl, col='blue')
lines(tamanhoGap,mediaTempoKal, col='orange')
lines(tamanhoGap,mediaTempoMal, col='green')
lines(tamanhoGap,mediaTempoSti, col='purple')






plot(tamanhoGap,mediaTempoSti, col='purple', xlab = "tamanho do gap", ylab = "mediaTempo de tempo", main = "Media tempo de respostas" , ylim=c(0,4))
points(tamanhoGap,mediaTempoKal, col='orange')
legend(x = 'topleft', merge = TRUE, pch = c(16, 16), lty = c(1, 1), col = c('orange','purple'), legend = c('Kalman Arima', 'Stine'))
lines(tamanhoGap,mediaTempoKal, col='orange')
lines(tamanhoGap,mediaTempoSti, col='purple')
