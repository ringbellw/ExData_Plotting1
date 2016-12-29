##Download, unzip and read the file
temp <- tempfile()
fileURL1 <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL1, temp, mode = "wb")
unzip(temp, exdir = ".", list = TRUE)
data_hhc <- read.table(unzip(temp, "household_power_consumption.txt"), 
                       header = TRUE, sep = ";", na.strings = "?", dec = ".",
                       stringsAsFactors = FALSE)
unlink(temp)

##Subset and transform the read file
sub_data <- data_hhc[data_hhc$Date %in% c("1/2/2007", "2/2/2007"), ]
sub_data$Date_Time <- strptime(paste(sub_data$Date, sub_data$Time, sep = " "), format = "%d/%m/%Y %H:%M:%S")


#Generate plot1.png
par(mfrow = c(1, 1), mar = c(5, 5, 3, 2))
hist(sub_data$Global_active_power, 
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency",
     main = "Global Active Power", col = "red"
     )

dev.copy(png, file = "plot1.png")
dev.off()