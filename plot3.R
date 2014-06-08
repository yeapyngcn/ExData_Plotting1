## Preparing the environment
setwd("~/Downloads/Data_Scientist")
library(data.table)

## Only read the dates that are required from file
rawfile <- file("household_power_consumption.txt", "r")
cat(grep("(^Date)|(^[1|2]/2/2007)",readLines(rawfile), value=TRUE), sep="\n", file="filtered.txt")
close(rawfile)
dt <- read.csv2("filtered.txt", header = TRUE, sep = ";", na.strings="?", as.is=TRUE)

## Convert the columns that are needed
dt <- transform(dt, Sub_metering_1=as.numeric(Sub_metering_1), Sub_metering_2=as.numeric(Sub_metering_2), Sub_metering_3=as.numeric(Sub_metering_3))
dt$DateTime <- strptime(paste(dt[,"Date"], dt[, "Time"]), format="%d/%m/%Y %H:%M:%S")

## Make the plots
png("plot3.png", width=480, height=480)
plot(dt[, "DateTime"], dt[, "Sub_metering_1"], type="l", xlab="", ylab="Energy sub metering")
lines(dt[, "DateTime"], dt[, "Sub_metering_2"], type="l", col="red")
lines(dt[, "DateTime"], dt[, "Sub_metering_3"], type="l", col="blue")
legend("topright", lwd=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
