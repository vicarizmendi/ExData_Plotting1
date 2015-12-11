## plot2.R
plot2() {
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
        png(".//GitHub/ExData_Plotting1/plot2.png")
        with(datasetPlot,plot(Time,Global_active_power, type="l",main= "",xlab="",ylab="Global Active Power (kilowatts)"))
        dev.off()
        
        ## Change back local language to Spanish
        Sys.setlocale("LC_TIME","Spanish_Spain.1252")

}
