require(quantmod)

getSymbols("USD/EUR",src="oanda")
chartSeries(USDEUR,TA=c(addSMA(n=7), addRSI(n=7)))

#fit <- dfa(Cl(PH))

