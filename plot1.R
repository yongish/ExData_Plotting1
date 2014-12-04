download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","household_power_consumption.zip")
unzip("household_power_consumption.zip")

library(dplyr)
# Read only 1st 2 days of February 2007.
household.power.consumption <- read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'), sep=";")
# Assign proper column names by reading them in from the file.
colnames(household.power.consumption) <- (read.table("household_power_consumption.txt", nrow=1)[[1]] %>%
                                            as.character() %>%
                                            strsplit(split=";"))[[1]]

png("plot1.png", width = 480, height = 480)
with(household.power.consumption, hist(Global_active_power, col='red', xlab="Global Active Power (kilowatts)", main="Global Active Power"))
dev.off()