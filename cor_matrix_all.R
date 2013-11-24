# Primary Pairs
getFX("EUR/USD")
getFX("GBP/USD")
getFX("AUD/USD")
getFX("NZD/USD")
getFX("USD/JPY")
getFX("USD/CHF")
getFX("USD/CAD")
getFX("XAU/USD")
getFX("XAG/USD")

# Crosses
getFX("EUR/AUD")
getFX("EUR/CHF")
getFX("AUD/JPY")
getFX("AUD/NZD")
getFX("EUR/JPY")
getFX("GBP/JPY")
getFX("EUR/GBP")
getFX("NZD/JPY")


df <- data.frame(EURUSD = EURUSD, GBPUSD = GBPUSD, AUDUSD = AUDUSD, 
                 NZDUSD = NZDUSD, USDJPY = USDJPY, USDCHF = USDCHF,
                 USDCAD = USDCAD, XAUUSD = XAUUSD, XAGUSD = XAGUSD,
                 AUDJPY = AUDJPY, EURJPY = EURJPY, GBPJPY = GBPJPY,
                 EURGBP = EURGBP, NZDJPY = NZDJPY, EURAUD = EURAUD,
                 AUDNZD = AUDNZD, EURCHF = EURCHF)

cm <- as.matrix(cor(df))
cm

# pairs(df)