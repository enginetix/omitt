require(quantmod)
require(mclust)

getFX("EUR/USD")
i = 200

for(i in 10:500){

x <- index(as.numeric(index(EURUSD[1:i,])))
y <- coredata(EURUSD[1:i,])



fit <- lm(y ~ x)
fit1 <- lm(y ~ 1)
mdl <- Mclust(y)
p <- findPeaks(y)
v <- findValleys(y)




plot(x,y,type="l")
abline(fit, col=2)
#abline(fit+.03)
abline(fit1,col=3, lty = 3)
points(p,y[p],col="Red", pch=24)
#points(v,y[v],col="Blue", pch=25)

for(i in 1:length(mdl$parameters$mean)) {
  abline(mdl$parameters$mean[i],0, col=i+4)
}

#Sys.sleep(.5)
}
