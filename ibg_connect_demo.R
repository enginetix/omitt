# IBGateway connection example
require(IBrokers)
ibg <- ibgConnect()

# Disconnect from gateway
twsDisconnect(ibg)