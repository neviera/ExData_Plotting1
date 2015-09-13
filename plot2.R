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
  
  library(sqldf)
  
  #read only selected rows
  sData<-read.csv.sql(file, sql="select * from file where Date='1/2/2007' or Date='2/2/2007'", header=TRUE, sep=";", colClasses=colCl)
  closeAllConnections()
  
  #convert Date to date format
  tempTime<-paste(sData$Date,sData$Time)
  sData$DateTime<-strptime(tempTime,format="%d/%m/%Y %H:%M:%S", tz="")
  
  #open PGN device
  png(filename = "plot2.png", width=480, height=480, units = "px")
  
  #plot2
  plot(sData$DateTime,sData$Global_active_power, type = "l", xlab = "", ylab="Global Active Power (kilowatts)")
  
  dev.off(which = dev.cur())
}