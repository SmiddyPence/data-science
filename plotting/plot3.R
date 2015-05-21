# This function loads the Electronic Power Construction dataset
# Subsets the data to be for the days 1/2/2007 and 2/2/2007
# Compines the Data and Time fiels into a dateTime true date format
#
# It then plots a line chart for the three sub metering readings for the 
# two days
#
# Please make sure the "household_power_consumption.txt" file is in your 
# working directory

plot3 <- function(){
  epc.full <- read.delim(file = "household_power_consumption.txt",  sep = ";", header = TRUE, na.strings='?')
  epc <- subset(epc.full, Date == "1/2/2007" | Date == "2/2/2007")
  epc$DateTime <- as.POSIXct(paste(epc$Date, epc$Time), format="%d/%m/%Y %H:%M:%S")   
    
  par(mfcol = c(1,1))
  colours <- c('black','red','blue')
  
  png(filename='plot3.png',width=480,height=480,units='px', bg='transparent')
  plot(epc$DateTime, epc$Sub_metering_1, type="n", ylab='Energy Sub Metering', xlab='')
  lines(epc$DateTime, epc$Sub_metering_1, col=colours[1])
  lines(epc$DateTime, epc$Sub_metering_2, col=colours[2])
  lines(epc$DateTime, epc$Sub_metering_3, col=colours[3])
  legend('topright', 
         legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), 
         col=colours, lwd=1)
  hide <- dev.off()
}