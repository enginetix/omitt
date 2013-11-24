library(IBrokers)
tws <- ibgConnect()
aapl.csv <- file("AAPL.csv", open="w")

# run an infinite-loop ( <C-c> to break )
aapl <- reqHistoricalData(tws, twsSTK("AAPL"), barSize="1 day", duration = "1 M")

close(tws)