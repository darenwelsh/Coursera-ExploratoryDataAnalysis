plot1 <- function(){
    # Have total emissions from PM2.5 decreased in the United States 
    # from 1999 to 2008? Using the base plotting system, make a plot 
    # showing the total PM2.5 emission from all sources for each of 
    # the years 1999, 2002, 2005, and 2008.
    setwd("/Users/lwelsh/r/Coursera/Coursera-ExploratoryDataAnalysis/project2")
    
    NEI <- readRDS("summarySCC_PM25.rds")
    SCC <- readRDS("Source_Classification_Code.rds")
    
    NEI$fips <- as.factor(NEI$fips)
    NEI$SCC <- as.factor(NEI$SCC)
    NEI$type <- as.factor(NEI$type)
    
    TotalEmissionsByYear <- ddply(NEI,.(year),summarize,TotalEmissions=sum(Emissions))
    
    # initiate png device
    png(file="plot1.png")
    
    # generate plot
    plot(TotalEmissionsByYear
        ,xlab="Year"
        ,ylab="Total Emissions"
        ,main="U.S. Emissions"
    )
    
    # add a line
    lines(TotalEmissionsByYear)
    
    # shut down png device 
    dev.off()

}