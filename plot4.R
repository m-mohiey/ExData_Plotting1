#================== Course 4: Exploratory Data Analysis ===============
#================== Course Project 1  =================================

#===== Fourth Plot Script =========

# First part to check if data loaded to memory

if(!exists("housepower")){
  if(!file.exists("household_power_consumption.zip")){download.file("https://d396qusza40orc.cloudfront.net/exdata/data/household_power_consumption.zip","household_power_consumption.zip")}
  if(!file.exists("household_power_consumption.txt")){unzip("household_power_consumption.zip")}
  library(sqldf)
  housepower<-read.csv.sql("household_power_consumption.txt",sep=";",sql = "SELECT * FROM file WHERE (Date=='1/2/2007' OR Date=='2/2/2007')",row.names = F)
  write.csv(housepower,"tmp.txt",row.names = F)
  housepower<-read.csv("tmp.txt",na.strings = "?")
  file.remove("tmp.txt")
  housepower$Date<-as.Date(housepower$Date)
}

#Plotting the fourth figure 
windows()
par(mfrow=c(2,2))
with(housepower,plot(Global_active_power,type = "l",lwd=2,xaxt="n",xlab = "",ylab = "Global Active Power"))
axis(1, c(1,2880/2,2880), c("Thu","Fri","Sat"))
plot(housepower$Voltage,type="l",lwd=2,xaxt="n",xlab = "datetime",ylab = "Voltage")
axis(1, c(1,2880/2,2880), c("Thu","Fri","Sat"))
plot(housepower$Sub_metering_1,type = "l",xaxt="n",xlab = "",ylab = "Energy sub metering")
lines(housepower$Sub_metering_2,col="red")
lines(housepower$Sub_metering_3,col="blue")
axis(1, c(1,2880/2,2880), c("Thu","Fri","Sat"))
legend("topright",col=c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,text.width = strwidth("90000000,000,000"),bty = "n")
plot(housepower$Global_reactive_power,type="l",lwd=2,xaxt="n",xlab = "datetime",ylab = "Global_reactive_power")
axis(1, c(1,2880/2,2880), c("Thu","Fri","Sat"))
#writing result to plot4.png device

dev.copy(png,filename="plot4.png",width=480,height=480,units="px")
dev.off()