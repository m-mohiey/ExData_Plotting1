#================== Course 4: Exploratory Data Analysis ===============
#================== Course Project 1  =================================

#===== Third Plot Script =========

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

#Plotting the third figure multi colored lines of Energy sub metering Vs Week day
par(mar=c(5,3,4,1))
windows()

plot(housepower$Sub_metering_1,type = "l",xaxt="n",xlab = "",ylab = "Energy sub metering")
lines(housepower$Sub_metering_2,col="red")
lines(housepower$Sub_metering_3,col="blue")
axis(1, c(1,2880/2,2880), c("Thu","Fri","Sat"))
legend("topright",col=c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,text.width = strwidth("90000000,000,000"))

#writing result to plot3.png device

dev.copy(png,filename="plot3.png",width=480,height=480,units="px")
dev.off()