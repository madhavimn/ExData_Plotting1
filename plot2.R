## Read txt file - accounting for null and assign corresponging data types.
setwd("C://Users/OmVigneshwara/Documents/Madhavi/R/")
mydata <- read.table("household_power_consumption.txt",
                     header = TRUE,sep = ";",
                     na.strings=c("NA", "-", "?"),
                     colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric",
                                    "numeric","numeric"))

## Add an additional column Dt_time combining both Date and Time
mydata$Dt_Time <- paste(mydata$Date, mydata$Time)
mydata$Dt_Time <- strptime(mydata$Dt_Time, "%d/%m/%Y %H:%M:%S")

## Change the existing Date column format from character to date
mydata$Date <- as.Date(mydata$Date, "%d/%m/%Y")

## Create subset from mydata"
mydt_data<- subset(mydata, Date== as.Date("2007-02-01") | Date== as.Date("2007-02-02"))

attach(mydt_data,warn.conflicts = FALSE)
## Plot histogram using the subset.
png(file="plot2.png",width = 480, height = 480, units = "px", pointsize = 12, bg="transparent")
plot( Dt_Time,Global_active_power, type = "l", main = "Global Active Power", ylab= "Global Active Power(kilowatts)", xlab= "")
dev.off()
detach(mydt_data)