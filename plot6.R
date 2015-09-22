library(plyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#6. Compare emissions from motor vehicle sources in Baltimore City with 
# emissions from motor vehicle sources in Los Angeles County, California 
# (fips == "06037"). Which city has seen greater changes over time in motor 
# lvehicle emissions?

temp <- SCC[ grep("Vehicles", SCC$EI.Sector),]$SCC

what <- as.character(temp)

#got proper records from SCC. check if SCC is one of values of what.
#I hope this way is faster than using NEI twice directly. 
NEI2 <- NEI[ NEI$SCC %in% what ,]


#I found out  fips of baltimore city  end with "510".
out <- ddply( NEI2[ NEI2$fips =="24510" ,] , 
              c("year" ),summarize, emission=sum(Emissions))

out2 <- ddply( NEI2[ NEI2$fips =="06037",] , 
              c("year" ),summarize, emission=sum(Emissions))

ggout <- qplot(x=year, y=emission,
                   data=out, geom="bar", stat="identity", position="dodge",
   	           main="emissions from motor vehicles \n in Baltimore City")

ggout2 <- qplot(x=year, y=emission,
                   data=out2, geom="bar", stat="identity", position="dodge",
   	           main="emissions from motor vehicles \n in Los Angeles County")

#to show two graph on one window.
library(gridExtra)
grid.arrange(ggout,ggout2,nrow=1)

dev.copy(png,'plot6.png')
dev.off()
