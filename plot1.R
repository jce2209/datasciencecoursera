data <- read.csv("household_power_consumption.txt", sep = ";")

as.Date(data$Date)
data1 <- subset(data, data$Date=="1/2/2007" | data$Date =="2/2/2007")

png("plot1.png")

hist(as.numeric(as.character(data1$Global_active_power)),col="red",
     main="Global Active Power",xlab="Global Active Power(kilowatts)")

dev.off()
