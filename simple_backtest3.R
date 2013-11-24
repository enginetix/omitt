require(quantmod)
require(PerformanceAnalytics)

# Step 1: Get the data
getFX("EUR/USD")

# Step 2: Create your indicator
dvi <- DVI(EURUSD)
rsi <- RSI(EURUSD)

# function
#func <- dvi$dvi < 0.711
func <- if(rsi < 30)

# Step 3: Construct your trading rule
#sig <- Lag(ifelse(dvi$dvi < 0.7, 1, -1))
sig <- Lag(ifelse(func, 1, -1), k = 2)
#sig <- ifelse(dvi$dvi < 0.7, 1, -1)

# Step 4: The trading rules/equity curve
ret <- ROC(EURUSD)*sig
#ret <- ret['2009-06-02/2012-09-07']
#eq <- exp(cumsum(ret))
#eq

# Step 5: Evaluate strategy performance
table.Drawdowns(ret, top=5)
table.DownsideRisk(ret)
charts.PerformanceSummary(ret)

