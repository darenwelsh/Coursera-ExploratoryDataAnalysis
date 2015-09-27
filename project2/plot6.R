plot6 <- function(){
    # Compare emissions from motor vehicle sources in Baltimore City 
    # with emissions from motor vehicle sources 
    # in Los Angeles County, California (fips == "06037"). 
    # Which city has seen greater changes over time in motor vehicle emissions?
    setwd("/Users/lwelsh/r/Coursera/Coursera-ExploratoryDataAnalysis/project2")
    library(ggplot2)
    
    NEI <- readRDS("summarySCC_PM25.rds")
    SCC <- readRDS("Source_Classification_Code.rds")
    
    NEI$fips <- as.factor(NEI$fips)
    NEI$SCC <- as.factor(NEI$SCC)
    NEI$type <- as.factor(NEI$type)
    
    totaldata <- merge(NEI,SCC,by="SCC")
    
    # subset of just Baltimore City, Maryland & Los Angeles County, California
    totaldatasubset <- totaldata
    totaldatasubset$fips <- as.character(totaldatasubset$fips)
    totaldatasubset <- subset(totaldatasubset, fips %in% c("24510","06037"))
    # Reduce number of factors of fips from to 2
    totaldatasubset$fips <- as.factor(totaldatasubset$fips)
    
    # Subset where SCC$EI.Sector is 
    # "Mobile - On-Road Diesel Heavy Duty Vehicles"       
    # "Mobile - On-Road Diesel Light Duty Vehicles"       
    # "Mobile - On-Road Gasoline Heavy Duty Vehicles"     
    # "Mobile - On-Road Gasoline Light Duty Vehicles" 
    totaldatasubset <- subset(totaldatasubset, EI.Sector %in% c(
        "Mobile - On-Road Diesel Heavy Duty Vehicles"       
        , "Mobile - On-Road Diesel Light Duty Vehicles"       
        , "Mobile - On-Road Gasoline Heavy Duty Vehicles"     
        , "Mobile - On-Road Gasoline Light Duty Vehicles" ))
    
    Year <- factor(totaldatasubset$year)
    Location <- factor(totaldatasubset$fips)
    aggPM25 <- aggregate(Emissions ~ Year + Location
                         ,data = totaldatasubset, FUN = "sum")
    
    # Change fips values to Location names for plot
    levels(aggPM25$Location) <- gsub("06037","Los Angeles County, California", levels(aggPM25$Location))
    levels(aggPM25$Location) <- gsub("24510","Baltimore City, Maryland", levels(aggPM25$Location))
    
    # initiate png device
    png(file="plot6.png")
    
    # generate plot
    g <- ggplot(aggPM25, aes(Year, Emissions))
    p <- g + 
        geom_point(size=6)+#, aes(color=Location)) + 
        facet_grid(Location~.,scales="free_y") + 
        labs(title = "A Tale of Two Cities: Motor Vehicle Related Emissions")
    
    # print plot
    print(p)
    
    # shut down png device 
    dev.off()
    
}