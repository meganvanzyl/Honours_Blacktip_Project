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
<li><p>Measurements</p>
<p>(length in cm; nose to tip of the upper caudal lobe)</p></li>
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

print(clean_shark_data)
```

       tag_transmitter_id common_name release_id release_latitude release_longitude
    1               14681    Blacktip          a        -26.74664          32.93422
    2               14684    Blacktip          b        -26.74664          32.93422
    3               14675    Blacktip          c        -26.74664          32.93422
    4               14670    Blacktip          d        -26.74664          32.93422
    5               14685    Blacktip          e        -26.74664          32.93422
    6                8953    Blacktip          f        -26.74664          32.93422
    7                6508    Blacktip          g        -26.84444          32.89619
    8                3182    Blacktip          h        -30.36539          30.71494
    9                3183    Blacktip          i        -30.36539          30.85129
    10               3184    Blacktip          j        -30.36539          30.12985
    11               3185    Blacktip          k        -30.28107          30.81001
    12               3187    Blacktip          l        -30.28107          30.81001
    13               3191    Blacktip          m        -30.28107          30.81001
    14               3192    Blacktip          n        -30.28107          30.81001
    15               3194    Blacktip          o        -30.37126          30.76117
    16               3395    Blacktip          p        -22.15423          35.74835
    17               3396    Blacktip          q        -22.15423          35.74835
    18               4079    Blacktip          r        -22.15423          35.74835
    19               3309    Blacktip          s        -27.52474          32.68430
    20               3297    Blacktip          t        -27.39539          32.75981
       release_date sex measurement         catch_area
    1    2018-11-20   F         249              Ponta
    2    2018-11-21   F         244              Ponta
    3    2018-11-23   F         228              Ponta
    4    2018-11-24   F         237              Ponta
    5    2018-12-02   F         230              Ponta
    6    2019-11-09   F         240              Ponta
    7    2020-06-23   M         243         Scottburgh
    8    2020-06-26   M         231      Kelso Station
    9    2020-06-26   M         229      Kelso Station
    10   2020-07-02   F         262 Illovo Mouth north
    11   2020-07-03   F         261       Aliwal Shoal
    12   2020-07-13   F         229       Aliwal Shoal
    13   2020-07-19   F         241       Aliwal Shoal
    14   2020-07-26   F         222          Cathedral
    15   2020-08-03   M         191            Geelbek
    16   2020-12-01   F         244           Number 1
    17   2020-12-02   F         227           Number 1
    18   2020-12-03   F         248           Number 3
    19   2021-11-01   M         214            Hotspot
    20   2021-11-04   F         288             Mabibi

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
