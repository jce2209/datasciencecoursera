data <- read.csv("household_power_consumption.txt", sep = ";")
data1 <- subset(data, data$Date=="1/2/2007" | data$Date =="2/2/2007")

firstdate <- which(data1$Date == "1/2/2007")
seconddate <- which(data1$Date == "2/2/2007")

data1$Date <- as.Date(data1$Date, format="%d/%m/%Y")
data1$Time <- strptime(data1$Time, format="%H:%M:%S")
data1[firstdate,"Time"]<- format(data1[firstdate,"Time"], "2007-02-01 %H:%M:%S")
data1[seconddate,"Time"] <- format(data1[seconddate,"Time"], "2007-02-02 %H:%M:%S")

png("plot2.png")

plot(data1$Time,as.numeric(as.character(data1$Global_active_power)),
     type="l",xlab="",ylab="Global Active Power (kilowatts)")
title(main="Energy sub-metering")

dev.off()
