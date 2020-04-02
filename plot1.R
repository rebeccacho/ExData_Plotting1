#read in Individual household electric power consumption Data Set
#UCI ML Repository
#read from zip file separated by ; and select on Date = 1/2/2007 or 2/2/2007
temp <- tempfile()
download.file("https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip",temp)
pcons <- subset(read.csv(unz(temp, "household_power_consumption.txt"), sep=';', 
                         header=TRUE, stringsAsFactors=FALSE),
                Date=="1/2/2007"|Date=="2/2/2007")
unlink(temp)

#plot global active power
gap<-as.numeric(pcons$Global_active_power)

#create and copy plot to plot1
hist(gap, main = "Global Active Power", col="red",
     xlab = "Global Active Power (kilowatts)")
dev.copy(png, file="plot1.png", width = 480, height = 480, units = "px")
dev.off()