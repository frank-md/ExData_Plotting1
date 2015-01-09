library(data.table)
# read in data, warning here: for sed to work on windows, one need to install Rtools 
#for windows.
df1 <- fread (paste("sed '1p;/^[1,2]\\/2\\/2007/!d'","household_power_consumption.txt"), na.strings = c("?", ""))
# create a DateTime column
df1$DateTime <- paste(df1$Date,df1$Time)
library(dplyr)
# need to filter out days with 11,12,21,22
df1$Date <- as.Date(df1$Date, "%d/%m/%Y")
dff <- filter(df1, Date == "2007-02-01" | Date == "2007-02-02")
# convert DateTime string to Posixct date time format as a new column
pdt <- strptime(dff$DateTime, format= "%d/%m/%Y %H:%M:%S")
df <- cbind(dff,pdt) # 2880 obs

#plot4
df$Global_reactive_power <- as.numeric(df$Global_reactive_power)
df$Voltage <- as.numeric(df$Voltage)

par(mfrow=c(2,2))
plot(df$pdt,df$Global_active_power,type="l", ylab="Global Active Power(kilowatts)",xlab="")
plot(df$pdt,df$Voltage,type="l", ylab="Voltage",xlab="datetime") 
plot(df$pdt,df$Sub_metering_1,type="l", ylab="Energy sub metering",xlab="")
lines(df$pdt,df$Sub_metering_2,col="red")
lines(df$pdt,df$Sub_metering_3,col="blue")
legend("topright", legend =c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),pch="",lwd=1,col =c("black","red","blue"))
plot(df$pdt,df$Global_reactive_power,type="l", ylab="Global_reactive_power",xlab="datetime")
# png file
png(filename="plot4.png")
par(mfrow=c(2,2))
plot(df$pdt,df$Global_active_power,type="l", ylab="Global Active Power(kilowatts)",xlab="")
plot(df$pdt,df$Voltage,type="l", ylab="Voltage",xlab="datetime")
plot(df$pdt,df$Sub_metering_1,type="l", ylab="Energy sub metering",xlab="")
lines(df$pdt,df$Sub_metering_2,col="red")
lines(df$pdt,df$Sub_metering_3,col="blue")
legend("topright", legend =c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),pch="",lwd=1,col =c("black","red","blue"))
plot(df$pdt,df$Global_reactive_power,type="l", ylab="Global_reactive_power",xlab="datetime")
dev.off()