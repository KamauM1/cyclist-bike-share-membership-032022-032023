# Install required packages
install.packages('tidyverse')
library('tidyverse')
install.packages('lubridate')
library('lubridate')
install.packages('ggplot2')
library('ggplot2')
install.packages('dplyr')
library('dplyr')
install.packages('readxl')
library('readxl')

remove(alternativesPairwiseComparisonsList
       , criteriaWeightsPairwiseComparisons, e, f
       ,fuel, reliability, style, a, b, c, d, g
       , marks, overall1, studentID, surname)

#=====================
# STEP 1: COLLECT DATA
#=====================
#displays your working directory
getwd() 

#sets your working directory to simplify calls to data
setwd("/Users/admin/Downloads/Cyclist_Data") 

#Upload specific sheets from Excel
library(readxl)
# Upload Divvy data sets (xlsx files) here:
# file including path if needed
file2203 <- "202203.xlsx" 
file2204 <- "202204.xlsx"
file2205 <- "202205.xlsx"
file2206 <- "202206.xlsx"
file2207 <- "202207.xlsx"
file2208 <- "202208.xlsx"
file2209 <- "202209.xlsx"
file2210 <- "202210.xlsx"
file2211 <- "202211.xlsx"
file2212 <- "202212.xlsx"
file2301 <- "202301.xlsx"
file2302 <- "202302.xlsx"
file2303 <- "202303.xlsx"

# read the sheets
sheet2203 <- excel_sheets(file2203)
sheet2204 <- excel_sheets(file2204)
sheet2205 <- excel_sheets(file2205)
sheet2206 <- excel_sheets(file2206)
sheet2207 <- excel_sheets(file2207)
sheet2208 <- excel_sheets(file2208)
sheet2209 <- excel_sheets(file2209)
sheet2210 <- excel_sheets(file2210)
sheet2211 <- excel_sheets(file2211)
sheet2212 <- excel_sheets(file2212)
sheet2301 <- excel_sheets(file2301)
sheet2302 <- excel_sheets(file2302)
sheet2303 <- excel_sheets(file2303)
s1 <- sheet2203[grep("202203", sheet2203)]
s2 <- sheet2204[grep("202204", sheet2204)]
s3 <- sheet2205[grep("202205", sheet2205)]
s4 <- sheet2206[grep("202206", sheet2206)]
s5 <- sheet2207[grep("202207", sheet2207)]
s6 <- sheet2208[grep("202208", sheet2208)]
s7 <- sheet2209[grep("202209", sheet2209)]
s8 <- sheet2210[grep("202210", sheet2210)]
s9 <- sheet2211[grep("202211", sheet2211)]
s10 <- sheet2212[grep("202212", sheet2212)]
s11 <- sheet2301[grep("202301", sheet2301)]
s12 <- sheet2302[grep("202302", sheet2302)]
s13 <- sheet2303[grep("202303", sheet2303)]


# read the data, only first 15 columns (A:0)
excel2203 <- lapply(s1, read_excel, path = file2203, range = cell_cols("A:O"))
excel2204 <- lapply(s2, read_excel, path = file2204, range = cell_cols("A:O"))
excel2205 <- lapply(s3, read_excel, path = file2205, range = cell_cols("A:O"))
excel2206 <- lapply(s4, read_excel, path = file2206, range = cell_cols("A:O"))
excel2207 <- lapply(s5, read_excel, path = file2207, range = cell_cols("A:O"))
excel2208 <- lapply(s6, read_excel, path = file2208, range = cell_cols("A:O"))
excel2209 <- lapply(s7, read_excel, path = file2209, range = cell_cols("A:O"))
excel2210 <- lapply(s8, read_excel, path = file2210, range = cell_cols("A:O"))
excel2211 <- lapply(s9, read_excel, path = file2211, range = cell_cols("A:O"))
excel2212 <- lapply(s10, read_excel, path = file2212, range = cell_cols("A:O"))
excel2301 <- lapply(s11, read_excel, path = file2301, range = cell_cols("A:O"))
excel2302 <- lapply(s12, read_excel, path = file2302, range = cell_cols("A:O"))
excel2303 <- lapply(s13, read_excel, path = file2303, range = cell_cols("A:O"))


#convert into data frame
excel2203 <- as.data.frame(excel2203)
excel2204 <- as.data.frame(excel2204)
excel2205 <- as.data.frame(excel2205)
excel2206 <- as.data.frame(excel2206)
excel2207 <- as.data.frame(excel2207)
excel2208 <- as.data.frame(excel2208)
excel2209 <- as.data.frame(excel2209)
excel2210 <- as.data.frame(excel2210)
excel2211 <- as.data.frame(excel2211)
excel2212 <- as.data.frame(excel2212)
excel2301 <- as.data.frame(excel2301)
excel2302 <- as.data.frame(excel2302)
excel2303 <- as.data.frame(excel2303)

#====================================================
# STEP 2: WRANGLE DATA AND COMBINE INTO A SINGLE FILE
#====================================================
# Compare column names each of the files
# While the names don't have to be in the same order, they DO need to match perfectly before we can use a command to join them into one file
colnames(annual_data)
colnames(excel2203)

# Inspect the data frames and look for incongruities
str(excel2203)
str(annual_data)

# Finding Day of the week
library(lubridate)
excel2203$day_of_the_week <- wday(excel2203$day_of_the_week, label=TRUE, abbr=FALSE)
excel2204$day_of_the_week <- wday(excel2204$day_of_the_week, label=TRUE, abbr=FALSE)
excel2205$day_of_the_week <- wday(excel2205$day_of_the_week, label=TRUE, abbr=FALSE)
excel2206$day_of_the_week <- wday(excel2206$day_of_the_week, label=TRUE, abbr=FALSE)
excel2207$day_of_the_week <- wday(excel2207$day_of_the_week, label=TRUE, abbr=FALSE)
excel2208$day_of_the_week <- wday(excel2208$day_of_the_week, label=TRUE, abbr=FALSE)
excel2209$day_of_the_week <- wday(excel2209$day_of_the_week, label=TRUE, abbr=FALSE)
excel2210$day_of_the_week <- wday(excel2210$day_of_the_week, label=TRUE, abbr=FALSE)
excel2211$day_of_the_week <- wday(excel2211$day_of_the_week, label=TRUE, abbr=FALSE)
excel2212$day_of_the_week <- wday(excel2212$day_of_the_week, label=TRUE, abbr=FALSE)
excel2301$day_of_the_week <- wday(excel2301$day_of_the_week, label=TRUE, abbr=FALSE)
excel2302$day_of_the_week <- wday(excel2302$day_of_the_week, label=TRUE, abbr=FALSE)
excel2303$day_of_the_week <- wday(excel2303$day_of_the_week, label=TRUE, abbr=FALSE)





# Formatting ride_length packages
install.packages("tidyr")
library("tidyr")
install.packages('hms')
library('hms')

#splitting the started_at and ended_at variables to respective time & date variables
excel2203 <- excel2203 %>%
  separate(ride_length, c("date", "ride_length"), " ")
excel2203 <- select(excel2203, -c(date))
excel2203 <- mutate(excel2203, ride_length = as_hms(ride_length))

excel2204 <- excel2204 %>% separate(ride_length, c("date", "ride_length"), " ")
excel2204 <- select(excel2204, -c(date))
excel2204 <- mutate(excel2204, ride_length = as_hms(ride_length))

excel2205 <- excel2205 %>% separate(ride_length, c("date", "ride_length"), " ")
excel2205 <- select(excel2205, -c(date))
excel2205 <- mutate(excel2205, ride_length = as_hms(ride_length))

excel2206 <- excel2206 %>% separate(ride_length, c("date", "ride_length"), " ")
excel2206 <- select(excel2206, -c(date)) 
excel2206 <- mutate(excel2206, ride_length = as_hms(ride_length))

excel2207 <- excel2207 %>% separate(ride_length, c("date", "ride_length"), " ")
excel2207 <- select(excel2207, -c(date)) 
excel2207 <- mutate(excel2207, ride_length = as_hms(ride_length))

excel2208 <- excel2208 %>% separate(ride_length, c("date", "ride_length"), " ")
excel2208 <- select(excel2208, -c(date)) 
excel2208 <- mutate(excel2208, ride_length = as_hms(ride_length))

excel2209 <- excel2209 %>% separate(ride_length, c("date", "ride_length"), " ")
excel2209 <- select(excel2209, -c(date)) 
excel2209 <- mutate(excel2209, ride_length = as_hms(ride_length))

excel2210 <- excel2210 %>% separate(ride_length, c("date", "ride_length"), " ")
excel2210 <- select(excel2210, -c(date)) 
excel2210 <- mutate(excel2210, ride_length = as_hms(ride_length))

excel2211 <- excel2211 %>% separate(ride_length, c("date", "ride_length"), " ")
excel2211 <- select(excel2211, -c(date)) 
excel2211 <- mutate(excel2211, ride_length = as_hms(ride_length))

excel2212 <- excel2212 %>% separate(ride_length, c("date", "ride_length"), " ")
excel2212 <- select(excel2212, -c(date)) 
excel2212 <- mutate(excel2212, ride_length = as_hms(ride_length))

excel2301 <- excel2301 %>% separate(ride_length, c("date", "ride_length"), " ")
excel2301 <- select(excel2301, -c(date)) 
excel2301 <- mutate(excel2301, ride_length = as_hms(ride_length))

excel2302 <- excel2302 %>% separate(ride_length, c("date", "ride_length"), " ")
excel2302 <- select(excel2302, -c(date)) 
excel2302 <- mutate(excel2302, ride_length = as_hms(ride_length))

excel2303 <- excel2303 %>% separate(ride_length, c("date", "ride_length"), " ")
excel2303 <- select(excel2303, -c(date)) 
excel2303 <- mutate(excel2303, ride_length = as_hms(ride_length))

#Stack individual year's data frames into one big data frame
annual_data <- rbind(excel2203, excel2204, excel2205, excel2206, excel2207, excel2208, excel2209, excel2210
                     , excel2211, excel2212, excel2301, excel2302, excel2303)
head(annual_data)

#Adding Month column
library('lubridate')
annual_data <- annual_data %>% 
  mutate(month = months(start_date))

#splitting the started_at and ended_at variables to respective time & date variables
annual_data <- annual_data %>% 
  separate(started_at, c("start_time_date", "start_time_time"), " ")
annual_data <- mutate(annual_data, start_date = ymd(start_time_date)
                         , start_time = as_hms(start_time_time))
annual_data_v2 <- annual_data %>% 
  separate(started_at, c("start_time_date", "start_time_time"), " ")
annual_data_v2 <- mutate(annual_data_v2, start_date = ymd(start_time_date)
                    , start_time = as_hms(start_time_time))

annual_data <- annual_data %>% 
  separate(ended_at, c("end_time_date", "end_time_time"), " ")
annual_data <- mutate(annual_data, end_date = ymd(end_time_date)
                         , end_time = as_hms(end_time_time))

annual_data_v2 <- annual_data_v2 %>% 
  separate(ended_at, c("end_time_date", "end_time_time"), " ")
annual_data_v2 <- mutate(annual_data_v2, end_date = ymd(end_time_date)
                    , end_time = as_hms(end_time_time))
#To extract hour of day from start time for time series graph plotting
annual_data <- annual_data %>% 
  mutate(hour_of_day=hour(strptime(start_time, '%H:%M:%S')) %>% as.integer() )

# Remove time fields.
annual_data <- annual_data %>% 
  select(-c(start_lat, start_lng, end_lng, end_lat
            , start_time_date, start_time_time
            , end_time_date, end_time_time))

annual_data_v2 <- annual_data_v2 %>% 
  select(-c(start_time_date, start_time_time
            , end_time_date, end_time_time))

#======================================================
# STEP 3: CLEAN UP AND ADD DATA TO PREPARE FOR ANALYSIS
#======================================================
# Inspect the new table that has been created
colnames(all_trips)  #List of column names
nrow(all_trips)  #How many rows are in data frame?
dim(all_trips)  #Dimensions of the data frame?
head(all_trips)  #See the first 6 rows of data frame.  Also tail(all_trips)
str(all_trips)  #See list of columns and data types (numeric, character, etc)
summary(all_trips)  #Statistical summary of data. Mainly for numerics


# Reassign to the desired values (we will go with the current 2020 labels)
all_trips <-  all_trips %>% 
  mutate(member_casual = recode(member_casual
                                ,"Subscriber" = "member"
                                ,"Customer" = "casual"))

# Remove "bad" data
all_trips<- all_trips[!(all_trips$start_station_name == "HQ QR" | all_trips$ride_length<=0),]

#Remove rows with NA's using na.omit()
all_trips <- na.omit(all_trips)
annual_data <- na.omit(annual_data)
annual_data_v2 <- na.omit(annual_data_v2)

#Remove rows with NA's using complete.cases
all_trips <- all_trips[complete.cases(all_trips), ] 
#Remove rows with NA's using rowSums()
all_trips <- all_trips[rowSums(is.na(all_trips)) == 0, ] 



# STEP 4: CONDUCT DESCRIPTIVE ANALYSIS
#=====================================
# Descriptive analysis on ride_length (all figures in seconds)
mean(annual_data$ride_length) #straight average (total ride length / rides)
median(annual_data$ride_length) #midpoint number in the ascending array of ride lengths
max(annual_data$ride_length) #longest ride
min(annual_data$ride_length) #shortest ride

## Compare members and casual users
aggregate(annual_data$ride_length ~ annual_data$member_casual, FUN = mean)
aggregate(annual_data$ride_length ~ annual_data$member_casual, FUN = median)
aggregate(annual_data$ride_length ~ annual_data$member_casual, FUN = max)
aggregate(annual_data$ride_length ~ annual_data$member_casual, FUN = min)

# See the average ride time by each day for members vs casual users
aggregate(annual_data$ride_length ~ annual_data$member_casual + 
            annual_data$day_of_the_week, FUN = mean)

# Notice that the days of the week are out of order. Let's fix that.
annual_data$day_of_the_week <- ordered(annual_data$day_of_the_week
                                       , levels=c("Monday", "Tuesday"
                                                  , "Wednesday", "Thursday"
                                                  , "Friday", "Saturday"
                                                  , "Sunday"))

# Do the same for months within the year
annual_data$month<- ordered(annual_data$month
                                       , levels=c("January", "February"
                                                  , "March", "April"
                                                  , "May", "June"
                                                  , "July", "August", "September"
                                                  , "October", "November"
                                                  , "December"))

# Now, let's run the average ride time by each day for members vs casual users
aggregate(annual_data$ride_length ~ annual_data$member_casual + 
            annual_data$day_of_the_week, FUN = mean)
aggregate(annual_data$ride_length ~ annual_data$member_casual + 
            annual_data$month, FUN = mean)

#Analyze ridership data by type and day_of_the_week
annual_data %>% 
  group_by(member_casual, day_of_the_week) %>%
  summarise(number_of_rides = n()	
            ,average_duration = mean(ride_length)) %>% 
  arrange(member_casual, day_of_the_week)

## Let's visualize the number of rides over a week
annual_data %>% 
  group_by(member_casual, day_of_the_week) %>% 
  summarise(number_of_rides = n()
            ,average_duration = mean(ride_length)) %>% 
  arrange(member_casual, day_of_the_week)  %>% 
  ggplot(aes(x = day_of_the_week, y = number_of_rides/100
             , fill = member_casual)) +
  geom_col(position = "dodge") +
  labs(title="Bargraph of Annual Number Of Rides over a week" 
       , x = "Day of the week", y = "Number of rides '00"
       , fill = "Membership status")
# Linegrapgh option I
annual_data %>% 
  group_by(member_casual, day_of_the_week) %>% 
  summarise(number_of_rides = n()
            ,average_duration = mean(ride_length)) %>% 
  arrange(member_casual, day_of_the_week)  %>% 
  ggplot(aes(x = day_of_the_week, y = number_of_rides/100
             , group = member_casual)) +
  geom_line(aes(linetype = member_casual)) +
  geom_point()+
  labs(title="Linegraph of Annual Number Of Rides over a week" 
       , x = "Day of the week", y = "Number of rides '00"
       , fill = "Membership status")

# Linegraph option II
annual_data %>% 
  group_by(member_casual, day_of_the_week) %>% 
  summarise(number_of_rides = n()
            ,average_duration = mean(ride_length)) %>% 
  arrange(member_casual, day_of_the_week)  %>% 
  ggplot(aes(x = day_of_the_week, y = number_of_rides/100
             , group = member_casual)) +
  geom_line(aes(color = member_casual)) +
  geom_point()+
  labs(title="Linegraph of Annual Number Of Rides over a week" 
       , x = "Day of the week", y = "Number of rides '00"
       , fill = "Membership status")

annual_data %>% 
  group_by(member_casual, month) %>% 
  summarise(number_of_rides = n()
            ,average_duration = mean(ride_length)) %>% 
  arrange(member_casual, month)  %>% 
  ggplot(aes(x = month, y = number_of_rides/100
             , group = member_casual)) +
  geom_line(aes(color = member_casual)) +
  geom_point()+
  labs(title="Linegraph of Annual Number Of Rides over a year" 
       , x = "month", y = "Number of rides '00"
       , fill = "Membership status")

#Let's create a visualization for average duration over a week
annual_data %>% 
  group_by(member_casual, day_of_the_week) %>% 
  summarise(number_of_rides = n()
            ,average_duration = mean(ride_length)) %>% 
  arrange(member_casual, day_of_the_week)  %>% 
  ggplot(aes(x = day_of_the_week, y = average_duration/60
             , fill = member_casual)) +
  geom_col(position = "dodge") +
  labs(title='Bargraph of Annual Average Duration Across Days Of The Week'
       , x = "Day of the week", y = "Average duration (Min)"
       , fill = "Membership status")

#Let's create a visualization for average duration by bike type
annual_data %>% 
  group_by(member_casual, rideable_type) %>% 
  summarise(number_of_rides = n()
            ,average_duration = mean(ride_length)) %>% 
  arrange(member_casual, rideable_type)  %>% 
  ggplot(annual_data
         , mapping = aes(x = rideable_type
                         , y = average_duration/60
                         , fill = member_casual)) +
  geom_col(position = "dodge") +
  labs(title='Bargraph of Annual Average Duration Based On Bike Type'
       , x = "Bike Type", y = "Average duration (Min)"
       , fill = "Membership status")

#Let's create a visualization for number of rides by bike type
annual_data %>% 
  group_by(member_casual, rideable_type) %>% 
  summarise(number_of_rides = n()
            ,average_duration = mean(ride_length)) %>% 
  arrange(member_casual, rideable_type)  %>% 
  ggplot(aes(x = rideable_type, y = number_of_rides/1000
             , fill = member_casual)) +
  geom_col(position = "dodge") +
  labs(title='Bargraph of Annual Number Of Rides Based On Bike Type'
       , x = "Bike Type", y = "Number of rides '000"
       , fill = "Membership status")

annual_data %>% 
  group_by(day_of_the_week, rideable_type) %>% 
  summarise(number_of_rides = n()
            ,average_duration = mean(ride_length)) %>% 
  arrange(day_of_the_week, rideable_type)  %>% 
  ggplot(aes(x = day_of_the_week, y = number_of_rides/1000
             , fill = rideable_type)) +
  geom_col(position = "dodge") +
  labs(title='Bargraph of Annual Number Of Rides over a week'
       , x = "Day of the week", y = "Number of rides '000"
       , fill = "Type of bike")

#Let's create another visualization for number of rides over a week
annual_data %>% 
  group_by(member_casual, day_of_the_week) %>% 
  summarise(number_of_rides = n()
            ,average_duration = mean(ride_length)) %>% 
  arrange(member_casual, day_of_the_week)  %>% 
  ggplot(mapping = aes(x = day_of_the_week, y = number_of_rides/1000
                       , color = member_casual)) +
  geom_point() +
  labs(title='Scatterplot Of Annual Number Of Rides Over A Week'
       , x = "Day of the week", y = "Number of rides '000"
       , color = "Membership status")

annual_data %>% 
  group_by(member_casual, start_time) %>% 
  summarise(number_of_rides = n()
            ,average_duration = mean(ride_length)) %>% 
  arrange(member_casual, start_time)  %>% 
  ggplot(aes(x = start_time, y = number_of_rides, color = member_casual)) +
  geom_point() +
  labs(title='Scatterplot Of Annual Number Of Rides Over Time Of Day',
       x="Time of day",y="Number of rides", color = "Membership Type")

annual_data %>% 
  group_by(member_casual, hour_of_day) %>% 
  summarise(number_of_rides = n()
            ,average_duration = mean(ride_length)) %>% 
  arrange(member_casual, hour_of_day)  %>% 
  ggplot(aes(x = hour_of_day, y = number_of_rides/1000, group = member_casual)) +
  geom_line(aes(color = member_casual)) +
  geom_point()+
  labs(title='Linegraph Of Annual Number Of Rides Over Time Of Day',
       x="Time of day",y="Number of rides '000", color = "Membership Type")

annual_data %>% 
  group_by(ride_length, member_casual) %>% 
  summarise(number_of_rides = n()
            , average_duration = mean(ride_length)) %>% 
  arrange(ride_length, member_casual)  %>%        
  ggplot(mapping = aes(x = member_casual, y = average_duration/3600
                       , color = member_casual)) +
  geom_boxplot() +
  labs(title='Boxplot Of Annual Average Ride Duration Against Customers',
       x="Membership type",y="Average ride duration (hrs)"
       , color = "Membership Type")

nrow(annual_data)
annual_data %>% count(member_casual)

annual_data %>% 
  ggplot(mapping = aes(x= member_casual), fill = member_casual) +
  geom_bar(aes(fill = member_casual)) +
  labs(title='Bargraph Of Annual Number Of Users',
       x="Membership type", y="Number of users"
       , fill = "Membership Type")
#=================================================
# STEP 5: EXPORT SUMMARY FILE FOR FURTHER ANALYSIS
#=================================================
# Create a csv file that we will visualize in Excel, Tableau, or my presentation software
# N.B.: This file location is for a Mac. If you are working on a PC, change the file location accordingly (most likely "C:\Users\YOUR_USERNAME\Desktop\...") to export the data. You can read more here: https://datatofish.com/export-dataframe-to-csv-in-r/
counts <- aggregate(annual_data$ride_length ~ annual_data$member_casual + annual_data$day_of_the_week, FUN = mean)
write.csv(counts, file = '/Users/admin/Downloads/Cyclist_Data/avg_ride_length.csv')
write.csv(annual_data, file = '/Users/admin/Downloads/Cyclist_Data/annual_data.csv')
write.csv(annual_data_v2, file = '/Users/admin/Downloads/Cyclist_Data/annual_data_v2.csv')
