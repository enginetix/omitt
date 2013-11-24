library(IBrokers)
library(twsInstrument)
library(mclust)

## Not run: 
#tws <- ibgConnect()

# price array
price <- vector()

#define_FX()
while(x<-1){
#Sys.sleep(.1)
fx <- get_quote(ls_twsInstruments())
#plot((fx[3,2]),ylim=c(1.349,1.359))
print(fx[2,1])
print(fx[2,2])
price <- c(price,fx[2,2]) 
plot(index(price),price,type="l")
#lines(index(price),price)

# Horizontal mean line
mdl1 <- lm(coredata(price) ~ 1)
abline(mdl1, col='Blue', lwd=2)

# Slope Line
try(mdl2 <- lm(coredata(price) ~ index(as.numeric(index(price)))))
try(abline(mdl2, col='Red', lwd=1))

#cluster model
shrink <- .01
try(mdl3 <- Mclust(data, prior = priorControl(functionName="defaultPrior", shrinkage=shrink)))
try(summary(mdl3, parameters = TRUE, classification = F))

try(
for(i in 1:length(mdl3$parameters$mean)) {
  abline(mdl3$parameters$mean[i],0, col=i+2)
}
)

}
## End(Not run)