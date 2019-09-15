library(ggplot2)    
library(ggmap)
library(osmdata)

rotterdam = getbb("Rotterdam")

df = read.csv('rotter.csv')
require(tidyverse)
df<- df %>%
  mutate(datetime = as.POSIXct(datetime, "%Y-%m-%d %H:%M:%S"))


df_mins <- df %>%
  mutate(datetime = as.POSIXct(datetime, "%Y%m%d %H:%M"))
  

df_wo_dups <- df_mins[!duplicated(df_mins$datetime), ]

rott <- get_map(rott, zoom = 10, source="osm")


ggm <- ggmap(rott) +                                   
  geom_point(data = df_wo_dups,
             aes(x = lon, y = lat),
             size = 2, alpha = 0.8) +
  transition_time(datetime) + 
  labs(title = paste("Date", "{round(frame_time,0)}")) +
  shadow_wake(wake_length = 0.01)
anim <- animate(ggm, fps = 24, duration = 200) 
anim_save("rotterdam1.gif", anim)
