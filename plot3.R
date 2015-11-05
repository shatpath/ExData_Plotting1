#This code implements the PLOT3 as shown in the coursera Assignment 1

#Loading the dplyr package
library(dplyr)

# Read the data file, assuming "exdata-data-household_power_consumption" folder is in working directory
od<-read.table("./exdata-data-household_power_consumption/household_power_consumption.txt",header=TRUE,sep=";",stringsAsFactors=FALSE)
odf<-tbl_df(od)

# filter the data for 1st and 2nd Feb 2007 
odff<-filter(odf,Date=='1/2/2007' | Date=='2/2/2007')

# Adding a date column and a datetime column   based on the Date and Time available in character format 
odfm<-mutate(odff,date1=as.Date(Date,"%d/%m/%Y"),dtime= as.POSIXct(paste(date1,Time)))

# Create a png file device 
png(file="plot3.png", width = 480, height = 480, units = "px", pointsize = 12)

#Now plot graphs for each Sub metering type
plot(odfm$dtime,as.numeric(odfm$Sub_metering_1),xlab="",ylab="Energy sub metering", type="n")
points(odfm$dtime,as.numeric(odfm$Sub_metering_1),type="l")
points(odfm$dtime,as.numeric(odfm$Sub_metering_2),type="l",col="red")
points(odfm$dtime,as.numeric(odfm$Sub_metering_3),type="l",col="blue")

legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),pch="___")

# Now close the file device
dev.off()