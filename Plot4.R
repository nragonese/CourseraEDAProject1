

# URL with dataset
dataURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

#know where you're downloading file to
getwd()

#only download if file doesn't exists
if(!file.exists("Power Consumption")) {
  dir.create("Power Consumption")
  
  fp <- "./Power Consumption/Power Consumtion.zip" #File Path for the data
  
  download.file(dataURL, fp)
  unzip(fp,exdir = "C:/UserData/OneDrive - Red Ventures/Documents") #function to unzip file
  file.remove(fp) #Removes the zip file because we've already imported the data
}

powerconsumption <- read.table("C:/UserData/OneDrive - Red Ventures/Documents/household_power_consumption.txt", sep=";", header = TRUE,
                               stringsAsFactors = FALSE, dec = ".")

subsetdata <- subset(powerconsumption, powerconsumption$Date %in% c("1/2/2007","2/2/2007")) #we only need these 2 days of data

datetime <- strptime(paste(subsetdata$Date,subsetdata$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

png("plot2.png", width = 480, height = 480)
par(mfrow=c(2,2), mar=c(4,4,2,1))

with(subsetdata,{
  plot(datetime,subsetdata$Global_active_power, type = "l", ylab = "Global Active Power", xlab = " ")
  plot(datetime,subsetdata$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
  plot(datetime,subsetdata$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = " ")
  lines(datetime,subsetdata$Sub_metering_2,col='Red')
  lines(datetime,subsetdata$Sub_metering_3,col='Blue')
  legend("topright", col=c("black", "red", "blue"), 
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),lty = 1, lwd = 2)
  plot(datetime,subsetdata$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Energy sub metering")
  
})

dev.off()