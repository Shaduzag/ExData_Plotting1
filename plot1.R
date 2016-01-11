setwd("D:/R/Coursera")
power <- read.csv("household_power_consumption.txt",header = T, sep = ";",stringsAsFactors = FALSE, na.strings ="?")
power$Global_active_power <- as.numeric(power$Global_active_power) # convert to numeric
power$Date <- as.Date(power$Date,"%d/%m/%Y") #convert to date format
power_subset <- power[power$Date=="2007-02-01"|power$Date=="2007-02-02",] # subset the 2 days
with(power_subset,hist(Global_active_power,main = "Global Active Power",
                              xlab = "Global Active Power (kilowatts)",col = "red"))

dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()
