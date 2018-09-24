library(readr)

tomato <- read_csv('data/TomatoFirst.csv')
tomato

library(jsonlite)

pizzalist <- fromJSON(
    'data/FavoriteSpots.json',
    simplifyDataFrame = FALSE
)

pizzalist

pizzalist[[2]]
length(pizzalist)

pizzalist[[3]]$Details
pizzalist[[3]]$Details[[1]]$Address

pizzaframe <- fromJSON(
    'data/FavoriteSpots.json',
    simplifyDataFrame = TRUE
)

pizzaframe
pizzaframe[1, ]
pizzaframe[1, ]$Details

pizzaframe[1, 2]

library(tidyr)

pizza <- pizzaframe %>% unnest()
pizza

# charting package
# https://tileservice.charts.noaa.gov/tileset.html#50000_1-locator
install.packages("leaflet")

library(leaflet)

leaflet(data=pizza) %>% 
    addTiles() %>% 
    addMarkers(lng= ~ longitude, lat= ~ latitude, label = ~ Name)

library(RSQLite)

drv <- dbDriver('SQLite')
drv

con <- dbConnect(drv, 'data/Diamonds.db')
con

dbListTables(con)

dbListFields(con, name='diamonds')

#read into DF
diamondTable <- dbGetQuery(
    con, 
    'SELECT * FROM diamonds'
)

diamondTable %>% head(10)

library(dplyr)
library(dbplyr)

diaTab <- tbl(con, 'diamonds')
diaTab
