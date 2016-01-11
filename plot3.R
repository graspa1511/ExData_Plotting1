data0 <- read.table("household_power_consumption.txt",
                    sep = ";", header = TRUE, stringsAsFactors = FALSE)
data0 <- tbl_df(data0)
dataFil <- filter(data0, Date == "2/2/2007" | Date == "1/2/2007")
dataFil <- mutate(dataFil, Date_Time = paste(Date, Time, sep = " "))
dataFil$Date_Time <- strptime(dataFil$Date_Time, "%d/%m/%Y %H:%M:%S")
dataFil[, 3:9] <- lapply(dataFil[, 3:9], as.numeric)
dataFil <- dataFil[, c(10, 3:9)]
dataFil <- rename(dataFil, Kitchen = Sub_metering_1,
                  Laundry_room = Sub_metering_2, Water_heater_AC = Sub_metering_3)
png(filename = "plot3.png", width = 480, height = 480)
par(mfrow = c(1,1))
plot(dataFil$Date_Time, dataFil$Kitchen, type = "l", ylab = "Energy sub metering", xlab = "")
points(dataFil$Date_Time, dataFil$Laundry_room, type = "l", col = "red")
points(dataFil$Date_Time, dataFil$Water_heater_AC, type = "l", col = "blue")
legend("topright", lty = c(1,1,1), lwd = c(2,2,2), col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()