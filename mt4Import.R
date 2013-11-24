################################################################################
### Import MT4 Data from exported csv files                                     
### Copyright, Enginetix (2013)                                                 
### J.K. DeHart                                                                 
### 5.31.13                                                                     
### Revision: 0.1                                                               
################################################################################
### Description: This function will accpet the file location, forex pair name,  
### and the time of measure for the data and return a data set with the correct 
### date,time,open,high,low,close,volume header as the 'dat'.
###### Inputs
############# dir <- director location, example "~/R_work/data/"
############# pair <- forex pair to retrieve, example "EURUSD"
############# tom <- time of measure in minutes, example "60" for one hour data
###############################################################################
###### Return --> dat (matrix of dohlcv data)

mt4Import <- function(dir, pair, tom) {
dat <- read.csv(paste0("~/R_work/data/",pair,tom,".csv"), header=F)
colnames(dat)=c("Date", "Time", "Open","High","Low","Close","Volume")
return(dat)
}