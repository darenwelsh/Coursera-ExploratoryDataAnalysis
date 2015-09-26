plot5 <- function(){
    # How have emissions from motor vehicle sources changed 
    # from 1999–2008 in Baltimore City?
    setwd("/Users/lwelsh/r/Coursera/Coursera-ExploratoryDataAnalysis/project2")
    library(ggplot2)
    library(plyr)
    
    NEI <- readRDS("summarySCC_PM25.rds")
    SCC <- readRDS("Source_Classification_Code.rds")
    
    NEI$fips <- as.factor(NEI$fips)
    NEI$SCC <- as.factor(NEI$SCC)
    NEI$type <- as.factor(NEI$type)
    
    totaldata <- merge(NEI,SCC,by="SCC")
    
    # subset to just Baltimore City, Maryland
    totaldatasubset <- subset(totaldata, fips == "24510")
    
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
    
    TotalEmissionsByYear <- ddply(totaldatasubset
                                  ,.(year),summarize,TotalEmissions=sum(Emissions))
    
    # initiate png device
    png(file="plot5.png")
    
    # generate plot
    g <- ggplot(TotalEmissionsByYear, aes(year, TotalEmissions))
    p <- g + 
        geom_point(size=6) + 
        geom_smooth() + 
        labs(x = "Year") + 
        labs(y = "Emissions") + 
        labs(title = "Motor Vehicle Related Emissions in Baltimore City")
    
    # print plot
    print(p)
    
    # shut down png device 
    dev.off()
    
}