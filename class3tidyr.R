library(tidyr)

reaction <- readr::read_tsv('data/reaction.txt')
reaction # wide format data

# make it long
reactionLong <- reaction %>%
    gather(key=Attribute, value=Results,
           Age, BMI, React, Regulate
           ) %>% 
    dplyr::arrange(ID, Test)

reactionLong
View(reactionLong)

# make it wide
reactionLong %>% 
    spread(key=Attribute, value=Results)
