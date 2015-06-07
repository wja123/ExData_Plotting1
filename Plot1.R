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

png("plot1.png",width = 480,height = 480)
hist(dfile$Global_active,xlab="Global Active Power (kilowatts)",col="Red", main = "Global Active Power")
dev.off() 
