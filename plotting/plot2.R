# This function loads the Electronic Power Construction dataset
# Subsets the data to be for the days 1/2/2007 and 2/2/2007
# Compines the Data and Time fiels into a dateTime true date format
#
# It then plots a line chart of the Global Active Power through the 
# two days
#
# Please make sure the "household_power_consumption.txt" file is in your 
# working directory

plot2 <- function(){
  
  epc.full <- read.delim(file = "household_power_consumption.txt",  sep = ";", header = TRUE, na.strings='?')
  epc <- subset(epc.full, Date == "1/2/2007" | Date == "2/2/2007")
  epc$DateTime <- as.POSIXct(paste(epc$Date, epc$Time), format="%d/%m/%Y %H:%M:%S")   
  
  par(mfcol = c(1,1))
  png(filename='plot2.png',width=480,height=480,units='px', bg='transparent')
  plot(epc$DateTime, epc$Global_active_power, type="n", ylab='Global Active Power (kilowatts)', xlab='')
  lines(epc$DateTime, epc$Global_active_power)
  
  hide <- dev.off()
}
