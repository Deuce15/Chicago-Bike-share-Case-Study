library(tidyverse)
library(janitor)
library(lubridate)
library(scales)

rm(list=ls())
dir("Data",full.names = T)

df1 <- read.csv("./Data/202004-divvy-tripdata.csv")
df2 <- read.csv("./Data/202005-divvy-tripdata.csv")
df3 <- read.csv("./Data/202006-divvy-tripdata.csv")
df4 <- read.csv("./Data/202007-divvy-tripdata.csv")
df5 <- read.csv("./Data/202008-divvy-tripdata.csv")
df6 <- read.csv("./Data/202009-divvy-tripdata.csv")
df7 <- read.csv("./Data/202010-divvy-tripdata.csv")
df8 <- read.csv("./Data/202011-divvy-tripdata.csv")
df9 <- read.csv("./Data/202012-divvy-tripdata.csv")
df10 <- read.csv("./Data/202101-divvy-tripdata.csv")
df11 <- read.csv("./Data/202102-divvy-tripdata.csv")
df12 <- read.csv("./Data/202103-divvy-tripdata.csv")
df13 <- read.csv("./Data/202104-divvy-tripdata.csv")
df14 <- read.csv("./Data/202105-divvy-tripdata.csv")
df15 <- read.csv("./Data/202106-divvy-tripdata.csv")

bike_rides <- rbind(df1,df2,df3,df4,df5,df6,df7,df8,df9,df10,df11,df12)
dim(bike_rides)
bike_rides <- janitor::remove_empty(bike_rides,which = c("cols"))
bike_rides <- janitor::remove_empty(bike_rides,which = c("rows"))
dim(bike_rides)

bike_rides$started_at <- lubridate::ymd_hms(bike_rides$started_at)
bike_rides$ended_at <- lubridate::ymd_hms(bike_rides$ended_at)

bike_rides$start_time <- lubridate::ymd_hms(bike_rides$started_at)
bike_rides$end_time <- lubridate::ymd_hms(bike_rides$ended_at)

bike_rides$start_hour <- lubridate::ymd_hms(bike_rides$started_at)
bike_rides$end_hour <- lubridate::ymd_hms(bike_rides$ended_at)

bike_rides$start_date <- as.Date(bike_rides$started_at)
bike_rides$end_date <- as.Date(bike_rides$ended_at)

bike_rides %>% count(start_hour,sort = T) %>%
  ggplot() + geom_line(aes(x=start_hour,y=n)) +
  scale_y_continuous(labels = comma) +
  labs(title = "Count of Bike Ride by Hour: Previous 12 Months",x="Start Hour of Rides",y="Count of Rides")
