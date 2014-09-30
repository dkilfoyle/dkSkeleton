require(dplyr)
require(tidyr)
require(lubridate)

mydata = iris %>%
  mutate(numeric1 = Sepal.Length, numeric2 = Sepal.Width, factor1 = Species) # TODO: use rename with dplyr 0.4
mydata$factor1 = factor(replace(mydata$factor1, mydata$factor1=="virginica", "versicolor"))

# mydata = read.csv("data/project.csv", 
#                   na.strings="NA",
#                   stringsAsFactors=T,
#                   colClasses = c("mydate"="character"))
# 
# mydata = mydata %>%
#   mutate(myDate = as.Date(myDate, format="%d/%m/%Y"),
#          myDateTime = as.POSIXct(myDateTime, format="%d/%m/%Y %H:%M", tz=""))
