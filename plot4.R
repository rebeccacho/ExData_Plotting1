#read in Individual household electric power consumption Data Set
#UCI ML Repository
#read from zip file separated by ; and select on Date = 1/2/2007 or 2/2/2007
temp <- tempfile()
download.file("http://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip",temp)
pcons <- subset(read.csv(unz(temp, "household_power_consumption.txt"), sep=';', 
                         header=TRUE, stringsAsFactors=FALSE),
                Date=="1/2/2007"|Date=="2/2/2007")
unlink(temp)

#prepare the data
volts<-as.numeric(pcons$Voltage)
gap<-as.numeric(pcons$Global_active_power)
grp<-as.numeric(pcons$Global_reactive_power)
sm1<-as.integer(pcons$Sub_metering_1)
sm2<-as.integer(pcons$Sub_metering_2)
sm3<-as.integer(pcons$Sub_metering_3)
dt<-paste(pcons$Date,pcons$Time, sep=" ")
mydata<-cbind(dt, sm1, sm2, sm3, gap, grp, volts)
mydata<-data.frame(mydata)
mydata$dt<-strptime(mydata$dt,"%d/%m/%Y %H:%M:%S")

# multiple base plots
par(mfrow = c(2,2))
with(mydata, {
  plot(dt, gap, type = "l", xlab="", ylab="Global Active Power")
  plot(dt, volts, type = "l", xlab="datetime", ylab="Voltage")

  plot(dt, sm1, type = "l", col = "purple", xlab = "", ylab = "Energy sub metering")
  with(mydata, points(dt, sm2, type = "l", col = "red"))
  with(mydata, points(dt, sm3, type = "l", col = "blue"))
  legend("topright", pch=45, lwd = 1, col = c("purple","red","blue"), 
         legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  plot(dt, grp, type = "l", xlab="datetime", ylab="Global_reactive_Power")
})

#copy plots to plot4.png
dev.copy(png, file="plot4.png", width = 480, height = 480, units = "px")
dev.off()