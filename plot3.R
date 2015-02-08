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

# Define colors to be used for Sub_metering
plot_colors <- c("black","red","blue")

## Plot histogram using the subset.
png(file="plot3.png",width = 480, height = 480, units = "px", pointsize = 12, bg="transparent")
plot( Dt_Time,Sub_metering_1, type = "l", ylab= "Energy sub metering", xlab= "")
lines(Dt_Time,Sub_metering_2, type="l", col=plot_colors[2]) 
lines(Dt_Time,Sub_metering_3, type="l", col=plot_colors[3]) 
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=plot_colors,
        lty=1:3,xjust = 1, yjust = 1)
dev.off()
detach(mydt_data)