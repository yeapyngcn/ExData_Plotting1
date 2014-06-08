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

## Make the plots
png("plot1.png", width=480, height=480)
hist(dt[,"Global_active_power"], main="Global Active Power", xlab="Global Active Power (kilowatts)", col="RED", xlim=c(0,6), ylim=c(0,1200))
dev.off()
