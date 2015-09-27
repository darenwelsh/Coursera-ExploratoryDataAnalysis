plot4 <- function(){
    # Across the United States, how have emissions from coal combustion-related 
    # sources changed from 1999–2008?
    setwd("/Users/lwelsh/r/Coursera/Coursera-ExploratoryDataAnalysis/project2")
    library(reshape2)
    library(plyr)
    
    NEI <- readRDS("summarySCC_PM25.rds")
    SCC <- readRDS("Source_Classification_Code.rds")
    
    NEI$fips <- as.factor(NEI$fips)
    NEI$SCC <- as.factor(NEI$SCC)
    NEI$type <- as.factor(NEI$type)
    
    totaldata <- merge(NEI,SCC,by="SCC")
    
    # subset to just 1999 and 2008
    totaldatasubset <- subset(totaldata, year %in% c("1999","2008"))
    totaldatasubset$year <- as.factor(totaldatasubset$year)
    
    # Subset where SCC$EI.Sector is 
    # 13: Fuel Comb - Comm/Institutional - Coal
    # 18: Fuel Comb - Electric Generation - Coal
    # 23: Fuel Comb - Industrial Boilers, ICEs - Coal
    totaldatasubset <- subset(totaldatasubset, EI.Sector %in% c(
        "Fuel Comb - Comm/Institutional - Coal"
        ,"Fuel Comb - Electric Generation - Coal"
        ,"Fuel Comb - Industrial Boilers, ICEs - Coal"))
    
    # Reduce number of factors of EI.Sector from 59 to 3
    totaldatasubset$EI.Sector <- as.character(foo$EI.Sector)
    totaldatasubset$EI.Sector <- as.factor(foo$EI.Sector)
    
    TotalEmissionsByYear <- ddply(totaldatasubset
                        ,.(year),summarize,TotalEmissions=sum(Emissions))
    
    # initiate png device
    png(file="plot4.png")
    
    # generate plot
    plot(TotalEmissionsByYear
         ,xlab="Year"
         ,ylab="Total Emissions"
         ,main="Sum of Coal Combustion Related Emissions in U.S."
    )
    
    # add a line
    lines(TotalEmissionsByYear)
    
    # shut down png device 
    dev.off()
    
}