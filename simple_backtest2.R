require(quantmod)
require(PerformanceAnalytics)
library(quantmod)
library(mclust)
library(stringr)
library(chron)
library(timeDate)

set.seed(1)

# set chron.year.abb to false = 4 digit year format
options(chron.year.abb = F)

pair <- "EURUSD"
shrink <- 10

# date/time formate function for ducascopy date
f <- function(...) as.POSIXct(paste(...), format = "%Y%m%d %H:%M:%S") 

# read in the csv vile
DF <- read.csv(paste0("C:/Program Files (x86)/Tickstory Lite/",pair,".csv"))

# convert the data to a time series with index of colums date(1) and time(2)
data <- read.zoo(DF, index = list(1, 2), FUN = f) 

#convert the data to an extensable time series
data <- as.xts(data)

# Step 2: Create your indicator
dvi <- DVI(Cl(data))

# Step 3: Construct your trading rule
sig <- Lag(ifelse(dvi$dvi < 0.5, 1, -1))

# Step 4: The trading rules/equity curve
ret <- ROC(Cl(data))*sig
#ret <- ret['2009-06-02/2012-09-07']
#eq <- exp(cumsum(ret))
plot(eq)

# Step 5: Evaluate strategy performance
table.Drawdowns(ret, top=10)
table.DownsideRisk(ret)
charts.PerformanceSummary(ret)

