## Preparing the environment
setwd("~/Downloads/Data_Scientist")
library(data.table)

## Only read the dates that are required from file
rawfile <- file("household_power_consumption.txt", "r")
cat(grep("(^Date)|(^[1|2]/2/2007)",readLines(rawfile), value=TRUE), sep="\n", file="filtered.txt")
close(rawfile)
dt <- read.csv2("filtered.txt", header = TRUE, sep = ";", na.strings="?", as.is=TRUE)

## Convert the columns that are needed
dt <- transform(dt, Sub_metering_1=as.numeric(Sub_metering_1), Sub_metering_2=as.numeric(Sub_metering_2), Sub_metering_3=as.numeric(Sub_metering_3), Voltage=as.numeric(Voltage), Global_active_power=as.numeric(Global_active_power), Global_reactive_power=as.numeric(Global_reactive_power))
dt$Datetime <- strptime(paste(dt[,"Date"], dt[, "Time"]), format="%d/%m/%Y %H:%M:%S")

## Make the plots
png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))

## Plot1
plot(dt[, "Datetime"], dt[, "Global_active_power"], type="l", xlab="", ylab="Global Active Power (kilowatts)")
## Plot2
plot(dt[, "Datetime"], dt[, "Voltage"], type="l", xlab="datetime", ylab="Voltage")
## Plot3
plot(dt[, "Datetime"], dt[, "Sub_metering_1"], type="l", xlab="", ylab="Energy sub metering")
lines(dt[, "Datetime"], dt[, "Sub_metering_2"], type="l", col="red")
lines(dt[, "Datetime"], dt[, "Sub_metering_3"], type="l", col="blue")
legend("topright", lwd=1, bty="n", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
## Plot4
plot(dt[, "Datetime"], dt[, "Global_reactive_power"], type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()

