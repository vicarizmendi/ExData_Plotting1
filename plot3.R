## plot3.R
plot3(){
        ## Library downloader needed to download()function
        install.packages("downloader")
        library(downloader)
        
        ## download and unzip dataset in ./data directory
        if(!file.exists("./data")){dir.create("./data")}
        url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download(url, dest="./data/dataset.zip", mode="wb") 
        unzip ("./data/dataset.zip", exdir = "./data")
        
        ## Read the dataset and format the Date and Time to Date and Time class
        dataset<-read.table("./data/household_power_consumption.txt",header=TRUE,sep=";",na.strings = "?")
        dataset$Time<-paste(dataset$Date,dataset$Time)
        dataset$Date<-as.Date(dataset$Date,format="%d/%m/%Y")
        dataset$Time<-strptime(dataset$Time, format="%d/%m/%Y %H:%M:%S")
        
        ## Extract data from days 2007-02-01 and 2007-02-02
        datasetPlot<-dataset[dataset$Date=="2007-02-01"|dataset$Date=="2007-02-02",]
        
        ## Change local language to English to get the weekdays in Eng
        Sys.setlocale("LC_TIME","English_United States.1252")
        
        ## Open device for files .png, produce the graphics needed and close the device
        png(".//GitHub/ExData_Plotting1/plot3.png")
        
        with(datasetPlot,{
                plot(Time,Sub_metering_1, type="l",col="black",main= "",xlab="",ylab="Energy sub metering")
                lines(Time,Sub_metering_2, type="l",col="red",main= "",xlab="",ylab="Energy sub metering")
                lines(Time,Sub_metering_3, type="l",col="blue",main= "",xlab="",ylab="Energy sub metering")
                label_text<-"Sub_metering_1"
                text(datasetPlot$Time[2000],38,labels="___ ",col="black")
                text(datasetPlot$Time[2500],38,labels="Sub_metering_1")
                text(datasetPlot$Time[2000],36,labels="___ ",col="red")
                text(datasetPlot$Time[2500],36,labels="Sub_metering_2")
                text(datasetPlot$Time[2000],34,labels="___ ",col="blue")
                text(datasetPlot$Time[2500],34,labels="Sub_metering_3")
                text(datasetPlot$Time[2500],32,labels="_________________________")
                for (i in 1:7){text(datasetPlot$Time[1800],40-i,labels="|",col="black")}
        })
        dev.off()
        
        ## Change back local language to Spanish
        Sys.setlocale("LC_TIME","Spanish_Spain.1252")
        
}

