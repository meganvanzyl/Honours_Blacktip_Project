library(tidyverse)
library(dplyr)
library(tidyr)
library(lubridate)

# Here I am removing some columns from the blacktip_metadata file that NA values for all entries

clean_shark_data <- read.csv("Data/Raw_Data/blacktip_metadata.csv") %>%
  select(!c("sensor_slope", "sensor_intercept", "sensor_type", "sensor_unit","tag_model_name", "tag_serial_number", "dual_sensor_tag", "girth", 
            
# I am also removing information that is repeated in its respective column, such as scientific_name, tag_expected_life_time_days and tag_status
            
            "scientific_name", "tag_expected_life_time_days", "tag_status", "tag_id", "tag_project_name")) %>%
  
# Also, I am combining columns that contain the same data, such as tag_id and transmitter_id, as well as common_name and tag_project_name. I'll remove one of the replicate columns and rename the remaining one with both column titles
  
  rename(tag_transmitter_id = transmitter_id) %>%
  
  # I want to separate the date and time data into their own respective columns
  
  separate(ReleaseDate, into = c("release_date", "time"), sep = " ", remove = FALSE) %>%
  mutate(release_date = ymd(release_date), time = hms(time)) %>%
  select(!c("ReleaseDate", "time"))

view(clean_shark_data)
