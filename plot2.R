# Programming Assignment 1: plot2.R
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
#Plot 2
#####
png(filename = "plot2.png")
plot(myData$DateTime, myData$Global_active_power,
     type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = "")
dev.off()
