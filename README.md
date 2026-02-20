# README


Add Binder Badge here

## Background Information

![“Image of Blacktip Shark (*Carcharhinus
limbatus*)”](images/Carcharhinus%20limbatus.jpg)

This study investigates the migration of blacktip sharks (*Carcharhinus
limbatus*) along the east coast of southern Africa to better understand
their foraging ecology. Sharks were captured and fitted with surgically
implanted acoustic transmitters in the coelomic cavity. A network of
fixed acoustic receivers detects tagged individuals when they move
within detection range, generating time-stamped records of presence
along the coastline. Data were collected between 2020 and 2025 and will
be analysed in R to characterise movement patterns and evaluate
potential drivers of seasonal and spatial migration.

## Raw Data

The raw data files can be found
[here](https://github.com/meganvanzyl/Honours_Blacktip_Project/tree/main/Data/Raw_Data).

### There are 3 raw data files:

<table style="width:99%;">
<colgroup>
<col style="width: 40%" />
<col style="width: 36%" />
<col style="width: 22%" />
</colgroup>
<thead>
<tr>
<th style="text-align: center;"><h4
id="the-blacktip-metadata-of-individual-sharks">The Blacktip Metadata of
individual sharks</h4></th>
<th style="text-align: center;"><h4 id="the-receiver-metadata">The
Receiver Metadata</h4></th>
<th style="text-align: center;"><h4 id="the-blacktip-detections">The
Blacktip Detections</h4></th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align: center;"><ul>
<li><p>Tag IDs</p></li>
<li><p>Gender</p></li>
<li><p>Measurements (length from nose to tip of the upper caudal
lobe)</p></li>
<li><p>Release date (YYYY/MM/DD) and location (longitude and
latitude)</p></li>
<li><p>Catch Area</p></li>
</ul></td>
<td style="text-align: center;"><ul>
<li><p>Station name and location (latitude and longitude)</p></li>
<li><p>Project Name: ORI</p></li>
<li><p>Deployment and recovery date (YYYY/MM/DD) and time (hms)</p></li>
</ul></td>
<td style="text-align: center;"><ul>
<li><p>Date (YYYY/DD/MM) and time (hms)</p></li>
<li><p>Receiver and Transmitter ID</p></li>
<li><p>Location (latitude and longtitde)</p></li>
</ul></td>
</tr>
</tbody>
</table>

## Clean Data

### Blacktip Metadata

The tidy R Script can be found
[here](https://github.com/meganvanzyl/Honours_Blacktip_Project/tree/main/Code/Tidy%20Blacktip%20Metadata%20Code).

#### Follow the step-by-step of how I cleaned the raw data file for the shark metadata

``` r
library(tidyverse)
```

    ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
    ✔ dplyr     1.2.0     ✔ readr     2.1.6
    ✔ forcats   1.0.1     ✔ stringr   1.6.0
    ✔ ggplot2   4.0.2     ✔ tibble    3.3.1
    ✔ lubridate 1.9.5     ✔ tidyr     1.3.2
    ✔ purrr     1.2.1     
    ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ✖ dplyr::filter() masks stats::filter()
    ✖ dplyr::lag()    masks stats::lag()
    ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors

``` r
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

summary(clean_shark_data)
```

     tag_transmitter_id common_name         release_id        release_latitude
     Min.   : 3182      Length:20          Length:20          Min.   :-30.37  
     1st Qu.: 3190      Class :character   Class :character   1st Qu.:-30.28  
     Median : 3352      Mode  :character   Mode  :character   Median :-27.12  
     Mean   : 6592                                            Mean   :-27.56  
     3rd Qu.:10382                                            3rd Qu.:-26.75  
     Max.   :14685                                            Max.   :-22.15  
     release_longitude  release_date            sex             measurement   
     Min.   :30.13     Min.   :2018-11-20   Length:20          Min.   :191.0  
     1st Qu.:30.81     1st Qu.:2019-08-15   Class :character   1st Qu.:228.8  
     Median :32.83     Median :2020-07-02   Mode  :character   Median :238.5  
     Mean   :32.44     Mean   :2020-04-09                      Mean   :237.9  
     3rd Qu.:32.93     3rd Qu.:2020-09-02                      3rd Qu.:245.0  
     Max.   :35.75     Max.   :2021-11-04                      Max.   :288.0  
      catch_area       
     Length:20         
     Class :character  
     Mode  :character  
                       
                       
                       

``` r
str(clean_shark_data)
```

    'data.frame':   20 obs. of  9 variables:
     $ tag_transmitter_id: int  14681 14684 14675 14670 14685 8953 6508 3182 3183 3184 ...
     $ common_name       : chr  "Blacktip" "Blacktip" "Blacktip" "Blacktip" ...
     $ release_id        : chr  "a" "b" "c" "d" ...
     $ release_latitude  : num  -26.7 -26.7 -26.7 -26.7 -26.7 ...
     $ release_longitude : num  32.9 32.9 32.9 32.9 32.9 ...
     $ release_date      : Date, format: "2018-11-20" "2018-11-21" ...
     $ sex               : chr  "F" "F" "F" "F" ...
     $ measurement       : int  249 244 228 237 230 240 243 231 229 262 ...
     $ catch_area        : chr  "Ponta" "Ponta" "Ponta" "Ponta" ...

When you click the **Render** button a document will be generated that
includes both content and the output of embedded code. You can embed
code like this:

``` r
1 + 1
```

    [1] 2

You can add options to executable code like this

    [1] 4

The `echo: false` option disables the printing of code (only output is
displayed).
