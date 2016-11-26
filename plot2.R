#================== Course 4: Exploratory Data Analysis ===============
#================== Course Project 1  =================================

#===== Second Plot Script =========

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

#Plotting the second figure line of glopal active power Vs Week day
windows()

with(housepower,plot(Global_active_power,type = "l",lwd=2,xaxt="n",xlab = "",ylab = "Global Active Power (kilowatts)"))
axis(1, c(1,2880/2,2880), c("Thu","Fri","Sat"))

#writing result to plot2.png device

dev.copy(png,filename="plot2.png",width=480,height=480,units="px")
dev.off()