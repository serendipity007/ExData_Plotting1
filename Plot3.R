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


########## Plot 3 ############
png(filename="Plot3.png")
colors <- c("Black", "Red","Blue")
x <- strptime(paste(dBase$Date, dBase$Time, sep=''),"%d/%m/%Y %H:%M:%S")
y3 <- as.numeric(dBase$Sub_metering_1)
y4 <- as.numeric(dBase$Sub_metering_2)
y5 <- as.numeric(dBase$Sub_metering_3)
names <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
plot(x, y3, type="l", xlab ='', ylab = "Energy sub metering", col=colors[1])
lines(x, y4, col = colors[2])
lines(x, y5, col=colors[3])
legend("topright", names, lty=1, lwd=2, cex= 0.8, col=colors)
dev.off()
