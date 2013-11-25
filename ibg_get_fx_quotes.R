###############################################################################
# This file is an example of pulling live data from IB thu the Gatway
# The data is analyzed for mean, slope and clustered with mclust
# The data is then continoususly plotted
###############################################################################

# Load the required libraries
#library(IBrokers)
#library(twsInstrument)
#library(mclust)

# Connect to the IBgateway client 
#tws <- ibgConnect()

# clear price array fi necessary
#price <- vector()

# Define the forex insturments (if empty then only majors are used)
#define_FX()t

# Loop to recieve data from IB
while(x<-1){
  
  # May be nenessary as as IB has quote limits 
  Sys.sleep(1)
  
  # Retrieve the current instrument(s) quote 
  fx <- get_quote(ls_twsInstruments())
  #plot((fx[3,2]),ylim=c(1.349,1.359))
  
  # Print the colums one and two of the fourth row (GBP/JPY)
  print(fx[4,1])
  print(fx[4,2])
  
  # Append the new quote to the active array
  price <- c(price,fx[4,2])
  
  # Plot the price action
  plot(index(price),price,type="l")
  #lines(index(price),price)
  
  # Calculate horizontal mean line and plot
  mdl1 <- lm(coredata(price) ~ 1)
  abline(mdl1, col='Blue', lwd=2)

  # Calulcate the slope Line and plot
  try(mdl2 <- lm(coredata(price) ~ index(as.numeric(index(price)))))
  try(abline(mdl2, col='Red', lwd=1))

  # Cluster model
  shrink <- 1
  try(mdl3 <- Mclust(price, prior = priorControl(functionName="defaultPrior", shrinkage=shrink)))
  try(summary(mdl3, parameters = TRUE, classification = F))
   
  # Plot all of the caluclated clusters
  try(
      for(i in 1:length(mdl3$parameters$mean)) {
        abline(mdl3$parameters$mean[i],0, col=i+2)
      }
    )

}
## End(Not run)