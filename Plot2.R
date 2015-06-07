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

dfile$Day<-format(dfile$Date,"%a")
dfile$Day <-factor(dfile$Day)

png("plot2.png", width = 480, height = 480)
dfile$Otime<-as.POSIXct(paste(dfile$Date, dfile$Time), format="%Y-%m-%d %H:%M:%S")

plot(dfile$Otime,dfile$Global_active_power, xlab="",ylab="Global Active Power (kilowatts)", type="l")

dev.off() 
