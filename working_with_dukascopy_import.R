library(quantmod)
library(mclust)
library(stringr)
library(chron)
library(timeDate)
library(foreach)

library(snow)
library(snowfall)

sfInit( parallel=TRUE, cpus=8 )
stopifnot( sfCpus() == 8 )
(stopifnot( sfParallel() == TRUE ))

foreach(i=10:2000) %dopar% {

set.seed(1)

# set chron.year.abb to false = 4 digit year format
options(chron.year.abb = F)

pair <- "EURJPY"
shrink <- 1

# date/time formate function for ducascopy date
f <- function(...) as.POSIXct(paste(...), format = "%Y%m%d %H:%M:%S") 

# read in the csv vile
DF <- read.csv(paste0("C:/Program Files (x86)/Tickstory Lite/",pair,".csv"))

# convert the data to a time series with index of colums date(1) and dime(2)
data <- read.zoo(DF, index = list(1, 2), FUN = f) 

#convert the data to an extensable time series
data <- as.xts(data)

# plot a bar chart if needed
# colnames(data)=c("Open","High","Low","Close","Volume") 
# barChart(data) 

# example of working with colums 
# z1 <- read.zoo(DF[-2], split = 1, index = list(3, 4), FUN = f) 


# check to see of the object exist
# if it doesn't then import the data
# getFX("AUD/JPY", from = Sys.Date() - days, to = Sys.Date())

# set the data to be clustered to closing and volume colums only
# data <- data.frame(Change = (Op(pair) - Cl(pair)), Vol = pair$Volume)
# data <- data.frame(Open = Op(pair))

# loop through and find rows with zeros and remove
# row_sub = apply(data, 1, function(row) all(row != 0))
# data <- data[row_sub,]

# Convert the date/timestamp data in to correct format
#ts = as.timeDate(paste(as.Date(as.character(DF$Date), "%Y%m%d"), DF$Timestamp))

ts <- chron(as.character(DF$Date),as.character(DF$Timestamp), format=c(dates="ymd", times="h:m:s"))

# create open and close data arrays
Cldata <- Cl(data)
Opdata <- Op(data)

# total time to cluster
t = as.numeric(i+100)
win = 100
Wd <- data.frame(Date = ts[t:t+win], Open = Opdata[t:t+win])


# model the clustered data
M <- 30 #nrow(Opdata)/10 # use only 1/10 of the rows for BIC

mdl1 <- Mclust(Opdata, noise = F, initialization=list(subset=sample(1:nrow(Wd), size = M)),prior = priorControl(functionName="defaultPrior", shrinkage=shrink))
mdl2 <- Mclust(Wd, noise = F, initialization=list(subset=sample(1:nrow(Wd), size = M)),prior = priorControl(functionName="defaultPrior", shrinkage=shrink))

#mdl1 <- Mclust(Opdata, prior = priorControl(functionName="defaultPrior", shrinkage=shrink))
#mdl2 <- Mclust(Wd, prior = priorControl(functionName="defaultPrior", shrinkage=shrink))

# plot the cluster models
par(mfrow = c(2,1))
plot.Mclust(mdl1, what = "classification")
plot.Mclust(mdl2, what = "classification")

# parameters.mdl

}
