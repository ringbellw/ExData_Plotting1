##Download, unzip and read the file
temp <- tempfile()
fileURL1 <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL1, temp, mode = "wb")
unzip(temp, exdir = ".", list = TRUE)
data_hhc <- read.table(unzip(temp, "household_power_consumption.txt"), 
                       header = TRUE, sep = ";", na.strings = "?", dec = ".", stringsAsFactors = FALSE)
unlink(temp)

##Transform and subset the read file
sub_data <- data_hhc[data_hhc$Date %in% c("1/2/2007", "2/2/2007"), ]
sub_data$Date_Time <- strptime(paste(sub_data$Date, sub_data$Time, sep = " "), format = "%d/%m/%Y %H:%M:%S")

##Generate plot4.png
par(mfrow = c(2, 2), mar = c(5.0, 4.5, 1.5, 1.5))

#Generate plot4 topleft
plot(sub_data$Date_Time, sub_data$Global_active_power, 
     xlab = "", ylab = "Global Active Power", type = "l")

#Generate plot4 topright 
plot(sub_data$Date_Time, sub_data$Voltage, xlab = "datetime", ylab = "Voltage", type = "l")

#Generate plot4 bottomleft 
plot(sub_data$Date_Time, sub_data$Sub_metering_1, xlab = "", ylab = "Energy sub metering",
     col = "black", type = "l")

with(sub_data, {points(Date_Time, Sub_metering_2, col = "red", type = "l")
                 points(Date_Time, Sub_metering_3, col = "blue", type = "l")
    })

legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1, seg.len = 0.5, bty = "n", y.intersp = 0.6, cex = 0.8)

#Generate plot4 bottomright
plot(sub_data$Date_Time, sub_data$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power",
     col = "black", type = "l")

dev.copy(png, file = "plot4.png")
dev.off()