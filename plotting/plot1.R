# This function loads the Electronic Power Construction dataset
# Subsets the data to be for the days 1/2/2007 and 2/2/2007
# Compines the Data and Time fiels into a dateTime true date format
#
# It then plots a histogram of the Global Active Power
#
# Please make sure the "household_power_consumption.txt" file is in your 
# working directory

plot1 <- function(){
  
  epc.full <- read.delim(file = "household_power_consumption.txt",  sep = ";", header = TRUE, na.strings='?')
  epc <- subset(epc.full, Date == "1/2/2007" | Date == "2/2/2007")
  epc$DateTime <- as.POSIXct(paste(epc$Date, epc$Time), format="%d/%m/%Y %H:%M:%S")   
  
  par(mfcol = c(1,1))
  png(filename='plot1.png',width=480,height=480,units='px', bg='transparent' )
  hist(epc$Global_active_power, main = "Global Active Power", col='red', xlab='Global Active Power (kilowatts)')
  hide <- dev.off()
}


