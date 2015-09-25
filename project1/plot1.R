plot1 <- function(){
    setwd("~/r/Coursera/Coursera-ExploratoryDataAnalysis/project1")
    library(datasets)
    
    # read in only the data for 2007-02-01 through 2007-02-02
    df <- read.table("./household_power_consumption.txt"
                     , sep=";"
                     , na.strings="?"
                     , skip=66637
                     , nrows=2880
                     )
    
    # assign useful names
    names(df) <- c("rawDate"
                   ,"rawTime"
                   ,"Global_active_power"
                   ,"Global_reactive_power"
                   ,"Voltage"
                   ,"Global_intensity"
                   ,"Sub_metering_1"
                   ,"Sub_metering_2"
                   ,"Sub_metering_3")
    
    # convert Date and Time cols from factors and merge into one new variable
    df$datetime <- strptime(paste(df$rawDate, df$rawTime), format="%d/%m/%Y %H:%M:%S")
    
    # initiate png device
    png(file="plot1.png")
    
    # generate plot
    hist(df$Global_active_power
         ,col="red"
         ,xlab="Global Active Power (kilowatts)"
         ,main="Global Active Power"
         )
    
    # shut down png device 
    dev.off()
}
