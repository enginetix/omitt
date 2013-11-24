require(quantmod)
require(PerformanceAnalytics)
require(DEoptim)
require(parallel)


set.seed(1)

# Step 1: Get the data
getSymbols("PH")

# Step 2: Create your indicator
dvi <- DVI(Cl(PH))

func <- function(x) {

  # Step 3: Construct your trading rule
  sig <- Lag(ifelse(dvi$dvi < x[1], 1, -1))
  
  # Step 4: The trading rules/equity curve
  ret <- ROC(Cl(PH))*sig
  ret <- ret['2012-01-01/2013-04-01']
  eq <- exp(cumsum(ret))
  
  dd <- maxDrawdown(ret)
  rc <- Return.cumulative(ret)
  
  if(rc<0) rc = 1e6
  
  ff <- dd + 1/rc
  return(ff)

}

#opt1 <- system.time(DEoptim(func,0,1,control=list(NP = 100, itermax = 100, trace = F,parallelType=0)))
optP <- system.time(DEoptim(func,0,1,control=list(NP = 10, itermax = 500, trace = F,parallelType=1)))

#(opt1)
(optP)