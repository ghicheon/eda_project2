library(plyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#4. Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999 to 2008?

coalscc <-  SCC[ grep("Charcoal Manufacturing", SCC$SCC.Level.Three, ),]$SCC

v <- as.character(coalscc)


out <- ddply( NEI[ 
                  (NEI$SCC == v[1])  |
                  (NEI$SCC == v[2])  |
                  (NEI$SCC == v[3])  |
                  (NEI$SCC == v[4])  |
                  (NEI$SCC == v[5])  |
                  (NEI$SCC == v[6])  |
                  (NEI$SCC == v[7])  |
                  (NEI$SCC == v[8]) 
		 ,], 
              c("year" ),summarize, emission=sum(Emissions))



ggout <- qplot(x=year, y=emission,
                   data=out, geom="bar", stat="identity", position="dodge",
   	           main="emissions from coal combustion-related")

print(ggout)

dev.copy(png,'plot4.png')
dev.off()
