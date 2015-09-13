#setting system locale, it helps to display plot axis properly
Sys.setlocale(category = "LC_ALL", locale = "english")

file<-"E:/Julius/Studies/Data Science Specialization/Exploratory Data Analysis/Week1Project/household_power_consumption.txt"
#check if file exists
folder<-"E:/Julius/Studies/Data Science Specialization/Exploratory Data Analysis/Week1Project/ExData_Plotting1"

if((file.exists(file))&(dir.exists(folder))){
  setwd(folder)
  
  #get column classes
  firstRows <- read.table(file, header = TRUE, nrows = 5, sep=";", dec=".")
  colCl <- sapply(firstRows, class)
  
  #read only selected rows
  sData<-read.csv.sql(file, sql="select * from file where Date='1/2/2007' or Date='2/2/2007'", header=TRUE, sep=";", colClasses=colCl)
  closeAllConnections()
  
  #convert Date to date format
  tempTime<-paste(sData$Date,sData$Time)
  datetime<-strptime(tempTime,format="%d/%m/%Y %H:%M:%S", tz="")
  
  #open PGN device
  png(filename = "plot4.png", width=480, height=480, units = "px")
  
  #save settings
  old.par<-par(no.readonly = T)
  
  #set to draw charts in 2x2 matrix columnwise
  par(mfcol=c(2,2))
  
  #plot first chart (topleft)
  plot(datetime,sData$Global_active_power, type = "l", xlab = "", ylab="Global Active Power")
  
  #plot second chart (bottom left)
  #get range for y axis
  yrange<-range(c(sData$Sub_metering_1, sData$Sub_metering_2, sData$Sub_metering_3))
  #plot base with first line for submetering_1
  plot(datetime,sData$Sub_metering_1, ylim=yrange, type = "l", col="black", xlab="", ylab="Energy sub metering")
  #add line for submetering_2
  lines(datetime,sData$Sub_metering_2, col="red")
  #add line for submetering_3
  lines(datetime,sData$Sub_metering_3, col="blue")
  #set legend
  legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
          lwd=c(1,1,1), col=c("black","red","blue"), bty="n")
  
  #plot thrird chart (top right)
  plot(datetime, sData$Voltage,type="l", ylab="Voltage")
  
  #plot fourth chart (bottom right)
  plot(datetime, sData$Global_reactive_power, type="l", ylab = "Global_reactive_power" )
  
  #restore settings
  par(old.par)
  dev.off(which = dev.cur())
}