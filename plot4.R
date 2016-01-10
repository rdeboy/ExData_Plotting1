##############################
## begin code to GET THE DATA

# downloaded the whole text file (from a link in my fork) to my working directory
# read.csv for first 500,000 lines
energy <- read.csv("household_power_consumption.txt", sep=";", na.strings="?", nrows=500000)
#> names(energy)    [1] "Date"                  "Time"                  "Global_active_power"   "Global_reactive_power"     [5] "Voltage"               "Global_intensity"      "Sub_metering_1"        "Sub_metering_2"       [9] "Sub_metering_3"
# Note that the format of Date is dd/mm/yyyy
energy.Feb1 <- subset(energy, Date=="1/2/2007", select=Date:Sub_metering_3)
energy.Feb2 <- subset(energy, Date=="2/2/2007", select=Date:Sub_metering_3)
energy.2day <- rbind(energy.Feb1,energy.Feb2)

#dim(energy.Feb1)   [1] 1440    9
#dim(energy.Feb2)   [1] 1440    9
#dim(energy.2day)   [1] 2880    9

dates <- energy.2day$Date
dates <- as.character(dates)
times <- energy.2day$Time
times <- as.character(times)
x <- paste(dates, times)
# Note that the format of Date is dd/mm/yyyy
y <- strptime(x, "%d/%m/%Y %H:%M:%S")
# add y as a new column in the working data frame
energy.2day$datetime = y

## end code to GET THE DATA
#############################
## begin code for plot4.png

## Open a png device and create file in my working directory
png(file="plot4.png",  width = 480, height = 480, units = "px")

## Create plot and send to a file (no plot appears on screen)
par(mfcol = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 0, 0))

## (column 1, row 1) copy code from plot2.png
with(energy.2day, plot(datetime, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))

## (column1, row 2) copy code from plot3.png
with(energy.2day, {
     plot(datetime, Sub_metering_1, type="l", col="black", xlab="", ylab="Energy sub metering")
     lines(datetime, Sub_metering_2, type="l", col="red")
     lines(datetime, Sub_metering_3, type="l", col="blue")
     legend("topright", lwd=3, col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
})

## (column 2, row 1) new code
with(energy.2day, plot(datetime, Voltage, type="l"))

## (column 2, row 2) new code
with(energy.2day, plot(datetime, Global_reactive_power, type="l"))

## Close the png file device
dev.off()

## end code for plot4.png
#############################