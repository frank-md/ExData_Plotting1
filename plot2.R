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
df <- cbind(dff,pdt)
#plot 2
plot(df$pdt,df$Global_active_power,type="l", ylab="Global Active Power(kilowatts)",xlab="")
png(filename="plot2.png")
plot(df$pdt,df$Global_active_power,type="l", ylab="Global Active Power(kilowatts)",xlab="")
dev.off()