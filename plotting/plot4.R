# This function loads the Electronic Power Construction dataset
# Subsets the data to be for the days 1/2/2007 and 2/2/2007
# Compines the Data and Time fiels into a dateTime true date format
#
# It then plots 4 charts for:
# Global Active Power
# Voltage
# Energy sub meetering
# Global Reactive Power
#
# Please make sure the "household_power_consumption.txt" file is in your 
# working directory

plot4 <- function(){
  epc.full <- read.delim(file = "household_power_consumption.txt",  sep = ";", header = TRUE, na.strings='?')
  epc <- subset(epc.full, Date == "1/2/2007" | Date == "2/2/2007")
  epc$DateTime <- as.POSIXct(paste(epc$Date, epc$Time), format="%d/%m/%Y %H:%M:%S")   
  
  png(filename='plot4.png',width=480,height=480,units='px', bg='transparent')
  par(mfcol = c(2,2))
    
  plot(epc$DateTime, epc$Global_active_power, type="n", ylab='Global Active Power', xlab='')
  lines(epc$DateTime, epc$Global_active_power)
    
  colours <- c('black','red','blue')
  plot(epc$DateTime, epc$Sub_metering_1, type="n", ylab='Energy sub metering', xlab='')
  lines(epc$DateTime, epc$Sub_metering_1, col=colours[1])
  lines(epc$DateTime, epc$Sub_metering_2, col=colours[2])
  lines(epc$DateTime, epc$Sub_metering_3, col=colours[3])
  legend('topright', 
         legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), 
         col=colours, lwd=1, bty='n')
  
  plot(epc$DateTime, epc$Voltage, type="n", ylab='Voltage', xlab='datetime')
  lines(epc$DateTime, epc$Voltage)
  
  plot(epc$DateTime, epc$Global_reactive_power, type="n", ylab='Global_reactive_power', xlab='datetime')
  lines(epc$DateTime, epc$Global_reactive_power)
  
  
  hide <- dev.off()    
}