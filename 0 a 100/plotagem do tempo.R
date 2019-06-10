tamanhoGap= seq(100,4200,100) 
mediaTempoSsa=c()
mediaTempoSpl=c()
mediaTempoKal=c()
mediaTempoMal=c()
mediaTempoSti=c()

kal=as.data.frame(read.table("grouped_kal.txt"))
names(kal)=c("task-clock", "faults", "cs", "migrations","time", "RMSE")

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
legend(x = 'topleft', merge = TRUE, pch = c(16, 16,16, 16), lty = c(1,1, 1,1, 1), col = c('blue', 'orange', 'green', 'purple'), legend = c('Spline', 'Kalman Arima', 'Moving Average' ,'Stine'))
lines(tamanhoGap,mediaTempoSpl, col='blue')
lines(tamanhoGap,mediaTempoKal, col='orange')
lines(tamanhoGap,mediaTempoMal, col='green')
lines(tamanhoGap,mediaTempoSti, col='purple')






plot(tamanhoGap,mediaTempoSti, col='purple', xlab = "tamanho do gap", ylab = "mediaTempo de tempo", main = "Media tempo de respostas" , ylim=c(0,4))
points(tamanhoGap,mediaTempoKal, col='orange')
legend(x = 'topleft', merge = TRUE, pch = c(16, 16), lty = c(1, 1), col = c('orange','purple'), legend = c('Kalman Arima', 'Stine'))
lines(tamanhoGap,mediaTempoKal, col='orange')
lines(tamanhoGap,mediaTempoSti, col='purple')
