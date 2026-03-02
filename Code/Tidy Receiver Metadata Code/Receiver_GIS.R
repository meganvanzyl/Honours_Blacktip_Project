library(tidyverse)
library(dplyr)
library(tidyr)
library(lubridate)
library(sf)
library(ggplot2)
library(ggrepel)
library(rosm)
library(ggspatial)
library(prettymapr)
library(terra)
library(curl)
library(raster)
library(leaflet)
library(htmltools)
library(mapview)
library(leafpop)


# Here I am cleaning up the receiver metadata before reading it into sf
clean_receiver_data <- read.csv("Data/Raw_Data/receiver_metadata_moz.csv") %>%
  dplyr::filter(grepl("ORI", project_name)) %>%
  dplyr::select(-dplyr::all_of(c("receiver_name","installation_name","status","receiver"))) %>%
  dplyr::rename(
    Station   = station_name,
    Project   = project_name,
    Deployed  = deploymentdatetime_timestamp,
    Recovered = recoverydatetime_timestamp)

# I want ot save the csv file
write.csv(clean_receiver_data,
          file = "Data/Clean_Data/clean_receiver_data.csv",
          row.names = FALSE)
 
# read into sf 
receivers <- st_read("Data/Clean_Data/clean_receiver_data.csv")

# Convert into a spatial object
receivers <- st_as_sf(
  receivers,
  coords = c("station_longitude", "station_latitude"),
  crs = 4326)

# check coordinate system
st_crs(receivers)
class(receivers)
st_geometry_type(receivers)

# Write in data
st_write(receivers, "Data/Clean_Data/clean_receiver_data.csv", append = FALSE)
file.exists("Data/Clean_Data/clean_receiver_data.csv")

# quick plot of receivers
plot(receivers)
plot(st_geometry(receivers))

# Lets try to make the plots look nicer
ggplot(receivers) +
  geom_sf() +
  geom_text_repel(
    aes(label = Station, geometry = geometry),
    stat = "sf_coordinates",
    size = 3)

# Adding a base map
ggplot(receivers) +
  annotation_map_tile(type = "osm", progress = "none") +
  geom_sf(size = 2) +
  geom_text_repel(
    aes(label = Station, geometry = geometry),
    stat = "sf_coordinates",
    size = 3)

# Now lets try to make it an interactive map
leaflet() %>%
  # Add default OpenStreetMap map tiles
  addTiles(group = "Default") %>%  
  # Add our points
  addCircleMarkers(data = receivers,
                   group = "Station",
                   radius = 3, 
                   color = "hotpink") 

# Now to add the pop-up labels
mapview(
  receivers,
  zcol  = "Station",   # colours by station
  legend = FALSE, #to remove the legend, since we already have the station name in the popup
  popup = popupTable(
    receivers,
    zcol = c("Station","Project",
             "Deployed","Recovered")))
