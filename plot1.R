library(plyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# 1. Have total emissions from PM2.5 decreased in the United States from 1999 
# to 2008? Using the base plotting system, make a plot showing the total PM2.5 
# emission from all sources for each of the years 1999, 2002, 2005, and 2008.

out <- ddply(NEI, c("year"),summarize, emission=sum(Emissions))


 barplot(out$emission,out$year, ylim=c(0,8000000),xlab="years",
         ylab="emission", main="emission 1999~2008",
	 names.arg=c("1999","2002","2005","2008"),col="pink")

dev.copy(png,'plot1.png')
dev.off()
