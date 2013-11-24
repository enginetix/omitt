require(quantmod)
require(mclust)

getSymbols("USD/EUR",src="oanda")

day_bck <-  50;             #back days to work with
row_st <- nrow(USDEUR)      #start of working rows
row_num <- row_st-day_bck  #rows of working data starting from newest entry

data = (1/USDEUR[row_st:row_num,])  # set data to inverted USDEUR data (EURUSD)
#data = (1/USDEUR[1:n,])  # set data to inverted USDEUR data (EURUSD)

plot(data)
## trivial intercept model
#abline(mC <- lm(1/USD.EUR ~ 1, data = USDEUR), col="Red") ## the same as
#abline(a = coef(mC), b = , col = "Green")

# linear models
mdl1 <- lm(coredata(data) ~ 1)
mdl2 <- lm(coredata(data) ~ as.numeric(time(data)))

#cluster model
shrink <- .01
mdl3 <- Mclust(data, prior = priorControl(functionName="defaultPrior", shrinkage=shrink))
summary(mdl3, parameters = TRUE, classification = F)

#wavelet model
wv <- dwt(coredata(data), n.levels=1, boundary="periodic")

abline(mdl1, col='Red', lwd=5)
#abline(coef = mdl2, col='Red', lwd=1)

for(i in 1:length(mdl3$parameters$mean)) {
  abline(mdl3$parameters$mean[i],0, col=i+2)
}

