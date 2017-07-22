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



########## Plot 1 ##########
png(filename="Plot1.png")
colors = c("Red") 
y1 <- as.numeric(dBase$Global_active_power)
label1 = "Global Active Power(kilowatts)"
hist(y1, right = FALSE,  col = colors,     # set the color palette 
       main="Global Active Power", # the main title 
       xlab=label1)       # x-axis label
dev.off()

