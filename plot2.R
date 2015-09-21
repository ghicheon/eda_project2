library(plyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# 2.Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
# (fips == "24510") from 1999 to 2008? Use the base plotting system to make a 
# plot answering this question.

out <- ddply( NEI[ NEI$fips == "24510",], c("year"),summarize, 
              emission=sum(Emissions))


 barplot(out$emission,out$year, ylim=c(0,4000),xlab="years",
         ylab="emission", main="emission of Baltimore City 1999~2008",
	 names.arg=c("1999","2002","2005","2008"),col="magenta")

dev.copy(png,'plot2.png')
dev.off()
