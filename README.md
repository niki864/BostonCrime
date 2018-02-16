# Crime Analysis - City of Boston

Analysed the crime data provided by https://data.boston.gov/dataset/crime-incident-reports-august-2015-to-date-source-new-system. 
A crime density heat map was generated based on reported locations of crime.
Analysed the crime data grouped by district to see pct change in crime across two years.
2016-17 -----> 91561 variables
2017-18 -----> 92041 variables

## Packages Required

plyr, ggmap, ggplot2, lubridate ; all downloadable from CRAN

### Prerequisites

R and R Studio

## Dataset Description

Data is available from the city of Boston data repositories. Crime incident reports are provided by Boston Police Department (BPD) to document the initial details surrounding an incident to which BPD officers respond. This is a dataset containing records from the new crime incident report system, which includes a reduced set of fields focused on capturing the type of incident as well as when and where it occurred. Records in the new system begin in June of 2015.
Last Update of Dataset 02/04/2018 
Data Provided under Open Data Commons Public Domain Dedication and License (PDDL).

Simple complete case matching is done to remove any empty variables. Data is split into two chunks 2016-17 and 2017-18.

## Crime Density Map

Utilised the ggmap library to pull a roadmap from Google Maps. This was later overlaid with multiple grammar of graphics layers for density gradient and more.

![alt tag](https://user-images.githubusercontent.com/10093954/36330214-d1dc9344-1336-11e8-9b17-cb1a66cdea23.jpeg)

The map shows the crime density in Boston for a period of one year from February 2017 to February 2018. 

## Crime Statistics Districtwise

Barplot modeling using ggplot is done using the frequency of crimes committed.
A material theme is applied to make it look nice. First we generate a plot for the 16-17 year

![alt tag](https://user-images.githubusercontent.com/10093954/36330202-c209c126-1336-11e8-81ac-41a0234bc28b.jpeg)

Then we do the same for the 17-18 year.

![alt tag](https://user-images.githubusercontent.com/10093954/36330213-d1d155a6-1336-11e8-8536-bf77e99450e5.jpeg)

Now we can compare the percentage change between the two years and find out how much incidents of crime have changed

![alt tag](https://user-images.githubusercontent.com/10093954/36330215-d1e90052-1336-11e8-8052-07571a413c82.jpeg)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

*  R Core Team (2013). R: A language and environment for statistical
  computing. R Foundation for Statistical Computing, Vienna, Austria.
  URL http://www.R-project.org/.

* R Packages used : Plyr, ggmap, ggplot2, lubridate
