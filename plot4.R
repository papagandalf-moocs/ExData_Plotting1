data <- read.table("household_power_consumption.txt", header=T, sep=";")

# transform date/time elements respectively
data$Date <-as.Date(data$Date, format="%d/%m/%Y")
data <- transform(data, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")

# subset the data from 2007/02/01 and 2007/02/02
data <- data[(data$Date=="2007-02-01") | (data$Date=="2007-02-02"),]

# and global active power, global reactive power and voltage as numbers
data$Global_active_power <- as.numeric(as.character(data$Global_active_power))
data$Voltage <- as.numeric(as.character(data$Voltage))
data$Sub_metering_1 <- as.numeric(as.character(data$Sub_metering_1))
data$Sub_metering_2 <- as.numeric(as.character(data$Sub_metering_2))
data$Sub_metering_3 <- as.numeric(as.character(data$Sub_metering_3))

#plot 4 (four plots in one image)
par(mfrow=c(2,2))
plot(data$timestamp,data$Global_active_power, type="l", xlab="", ylab="Global Active Power")
plot(data$timestamp,data$Voltage, type="l", xlab="datetime", ylab="Voltage")
plot(data$timestamp,data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(data$timestamp,data$Sub_metering_2,col="red")
lines(data$timestamp,data$Sub_metering_3,col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), bty="n", cex=.5) #bty removes the box, cex shrinks the text, spacing added after labels so it renders correctly
plot(data$timestamp,data$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()