require(signalextraction)
require(quantmod)

#getSymbols("EURUSD60", src='csv', dir="C:\\Documents and Settings\\Administrator\\My Documents\\R_work\\data")

setwd("C:\\Documents and Settings\\Administrator\\My Documents\\R_work\\data\\")
data <- read.csv2("EURUSD60.csv", header=T, sep=",")
colnames(data) <- c("Date", "Time", "Open", "High", "Close", "Low", "Volume")

## Instead of calling data(fit), one could run (time consuming)
#set.seed(21)
#data(x)
#fit <- dfa(x)

#plot(fit)
