library(ggplot2)    
library(ggmap)
library(osmdata)

rotterdam <- getbb("Rotterdam")

df <- read.csv('rotter.csv')

head(df)

rott <- get_map(rotterdam, zoom = 11, source="osm", scale=1)

ggm <- ggmap(rott, extent="device", legend="none")

ggm <- ggm + geom_point(aes(x = lon,  y =lat),  data=df) +
  ggtitle(paste("Location History Between: ", tail(df, 1)$datetime, "-", head(df, 1)$datetime))


print(ggm)
