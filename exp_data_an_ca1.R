library(dplyr)

DT <- read.table("./household_power_consumption.txt", header=T,stringsAsFactors=FALSE, sep = ";")
#house_power <- tbl_df(house_power)
house_power <- data.frame(DT)

#head(house_power)
house_power$Date = as.Date(house_power$Date,"%d/%m/%Y")
#We will only be using data from the dates 2007-02-01 and 2007-02-02.
#Date: Date in format dd/mm/yyyy
mydates <- as.Date(c("02/02/2007", "01/02/2007"), "%d/%m/%Y")
subSetData <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]
period_house_power <- with(house_power, house_power[(house_power$Date ==  mydates[1])|(house_power$Date ==  mydates[2]),])
period_house_power$Time = strptime(paste(period_house_power$Date, period_house_power$Time), "%Y-%m-%d %H:%M:%S")

#class(house_power$Date)
#head(period_house_power)
#View( period_house_power)

glob_act_power <- as.numeric(period_house_power$Global_active_power)
power_time <- period_house_power$Time

#plot 1
hist(glob_act_power, col="red", xlim=c(0,8), las=2, breaks=20, xlab = "Global Active Power (kilowatts)")
dev.copy(png,'plot1.png')
dev.off()
#plot 2
plot( power_time,glob_act_power, type = "l", ylab = "Global Active Power (kilowatts)" )
dev.copy(png,'plot2.png')
dev.off()
#plot 3
plot( power_time, as.numeric( period_house_power$Sub_metering_1), type = "l",xlab = "", ylab = "Energy sub metering" )
lines( power_time, as.numeric( period_house_power$Sub_metering_2), col = "red")
lines( power_time, as.numeric( period_house_power$Sub_metering_3), col = "blue")
legend(x =  "topright", inset=c(.1,0), legend = c("sub_metering_1", "sub_metering_2","sub_metering_3"), lty=c(1,1), lwd=c(2.5,2.5), col=c("black", "red","blue"))
dev.copy(png,'plot3.png')
dev.off()
#plot 4
par(mfrow=c(2,2))
plot( power_time,glob_act_power, type = "l", ylab = "Global Active Power (kilowatts)" )
plot( power_time, as.numeric( period_house_power$Voltage), type = "l",xlab = "datetime", ylab = "Voltage" )
plot( power_time, as.numeric( period_house_power$Sub_metering_1), type = "l",xlab = "", ylab = "Energy sub metering" )
lines( power_time, as.numeric( period_house_power$Sub_metering_2), col = "red")
lines( power_time, as.numeric( period_house_power$Sub_metering_3), col = "blue")
legend(x =  "topright", inset=c(.1,0), legend = c("sub_metering_1", "sub_metering_2","sub_metering_3"), lty=c(1,1), lwd=c(2.5,2.5), col=c("black", "red","blue"))
plot( power_time, as.numeric( period_house_power$Global_reactive_power), type = "l",xlab = "datetime", ylab = "global_reactive_power" )
dev.copy(png,'plot4.png')
dev.off()
