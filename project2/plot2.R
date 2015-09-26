plot2 <- function(){
    # Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
    # (fips == "24510") from 1999 to 2008? Use the base plotting system to make 
    # a plot answering this question.
    setwd("/Users/lwelsh/r/Coursera/Coursera-ExploratoryDataAnalysis/project2")
    
    NEI <- readRDS("summarySCC_PM25.rds")
    SCC <- readRDS("Source_Classification_Code.rds")
    
    NEI$fips <- as.factor(NEI$fips)
    NEI$SCC <- as.factor(NEI$SCC)
    NEI$type <- as.factor(NEI$type)
    
    NEIsubset <- subset(NEI, fips == "24510")
    NEIsubset <- subset(NEIsubset, year %in% c("1999","2008"))
    NEIsubset$year <- as.factor(NEIsubset$year)
    
    #TotalEmissionsByYear <- tapply(NEIsubset$Emissions,NEIsubset$year,sum)#,simplify=FALSE)
    TotalEmissionsByYear <- ddply(NEIsubset,.(year),summarize,TotalEmissions=sum(Emissions))
    
    # initiate png device
    png(file="plot2.png")
    
    # generate plot
    plot(TotalEmissionsByYear
         ,xlab="Year"
         ,ylab="Total Emissions"
         ,main="Total Emissions: Baltimore City, Maryland"
    )
    
    # add a line
    lines(TotalEmissionsByYear)
    
    # shut down png device 
    dev.off()
    
}