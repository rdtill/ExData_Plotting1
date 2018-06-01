# Programming Assignment 1
path <- rstudioapi::getSourceEditorContext()$path
indeces <- gregexpr(pattern = "/", text = path)[[1]]
path <- substr(x = path, start = 1, stop = last(indeces))
setwd(path)
if(!dir.exists("data")) { dir.create("data") }
setwd("./data")


#reading in the data
myData <- read.table("household_power_consumption.txt", 
                     sep = ";", header = TRUE, na.strings = "?",
                     stringsAsFactors = FALSE)


#converting Date column to "Date" objects, as well as subsetting the data for date range
#2/1/2007 - 2/2/2007
myData$Date <- as.Date(myData$Date, "%d/%m/%Y")
myData <- myData[between(myData$Date, as.Date("2007-02-01"), as.Date("2007-02-02")), ]
myData <- cbind(DateTime = paste(myData$Date, myData$Time), myData)
myData$DateTime <- as.character(myData$DateTime)
myData$DateTime <- as.POSIXlt(myData$DateTime)


#####
#Plot 4
#####
png(filename = "plot4.png")
par(mfrow = c(2,2))
#1
plot(myData$DateTime, myData$Global_active_power,
     type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = "")

#2
plot(myData$DateTime, myData$Voltage,
     xlab = "datetime", ylab = "Voltage",
     type = "l")

#3
plot(myData$DateTime, myData$Sub_metering_1, type = "l", 
     ylab = "Energy sub metering", xlab = "")
lines(myData$DateTime, myData$Sub_metering_2, col = "red")
lines(myData$DateTime, myData$Sub_metering_3, col = "blue")
legend(x = "topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_Metering_1", "Sub_Metering_2", "Sub_Metering_3"),
       bty = "n")

#4
plot(myData$DateTime, myData$Global_reactive_power,
     xlab = "datetime", ylab = "Global_reactive_power",
     type = "l")
dev.off()





