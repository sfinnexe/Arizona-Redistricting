## 
pkgs = c("tidyverse", "sf", "tmap")
install.packages(pkgs, dep = TRUE)

## ------------------------------------------------------------------------
library(tidyverse)
library(sf)
library(tmap)

## 
dsn = "C:/Users/finne/OneDrive/electoral_redisdtricting/Compactness_lab/data/districtShapes" # <- folder with shapefiles
cd88 = read_sf(dsn, "districts088")

## 
class(cd88)
cd88

## ------------------------------------------------------------------------
tm_shape(cd88) +
  tm_polygons()

## ------------------------------------------------------------------------
cd88_naea = st_transform(cd88, crs = 2163)

tm_shape(cd88_naea) +
  tm_polygons()

## ------------------------------------------------------------------------
az88 = cd88 %>% 
  select(STATENAME, ID, DISTRICT) %>%
  filter(STATENAME == "Arizona")

#mapping AZ (10/2)
tm_shape(az88) + 
  tm_polygons(col = "pink")

## ------------------------------------------------------------------------
source("C:/Users/Owner/OneDrive/electoral_redisdtricting/Compactness_lab/data/compactr-master/compactness.r")

## ------------------------------------------------------------------------
az88 = mutate(az88,
  pp = polsby_popper(geometry),
  reock = reock(geometry)
)
tm_shape(az88) +
  tm_polygons(col = "pp") +
  tm_text("DISTRICT")

#reock map
tm_shape(az88) +
  tm_polygons(col = "reock") +
  tm_text("DISTRICT")

## -------------------------------------------------------------
# Load each congress into an sf object:
# cd88 already loaded
cd93 = read_sf(dsn, "districts093")
cd98 = read_sf(dsn, "districts098")
cd103 = read_sf(dsn, "districts103")
cd108 = read_sf(dsn, "districts108")
cd113 = read_sf(dsn, "districts113")
# etc.

# Add a decade variable to each one:
cd88$decade = 1960
cd93$decade = 1970
cd98$decade = 1980
cd103$decade = 1990
cd108$decade = 2000
cd113$decade = 2010
# etc.

# Use rbind to combine all of the sf objects into one:
all_cds = rbind(cd88, cd93, cd98, cd103, cd108, cd113)




## ---- eval=FALSE---------------------------------------------------------
# Select desired fields and restrict to Arizona
# Retain the decade variable!
all_az = all_cds %>%
  select(STATENAME, ID, DISTRICT, decade) %>%
  filter(STATENAME == "Arizona")

# Calculate compactness measures
all_az = mutate(all_az,
  pp = polsby_popper(geometry),
  reock = reock(geometry)
)

## ---- ---------------------------------------------------------
tmp = as.data.frame(all_az) %>%
  select(-geometry)

## -------------------------------------------------------------
az_by_decade = tmp %>%
  group_by(decade) %>%
  summarize(
    min_pp = min(pp),
    max_pp = max(pp),
    avg_pp = mean(pp),
    min_reock = min(reock),
    max_reock = max(reock),
    avg_reock = mean(reock)
    )


## ------------------------------------------------------------------------
ggplot(az_by_decade) +
  geom_line(aes(x = decade, y = min_pp), color = "blue") +
  geom_line(aes(x = decade, y = avg_pp), color = "black") +
  geom_line(aes(x = decade, y = max_pp), color = "blue") +
  scale_y_continuous(limits = c(0, 1)) +
  ggtitle("Changing Compactness in Arizona") +
  xlab("Census Year") +
  ylab("Polsby-Popper Score")

ggplot(az_by_decade) +
  geom_line(aes(x = decade, y = min_reock), color = "blue") + 
  geom_line(aes(x = decade, y = avg_reock), color = "black") + 
  geom_line(aes(x = decade, y = max_reock), color = "blue") + 
  scale_y_continuous(limits = c(0,1)) +
  ggtitle("Changing Compactness in Arizona") + 
  xlab("Census Year") + 
  ylab("Reock Score")
