plot3 <- function(){
    setwd("~/r/Coursera/Coursera-ExploratoryDataAnalysis")
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
    png(file="plot3.png")
    
    # generate plot
    with(df, plot(datetime, Sub_metering_1
                  ,type="l"
                  ,fg="black"
                  ,col="black"
                  ,xlab=""
                  ,ylab="Energy sub metering"
                  )
         )
    with(df, points(datetime, Sub_metering_2
                  ,type="l"
                  ,col="red")
         )
    with(df, points(datetime, Sub_metering_3
                    ,type="l"
                    ,col="blue")
    )
    legend("topright", lty=1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    
    # shut down png device 
    dev.off()
}
