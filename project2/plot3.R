plot3 <- function(){
    # Of the four types of sources indicated by the type 
    # (point, nonpoint, onroad, nonroad) variable, which of these four sources 
    # have seen decreases in emissions from 1999–2008 for Baltimore City? 
    # Which have seen increases in emissions from 1999–2008? 
    # Use the ggplot2 plotting system to make a plot answer this question.
    setwd("/Users/lwelsh/r/Coursera/Coursera-ExploratoryDataAnalysis/project2")
    library(ggplot2)
    
    NEI <- readRDS("summarySCC_PM25.rds")
    SCC <- readRDS("Source_Classification_Code.rds")
    
    NEI$fips <- as.factor(NEI$fips)
    NEI$SCC <- as.factor(NEI$SCC)
    NEI$type <- as.factor(NEI$type)
    
    NEIsubset <- subset(NEI, fips == "24510")
    NEIsubset <- subset(NEIsubset, year %in% c("1999","2008"))
    
    Year <- factor(NEIsubset$year)
    Type <- factor(NEIsubset$type)
    aggPM25 <- aggregate(Emissions ~ Year + Type
                         ,data = NEIsubset, FUN = "sum")
    
    # initiate png device
    png(file="plot3.png")
    
    # generate plot
    g <- ggplot(aggPM25, aes(Year, Emissions))
    p <- g + 
        geom_point(size=6) + 
        facet_wrap( ~ Type) + 
        labs(title = "Emissions by Type in Baltimore City")
    
    # print plot
    print(p)
    
    # shut down png device 
    dev.off()
    
}