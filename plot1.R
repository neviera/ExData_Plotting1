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

#open PGN device
png(filename = "plot1.png", width=480, height=480, units = "px")

#plot1
hist(sData$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
dev.off(which = dev.cur())
}
