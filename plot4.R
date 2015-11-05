#This code implements the 'Plot 4' as shown in the coursera Assignment 1

#Loading the dplyr package
library(dplyr)

# Read the data file, assuming "exdata-data-household_power_consumption" folder is in working directory
od<-read.table("./exdata-data-household_power_consumption/household_power_consumption.txt",header=TRUE,sep=";",stringsAsFactors=FALSE)
odf<-tbl_df(od)

# filter the data for 1st and 2nd Feb 2007 
odff<-filter(odf,Date=='1/2/2007' | Date=='2/2/2007')

# Adding a date column and a datetime column   based on the Date and Time available in character format 
odfm<-mutate(odff,date1=as.Date(Date,"%d/%m/%Y"),dtime= as.POSIXct(paste(date1,Time)))

#Setting the global values for margins,mfrow , magnification of labels etc
par(mar=c(5,5,3,2),mfrow=c(2,2),cex.lab=0.7,cex.axis=0.8)

# Now plotting the graph in first row and first column 
plot(odfm$dtime,as.numeric(odfm$Global_active_power),xlab="",ylab="", type="l")
title(ylab="Global Active Power",line=3)

# Now plotting the graph in first row and second column 

plot(odfm$dtime,as.numeric(odfm$Voltage),xlab="",ylab="", type="l")
title(xlab="datetime",ylab="Voltage",line=3)

# Now plotting the graph in second row and first column 

plot(odfm$dtime,as.numeric(odfm$Sub_metering_1),xlab="",ylab="", type="n")

points(odfm$dtime,as.numeric(odfm$Sub_metering_1),type="l")

points(odfm$dtime,as.numeric(odfm$Sub_metering_2),type="l",col="red")
points(odfm$dtime,as.numeric(odfm$Sub_metering_3),type="l",col="blue")

legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),pch="____",lty,cex=0.6,bty="n",xjust=1,yjust=1,x.intersp=0.5,y.intersp = 0.5)
title(xlab="",ylab="Energy sub metering",line=3)

# Now plotting the graph in second row and second column 

plot(odfm$dtime,as.numeric(odfm$Global_reactive_power),xlab="",ylab="", type="l")
title(xlab="datetime",ylab="Global_reactive_power",line=3)

#Now copying the plot from screen graphics device to PNG device
dev.copy(png,file="plot4.png")


#closing the PNG graphics device
dev.off()