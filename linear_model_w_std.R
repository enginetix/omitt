require(quantmod)
require(mclust)
require(forecast)
require(signalextraction)
require(wavelets)
source('~/R_work/omitt/mt4Import.R')

#getFX("EUR/USD")

min <- 60
pair <- "EURUSD"
data <- mt4Import("~/R_work/data/", pair, min)
i = 300
shrink = .1

#for(i in 200:nrow(data)-1){

#x <- index(as.numeric(index(EURUSD[500:400,])))
#y <- coredata(EURUSD[500:400,])
data <- data[(nrow(data)-i):(nrow(data)),]

x <- index(data)
y <- Cl(data)
v <- Vo(data)

#mdl1_data <- mdl_data <- cbind(x,y,v)

fit <- lm(y ~ x)
fit1 <- lm(y ~ 1)
mdl <- Mclust(y,prior = priorControl(functionName="defaultPrior", shrinkage=shrink))
#mdl2 <- Mclust(mdl1_data,prior = priorControl(functionName="defaultPrior", shrinkage=shrink))
#p <- findPeaks(y)
#v <- findValleys(y)
wv <- dwt(y, n.levels=2, boundary="periodic")
#fc <- forecast(EURUSD)


plot(x,y,type="l",main=paste0(pair," - ",min))
abline(fit, col=2, lwd=2)
abline(fit1,col=2, lty = 2, lwd=5)
#points(p,y[p],col="Red", pch=24)   #plot peaks


for(i in 1:length(mdl$parameters$mean)) {
  abline(mdl$parameters$mean[i],0, col=4, lty = 4,lwd=2)
}

linea <- coef(fit)[2]
lineb <- coef(fit)[1]
stddev <- sd(resid(fit))

#abline(lineb, linea, col='cornflowerblue', lty='dashed')
abline(lineb+stddev, linea, col='green', lty='dashed')
abline(lineb-stddev, linea, col='green', lty='dashed')
abline(lineb+2*stddev, linea, col='green', lty='dashed')
abline(lineb-2*stddev, linea, col='green', lty='dashed')
abline(lineb+3*stddev, linea, col='green', lty='dashed')
abline(lineb-3*stddev, linea, col='green', lty='dashed')

lineb1 <- coef(fit1)[1]
stddev1 <- sd(resid(fit1))

abline(lineb1+stddev1,0, col='red', lty='dashed', lwd=2)
abline(lineb1-stddev1,0, col='red', lty='dashed', lwd=2)
abline(lineb1+2*stddev1,0, col='red', lty='dashed', lwd=2)
abline(lineb1-2*stddev1,0, col='red', lty='dashed', lwd=2)
abline(lineb1+3*stddev1,0, col='red', lty='dashed', lwd=2)
abline(lineb1-3*stddev1,0, col='red', lty='dashed', lwd=2)

#Sys.sleep(.5)

#mclust1Dplot(y, parameters = mdl$parameters, what="density")
#dens = densityMclust(y)
#se <- dfa(y) #signal extraction
#}
