library(plyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#5. How have emissions from motor vehicle sources changed from 1999 to 2008 
# in Baltimore City?


#I tried SCC.Level.Three first. but there's no records of the city..
#there would be a better way...anyway,I'll do it with EI.Sector
temp <- SCC[ grep("Vehicles", SCC$EI.Sector),]$SCC

what <- as.character(temp)

#got proper records from SCC. check if SCC is one of values of what.
NEI2 <- NEI[ NEI$SCC %in% what ,]


#I found out  fips of baltimore city  end with "510".
out <- ddply( NEI2[ NEI2$fips =="24510" ,] , 
              c("year" ),summarize, emission=sum(Emissions))

ggout <- qplot(x=year, y=emission,
                   data=out, geom="bar", stat="identity", position="dodge",
   	           main="emissions change from motor vehicle sources in Baltimore City")

print(ggout)

dev.copy(png,'plot5.png')
dev.off()
