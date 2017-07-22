setwd("~/R")
library(sqldf)
# 
# This section is about creating data directory. 
# Next step is to download file and unzip data
# As program maybe run mutiple times, there are a few checks to prevent repeat downloads and unzipping
#
if(!file.exists("~/R/EXpData")){dir.create("~/R/ExpData")}
fileurl <-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipFile <- "~/R/ExpData/household.zip"


if (!file.exists(zipFile)){
  download.file(fileurl,destfile = zipFile, method = "curl")
  unzip(zipFile, exdir = "~/R/ExpData")
}

file = "household_power_consumption.txt"
dBase <- read.csv.sql(file, sep= ";", header = TRUE,
                      sql='select * from file where "Date"="1/2/2007" or "Date" ="2/2/2007"')
closeAllConnections()



########## Plot 2 ############
png(filename="Plot2.png")
x <- strptime(paste(dBase$Date, dBase$Time, sep=''),"%d/%m/%Y %H:%M:%S")
y1 <- as.numeric(dBase$Global_active_power)
label1 = "Global Active Power(kilowatts)"
plot(x, y1, type="l",ylim=c(0,max(y1)), xlab='',ylab = label1)
dev.off()