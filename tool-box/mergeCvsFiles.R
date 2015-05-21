#Example need to tailor accordingly
#http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv
#http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv

mergeCvsFiles <- function(fileA, fileB, xLabel, yLabel){
  edu <- read.csv(fileA)
  gdp <- read.csv(fileB, skip=5, header = FALSE, nrows=190)
  gdpClean <- gdp[ , c(1,2,4,5)]
  merged <- merge(edu, gdpClean,by.x=xLabel, by.y=yLabel)
  ordered <- merged[order(-merged$V2),]
  ordered
}