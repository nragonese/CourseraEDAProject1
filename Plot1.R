
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

subsetdatanumber <- as.numeric(subsetdata$Global_active_power)

png("Plot_1.png", width = 480, height = 480)

hist(subsetdatanumber, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col="red")
dev.off()