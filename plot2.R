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

png(file="plot2.png", width=480, height=480)
yLabel = "Global Active Power (kilowatts)"
plot(data$dateTime, data$Global_active_power/1000*2, type="l", xlab="", ylab=yLabel)
dev.off()