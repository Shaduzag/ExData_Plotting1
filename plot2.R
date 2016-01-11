setwd("D:/R/Coursera")
power <- read.csv("household_power_consumption.txt",header = T, sep = ";",stringsAsFactors = FALSE, na.strings ="?")
power$Global_active_power <- as.numeric(power$Global_active_power) # convert to numeric
power$newtime <- paste(power$Date, power$Time)
power$Date <- strptime(power$Date,"%d/%m/%Y") #convert to date format
power$Time <- strptime(power$Time,"%H:%M:%S") # convert to time
power$newtime <- strptime(power$newtime,"%d/%m/%Y %H:%M:%S") # convert to a global time
power_subset <- power[power$Date=="2007-02-01"|power$Date=="2007-02-02",] # subset the 2 days
rownames(power_subset) <- 1:nrow(power_subset) #Number rows in subsets
lang <- Sys.getlocale(category = "LC_TIME") #save local language setting
Sys.setlocale("LC_TIME","English") #set local in english
with(power_subset,plot(newtime, Global_active_power,main = "Global Active Power",type = "l",
                       xlab="", ylab = "Global Active Power (kilowatts)", col = "black", axes = T))
Sys.setlocale("LC_TIME",lang) #restore language setting

dev.copy(png, file = "plot2.png", width = 480, height = 480)  #Copy plot to a PNG file
dev.off()  # close the PNG device
