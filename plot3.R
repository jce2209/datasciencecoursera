data <- read.csv("household_power_consumption.txt", sep = ";")
data1 <- subset(data, data$Date=="1/2/2007" | data$Date =="2/2/2007")

firstdate <- which(data1$Date == "1/2/2007")
seconddate <- which(data1$Date == "2/2/2007")

data1$Date <- as.Date(data1$Date, format="%d/%m/%Y")
data1$Time <- strptime(data1$Time, format="%H:%M:%S")
data1[firstdate,"Time"]<- format(data1[firstdate,"Time"], "2007-02-01 %H:%M:%S")
data1[seconddate,"Time"] <- format(data1[seconddate,"Time"], "2007-02-02 %H:%M:%S")

png("plot3.png")

plot(data1$Time, data1$Sub_metering_1, type="n",xlab="",ylab="Energy sub metering")
with(data1,lines(Time,as.numeric(as.character(Sub_metering_1))))
with(data1,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
with(data1,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))
legend("topright", lty=1, col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.off()
