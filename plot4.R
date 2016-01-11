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
old.par <- par(no.readonly = TRUE) #save graph settings
par(mfcol = c(2, 2))


#Plot1

with(power_subset,plot(newtime, Global_active_power,main = "Global Active Power",type = "l",
                       xlab="", ylab = "Global Active Power (kilowatts)", col = "black", axes = T))

#plot2
with(power_subset,plot(newtime, Sub_metering_1,main = "",type = "l",
                       xlab="", ylab = "Energy sub metering", col = "black", axes = T))
lines(power_subset$newtime, power_subset$Sub_metering_2, col = "red")
lines(power_subset$newtime, power_subset$Sub_metering_3, col = "blue")
lines(DateTime, Sub_metering_3, col = "blue")
legend("topright", bty = "n", col = c("black", "red", "blue"), cex = 0.7,
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),lwd = 1)
#plot 3
plot(power_subset$newtime, power_subset$Voltage,type = "l",xlab = "datetime", ylab = "Voltage")

#plot 4
plot(power_subset$newtime, power_subset$Global_reactive_power, type = "l", col = "black",
     xlab = "datetime", ylab = colnames(power_subset)[4])


Sys.setlocale("LC_TIME",lang) #restore language setting
par(old.par) # restore graph settings

dev.copy(png, file = "plot4.png", width = 480, height = 480)  #Copy plot to a PNG file
dev.off()  # close the PNG device

