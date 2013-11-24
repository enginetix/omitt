library(lattice)



cor <- cm

#Build the plot
rgb.palette <- colorRampPalette(c("Red", "Green"), space = "rgb")
levelplot(cor, main="Forex Correlation Matrix", xlab="", ylab="", 
          col.regions=rgb.palette(20), cuts=100, at=seq(-1,1,0.1))