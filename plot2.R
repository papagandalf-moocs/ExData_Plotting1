data <- read.table("household_power_consumption.txt", header=T, sep=";")

# transform date/time elements respectively
data$Date <-as.Date(data$Date, format="%d/%m/%Y")
data <- transform(data, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")

# subset the data from 2007/02/01 and 2007/02/02
data <- data[(data$Date=="2007-02-01") | (data$Date=="2007-02-02"),]

# and global active power as numbers
data$Global_active_power <- as.numeric(as.character(data$Global_active_power))

#plot 2
plot(data$timestamp,data$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()
