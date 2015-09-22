library(plyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#3. Of the four types of sources indicated by the type (point, nonpoint, onroad,
#nonroad) variable, which of these four sources have seen decreases in emissions
#from 1999 to 2008 for Baltimore City? Which have seen increases in emissions 
#from 1999 to 2008? Use the ggplot2 plotting system to make a plot answer this 
#question.


out <- ddply( NEI[ NEI$fips == "24510",], c("year", "type"),summarize, 
              emission=sum(Emissions))

gout       <- qplot(x=year, y=emission, fill=type,
                   data=out, geom="bar", stat="identity", position="dodge",
   	           main="emisson of Baltimore City 1999~2008 per types")

print(gout)

dev.copy(png,'plot3.png')
dev.off()
