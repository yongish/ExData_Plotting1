download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","household_power_consumption.zip")
unzip("household_power_consumption.zip")

library(dplyr)
# Read only 1st 2 days of February 2007.
household.power.consumption <- tbl_df(read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'), sep=";"))
# Assign proper column names by reading them in from the file.
colnames(household.power.consumption) <- (read.table("household_power_consumption.txt", nrow=1)[[1]] %>%
                                            as.character() %>%
                                            strsplit(split=";"))[[1]]

library(lubridate)
household.power.consumption <- mutate(household.power.consumption, 
                                      datetime = with(household.power.consumption, 
                                                      paste(Date, Time)) 
                                      %>% dmy_hms())

png("plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))
# Global Active Power vs. Datetime.
with(household.power.consumption, plot(datetime, Global_active_power, type='n', xlab= "", ylab="Global Active Power"))
with(household.power.consumption, lines(datetime, Global_active_power, type='l'))

# Voltage vs. Datetime.
with(household.power.consumption, plot(datetime, Voltage, type='n', xlab= "datetime", ylab="Voltage"))
with(household.power.consumption, lines(datetime, Voltage, type='l'))

# Submetering vs. Datetime.
with(household.power.consumption, plot(datetime, Sub_metering_1, type='n', xlab= "", ylab="Energy sub metering"))
with(household.power.consumption, lines(datetime, Sub_metering_1, type='l'))
with(household.power.consumption, lines(datetime, Sub_metering_2, type='l', col="red"))
with(household.power.consumption, lines(datetime, Sub_metering_3, type='l', col="blue"))
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1, col=c("Black","Red","Blue"), bty="n")


# Global_Reactive_Power vs. Datetime.
with(household.power.consumption, plot(datetime, Global_reactive_power, type='n', xlab= "datetime"))
with(household.power.consumption, lines(datetime, Global_reactive_power, type='l'))

dev.off()