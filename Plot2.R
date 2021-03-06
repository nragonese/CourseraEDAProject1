

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
plot(datetime,subsetdata$Global_active_power,type = "l", xlab = " ", ylab = "Global Active Power(kilowatts)")
dev.off()