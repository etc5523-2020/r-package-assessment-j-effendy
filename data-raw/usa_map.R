## code to prepare `usa_map` dataset goes here
library(dplyr)
library(sf)
library(ggplot2)
library(maps)

usa <- map_data("state")

states <- st_as_sf(map("state", 
                       plot = FALSE, 
                       fill = TRUE))

states <- cbind(states, 
                st_coordinates(st_centroid(states)))

states$abb <- state.abb[match(states$ID,tolower(state.name))]

state_list <- data.frame("X" = round(states$X,0), "Y" = round(states$Y,0), "abb" = states$abb)

usa_map <- left_join(usa, states, by = c("region" = "ID"))

usethis::use_data(usa_map, overwrite = TRUE)
