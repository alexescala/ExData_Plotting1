## download and unzip file
if(!file.exists("data")) dir.create("data")
pathUrl="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
## the following works with git 3.1.1, RStudio 0.98, Windows 8.1
download.file(pathUrl,"./data/power.zip",mode="wb")
unzip("./data/power.zip",exdir="./data")

## set up parameters for loading the table
filePath="./data/household_power_consumption.txt"
colClasses<-c(rep("character",2),rep("numeric",7))
col.names<-c("Date","Time","Global_active_power","Global_reactive_power",
             "Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
skip=66637
nrows=2880
## read table
data <- read.table(filePath,sep=";",colClasses=colClasses,col.names=col.names,
                   quote="",na.strings="?",nrows=nrows,skip=skip)

#get Date and Time formatted
DateTime <- with(data,paste(Date,Time))
data$DateTime <- strptime(DateTime,format="%d/%m/%Y %H:%M:%S")

#open png device
if(!file.exists("plots")) dir.create("plots")
png(filename="./plots/plot2.png")
#plot
plot(data$DateTime,data$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")
#close png device
dev.off()