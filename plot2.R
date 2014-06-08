## Preparing the environment
setwd("~/Downloads/Data_Scientist")
library(data.table)

## Only read the dates that are required from file
rawfile <- file("household_power_consumption.txt", "r")
cat(grep("(^Date)|(^[1|2]/2/2007)",readLines(rawfile), value=TRUE), sep="\n", file="filtered.txt")
close(rawfile)
dt <- read.csv2("filtered.txt", header = TRUE, sep = ";", na.strings="?", as.is=TRUE)

## Convert the columns that are needed
dt <- transform(dt, Global_active_power=as.numeric(Global_active_power))
dt$DateTime <- strptime(paste(dt[,"Date"], dt[, "Time"]), format="%d/%m/%Y %H:%M:%S")

## Make the plots
png("plot2.png", width=480, height=480)
plot(dt[, "DateTime"], dt[, "Global_active_power"], type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
