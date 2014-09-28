require(dplyr)
require(tidyr)
require(lubridate)

mydata = read.csv("data/project.csv", 
                  na.strings="NA",
                  stringsAsFactors=T,
                  colClasses = c("mydate"="character"))

mydata = mydata %>%
  mutate(myDate = as.Date(myDate, format="%d/%m/%Y"),
         myDateTime = as.POSIXct(myDateTime, format="%d/%m/%Y %H:%M", tz=""))
