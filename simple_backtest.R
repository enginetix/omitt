require(quantmod)
require(PerformanceAnalytics)

# Step 1: Get the data
getSymbols("PH")

# Step 2: Create your indicator
dvi <- DVI(Cl(PH))

# Step 3: Construct your trading rule
sig <- Lag(ifelse(dvi$dvi < 0.28, 1, -1))

# Step 4: The trading rules/equity curve
ret <- ROC(Cl(PH))*sig
ret <- ret['2009-06-02/2012-09-07']
eq <- exp(cumsum(ret))
plot(eq)

# Step 5: Evaluate strategy performance
table.Drawdowns(ret, top=10)
table.DownsideRisk(ret)
charts.PerformanceSummary(ret)

dd <- maxDrawdown(ret)
rc <- Return.cumulative(ret)

str(dd)
str(rc)