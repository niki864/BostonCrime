library(ggmap)
library(dplyr)
library(lubridate)
crimedb<-read.csv("crime.csv")
#remove all incomplete cases
crimeclean<-crimedb[complete.cases(crimedb),]
#Add original district names to all district numbers
crimeclean$origdistrictname <- mapvalues(crimeclean$DISTRICT, from = c('A1','A15','A7','B2','B3','C6','C11','D4','D14','E5','E13','E18'), to=c('DT & Charleston','DT & Charleston','East Boston','Roxbury','Mattapan','South Boston','Dorchester','South End','Brighton','West Roxbury','Jamaica Plain','Hyde Park'))
#Split dataset for data from 2017 - 2018 Feb
lastyear <- crimeclean %>% select(INCIDENT_NUMBER,OFFENSE_CODE,OFFENSE_CODE_GROUP,OFFENSE_DESCRIPTION,DISTRICT,REPORTING_AREA,SHOOTING,OCCURRED_ON_DATE,YEAR,MONTH,DAY_OF_WEEK,HOUR,UCR_PART,STREET,Lat,Long,Location,origdistrictname) %>%
  filter(between(as.Date(OCCURRED_ON_DATE), as.Date("2017-02-01"), as.Date("2018-02-01")))
#Split dataset for data from 2016 - 2017 Feb
yearbeforelast <- crimeclean %>% select(INCIDENT_NUMBER,OFFENSE_CODE,OFFENSE_CODE_GROUP,OFFENSE_DESCRIPTION,DISTRICT,REPORTING_AREA,SHOOTING,OCCURRED_ON_DATE,YEAR,MONTH,DAY_OF_WEEK,HOUR,UCR_PART,STREET,Lat,Long,Location,origdistrictname) %>%
  filter(between(as.Date(OCCURRED_ON_DATE), as.Date("2016-02-01"), as.Date("2017-02-01")))
#Get Map of Boston
bostonmap <- get_map(location = 'boston', zoom = 12, maptype = 'roadmap')
#Roadmap is only available from Google Maps
interestedregion <- ggmap(bostonmap)+
  #scale_x_continuous(limits = c(-71.20, -71.00), expand = c(0, 0)) +
  #scale_y_continuous(limits = c(42.26, 42.42), expand = c(0, 0)) +
  #Include the above two lines if you want to zoom in to just the Boston region
  #Create the density plots for crime regions. Bin size is responsible for resolution
  stat_density2d(data = lastyear, aes(x=lastyear$Long,y=lastyear$Lat,alpha=..level..,fill=..level..), bins=15,geom='polygon')+
  #Crime Density scale in range of blue to orange to denote intensity
  scale_fill_gradient('Crime\nDensity', low = 'darkmagenta', high = 'gold') +
  #Populate map with the density color scheme
  scale_alpha(range = c(.2, .3), guide = FALSE)+
  guides(fill = guide_colorbar(barwidth = 1.5, barheight = 10)) +
  #Remove the axes titles long and lat
  theme(axis.title.y = element_blank(), axis.title.x = element_blank()) +
  #Add title to map
  ggtitle("Boston Crime February 2017 - February 2018")
interestedregion
#Create a table for district wise count of crimes
districtwise <- as.data.frame(table(lastyear$origdistrictname))
#Rename the columns
names(districtwise)<-c('District','Frequency')
library(ggplot2)
#create a function named plotter that will plot all our graphs when we call it
plotter <- function(dataset, title){
  #Plot the Barplot for the table created. Exclude the first column as it contains cases with no district
  plotout <- ggplot(dataset, aes(x=District, y=dataset[2],fill=District)) +
    geom_bar(stat = "identity") +
    #applies a minimalistic theme
    theme_minimal() +
    ggtitle(title)
  return(plotout)
}
yearof2017 <- plotter(districtwise[-1,],"Crime By District - Boston - (Feb 2017-2018)")
yearof2017
#Do the same for the 2016 year using the yearbeforelast dataframe
prevyr <- as.data.frame(table(yearbeforelast$origdistrictname))
names(prevyr)<- c('District','Frequency')
yearof2016 <- plotter(prevyr[-1,],"Crime By District - Boston - (Feb 2016-2017)")
yearof2016
#Calculate Percentage change between the two datasets
crimechange <- data.frame(districtwise$District,(districtwise$Frequency-prevyr$Frequency)*100/prevyr$Frequency)
names(crimechange) <- c('District','PctChange')
#Plot percentage change
pctchange <-  plotter(crimechange[-1,],"Pct Change in Crime")
pctchange
########################################################
#Time to graph the change in crime according to seasons.