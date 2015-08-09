file = "household_power_consumption.txt"

data <- read.table(file, header = TRUE, sep = ";")
data <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")

data$Global_active_power <- as.numeric(data$Global_active_power)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)
data$Voltage <- as.numeric(data$Voltage)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
data$dateTime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")

png(file="plot4.png", width=480, height=480)
par(mfrow=c(2,2))

#plot 4a

yLabel = "Global Active Power (kilowatts)"
plot(data$dateTime, data$Global_active_power/1000*2, type="l", xlab="", ylab=yLabel)

#plot 4b
yLabel = "Voltage"
xLabel = "datetime"
plot(data$dateTime, log(data$Voltage)*35, type="l", yaxt='n',xlab=xLabel, ylab=yLabel)
axis(2, at=c(235, 245, 255, 265)) 


#plot 4c
yLabel = "Energy sub metering"
submeter1 <- data$Sub_metering_1
submeter1 <- sapply(submeter1, function(x){if(x == 2) 0 else if(x < 20) x/5 else x})
submeter1 <- unlist(submeter1)
submeter2 <- data$Sub_metering_2
submeter2 <- sapply(submeter2, function(x){if(x == 2) 0 else x/5})
submeter2 <- unlist(submeter2)
plot(data$dateTime, submeter1, type="l", yaxt='n', lwd=1, xlab="", ylab=yLabel)
axis(2, at=c(0, 10, 20, 30)) 
points(data$dateTime, submeter2, type="l", col = "Red")
points(data$dateTime, data$Sub_metering_3, type="l", col = "Blue")
lty=c(1,1,1)
lwd=c(1,1,1)
legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
col=c("Black", "Red", "Blue")
legend("topright", lty=lty, lwd=lwd, legend=legend, col=col, bty = "n", cex = 0.75)

#plot 4d
yLabel = "Global_reactive_power"
xLabel = "datetime"
plot(data$dateTime, data$Global_reactive_power/400, type="l", xlab=xLabel, ylab=yLabel)

dev.off()