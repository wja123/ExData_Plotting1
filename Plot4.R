#Save the URL
zipurl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
#Download the zipfile
fzip<-download.file(zipurl,destfile="./household_power_consumption.zip",method="curl")
#Unzipped the file into the current drive
unzip("./household_power_consumption.zip", list = FALSE, overwrite = TRUE,
      junkpaths = FALSE, exdir = ".", unzip = "internal",
      setTimes = FALSE)

#Save the data as dfile
dfile<-read.table("./household_power_consumption.txt",sep=";",na.strings="?",header=T)
dfile$Date<-as.Date(dfile$Date,"%d/%m/%Y")
dfile<-dfile[as.Date(dfile$Date)>=as.Date('2007/02/01') & as.Date(dfile$Date) <= as.Date('2007/02/02'),]
dfile$Otime<-as.POSIXct(paste(dfile$Date,dfile$Time), format="%Y-%m-%d %H:%M:%S")

#Creates the image
png("plot4.png",width = 480,height = 480)

#Creates the layout
layout(matrix(1:4,ncol=2))

#Top left plot
plot(dfile$Otime,dfile$Global_active_power, xlab="",ylab="Global Active Power", type="l") #top left plot

#bottom left plot
plot(dfile$Otime,dfile$Sub_metering_1,type="l",xlab="",ylab="Energy Sub Metering")
lines(dfile$Otime,dfile$Sub_metering_2,type="l",col="red")
lines(dfile$Otime,dfile$Sub_metering_3,type="l",col="blue")
legend(x="topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),border="black",lty=c(1,1,1),lwd=c(2.5,2.5,2.5),col=c("black","red","blue"))

#top right plot
plot(dfile$Otime,dfile$Voltage,type="l",xlab="datetime",ylab="Voltage")

#bottom right plot
br<-plot(dfile$Otime,dfile$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")

dev.off() 
