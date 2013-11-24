data = (USDEUR[ ,1])

plot(1/USDEUR)
## trivial intercept model
abline(mC <- lm(1/USD.EUR ~ 1, data = USDEUR), col="Red") ## the same as
#abline(a = coef(mC), b = 0, col = "Red")