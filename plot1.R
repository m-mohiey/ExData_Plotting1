#================== Course 4: Exploratory Data Analysis ===============
#================== Course Project 1  =================================

#===== First Plot Script =========

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

#Plotting the first figure Hist of glopal active power
windows()

with(housepower,hist(Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)"))

#writing result to plot1.png device

dev.copy(png,filename="plot1.png",width=480,height=480,units="px")
dev.off()