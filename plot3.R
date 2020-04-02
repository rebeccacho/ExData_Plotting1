#read in Individual household electric power consumption Data Set
#UCI ML Repository
#read from zip file separated by ; and select on Date = 1/2/2007 or 2/2/2007
temp <- tempfile()
download.file("http://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip",temp)
pcons <- subset(read.csv(unz(temp, "household_power_consumption.txt"), sep=';', 
                         header=TRUE, stringsAsFactors=FALSE),
                Date=="1/2/2007"|Date=="2/2/2007")
unlink(temp)

#plot sub_metering_x
sm1<-as.integer(pcons$Sub_metering_1)
sm2<-as.integer(pcons$Sub_metering_2)
sm3<-as.integer(pcons$Sub_metering_3)
dt<-paste(pcons$Date,pcons$Time, sep=" ")
mydata<-cbind(dt, sm1, sm2, sm3)
mydata<-data.frame(mydata)
mydata$dt<-strptime(mydata$dt,"%d/%m/%Y %H:%M:%S")

#create and copy plot to plot3
with(mydata, {
  plot(dt, sm1, type = "l", col = "purple", xlab = "", ylab = "Energy sub metering")
  with(mydata, points(dt, sm2, type = "l", col = "red"))
  with(mydata, points(dt, sm3, type = "l", col = "blue"))
  legend("topright", pch=45, lwd = 1, col = c("purple","red","blue"), 
         legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  })

dev.copy(png, file="plot3.png", width = 480, height = 480, units = "px")
dev.off()