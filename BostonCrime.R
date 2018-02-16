library(ggmap)
crimedb<-read.csv("crime.csv")
library(plyr)
crimeclean<-crimedb[complete.cases(crimedb),]
bostonmap <- get_map(location = 'boston', zoom = 12, maptype = 'roadmap')
#Roadmap is only available from Google Maps
interestedregion <- ggmap(bostonmap)+
  #scale_x_continuous(limits = c(-71.20, -71.00), expand = c(0, 0)) +
  #scale_y_continuous(limits = c(42.26, 42.42), expand = c(0, 0)) +
  #Include the above two lines if you want to zoom in to just the Boston region
  #Create the density plots for crime regions. Bin size is responsible for resolution
  stat_density2d(data = crimeclean, aes(x=crimeclean$Long,y=crimeclean$Lat,alpha=..level..,fill=..level..), bins=18,geom='polygon')+
  #Crime Density scale in range of blue to orange to denote intensity
  scale_fill_gradient('Crime\nDensity', low = 'blue', high = 'orange') +
  #Populate map with the density color scheme
  scale_alpha(range = c(.2, .3), guide = FALSE)+
  guides(fill = guide_colorbar(barwidth = 1.5, barheight = 10)) +
  #Remove the axes titles long and lat
  theme(axis.title.y = element_blank(), axis.title.x = element_blank()) +
  #Add title to map
  ggtitle("Boston Crime February 2018")
interestedregion

