mal=as.data.frame(read.table("grouped_mal.txt"))
kal=as.data.frame(read.table("grouped_kal.txt"))
ssa=as.data.frame(read.table("grouped_ssa.txt"))
sti=as.data.frame(read.table("grouped_sti.txt"))
spl=as.data.frame(read.table("grouped_spl.txt"))

names(mal)=c("task-clock", "faults", "cs", "migrations","time", "RMSE")
names(kal)=c("task-clock", "faults", "cs", "migrations","time", "RMSE")
names(ssa)=c("task-clock", "faults", "cs", "migrations","time", "RMSE")
names(sti)=c("task-clock", "faults", "cs", "migrations","time", "RMSE")
names(spl)=c("task-clock", "faults", "cs", "migrations","time", "RMSE")

summary(mal)
summary(kal)
summary(ssa)
summary(sti)
summary(spl)


#plotagem dos gráficos relacionados ao tempo de resposta 
interval=c(1:1260)
plot(interval, ssa$time,col='red', xlab = "round",  ylab = "Tempo médio (s)", main = "Tempo médio de resposta" , ylim=c(min(ssa$time,spl$time,mal$time,kal$time,sti$time),max(ssa$time,spl$time,mal$time,kal$time,sti$time)))
points(interval,spl$time, col='blue')
points(interval,kal$time, col='orange')
points(interval,mal$time, col='green')
points(interval,sti$time, col='purple')
legend(x = 'topleft', merge = TRUE, pch = c(16,16, 16,16, 16), lty = c(1,1, 1,1, 1), col = c('red', 'blue', 'orange', 'green', 'purple'), legend = c('SSA','Spline', 'Kalman Arima', 'Moving Average' ,'Stine'))
lines(interval, ssa$time, col='red')
lines(interval,spl$time, col='blue')
lines(interval,kal$time, col='orange')
lines(interval,mal$time, col='green')
lines(interval,sti$time, col='purple')



#plot sem SSA
plot(interval, spl$time,col='blue', xlab = "round", ylab = "Tempo médio (s)", main = "Tempo médio de resposta" , ylim=c(0,max(spl$time,mal$time,kal$time,sti$time)))
points(interval,kal$time, col='orange')
points(interval,mal$time, col='green')
points(interval,sti$time, col='purple')
lines(interval,spl$time, col='blue')
lines(interval,kal$time, col='orange')
lines(interval,mal$time, col='green')
lines(interval,sti$time, col='purple')


#plot apenas karima e stine
plot(interval, kal$time,col='orange', xlab = "Round", ylab = "Tempo médio (s)", main = "Tempo médio de resposta" , ylim=c(0,max(kal$time,sti$time)))
points(interval,sti$time, col='purple')
lines(interval,kal$time, col='orange')
lines(interval,sti$time, col='purple')
legend(x = 'topleft', merge = TRUE, pch = c(16, 16), lty = c(1, 1), col = c('yellow', 'purple'), legend = c('Kalman Arima', 'Stine'))



