##Download, unzip and read the file
temp <- tempfile()
fileURL1 <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL1, temp, mode = "wb")
unzip(temp, exdir = ".", list = TRUE)
data_hhc <- read.table(unzip(temp, "household_power_consumption.txt"), 
                       header = TRUE, sep = ";", na.strings = "?", dec = ".",
                       stringsAsFactors = FALSE)
unlink(temp)

##Transform and subset the read file
sub_data <- data_hhc[data_hhc$Date %in% c("1/2/2007", "2/2/2007"), ]
sub_data$Date_Time <- strptime(paste(sub_data$Date, sub_data$Time, sep = " "), format = "%d/%m/%Y %H:%M:%S")

##Generate plot3.png
par(mfrow = c(1, 1), mar = c(3, 5, 2, 2))

plot(sub_data$Date_Time, sub_data$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l")

with(sub_data, {lines(Date_Time, Sub_metering_2, col = "red", type = "l")
                lines(Date_Time, Sub_metering_3, col = "blue", type = "l")
    })

legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1, lwd = 2.5
       )

dev.copy(png, "plot3.png")
dev.off()