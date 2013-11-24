tws <- twsDisconnect(ibg)
# IBGateway connection example
require(IBrokers)
ibg <- ibgConnect()

# Disconnect from gateway test
#twsDisconnect(ibg)

AAPL <- reqMktData(ibg,twsSTK("AAPL"))