library(dplyr)
data(diamonds, package='ggplot2')

diamonds

# SQL
select(diamonds, carat, price)

head(diamonds)

# pipe into function <- ctrl, shift, m
diamonds %>% head()

head(diamonds, n=3)
diamonds %>% head(n=3)

# pipe into SQL
diamonds %>% select(4, 7)

#filter rows on column criteria
diamonds %>% filter(carat>1)

diamonds %>% filter(cut == 'Ideal')

diamonds %>% filter(carat >= 1 & cut == 'Ideal')

diamonds %>% filter(carat >= 1 | cut == 'Ideal')

diamonds %>% filter(cut == 'Ideal' | cut == 'Premium')

# select %in% from a vector
diamonds %>% filter(cut %in% c('Ideal', 'Premium'))

# slicing through
diamonds %>% slice(4:17)

# slicing each individual rows as a vector
diamonds %>% slice(c(4, 17))

# MUTATE the dataframe
diamonds %>% mutate(price / carat)

diamonds %>% mutate(value=price / carat)

# saving new tibble into variable
diamonds <- diamonds %>% mutate(value=price / carat)

# chaining verbs together
diamonds %>% mutate(double=price*2) %>% mutate(new=sqrt(double))

diamonds %>% mutate(double=price*2, new=sqrt(double))

# functions & operations over whole tibble
diamonds %>% summarize(mean(price))

diamonds %>% summarize(AvgPrice=mean(price))

summary <- diamonds %>% summarize(AvgPrice=mean(price), TotalSize=sum(carat))

summary

# grouping (like a pivot table)
summary <- diamonds %>% 
    group_by(cut) %>% 
    summarize(AvgPrice=mean(price), TotalSize=sum(carat))

summary

# concatenating
diamonds %>% 
    filter(carat>1) %>% 
    group_by(cut) %>% 
    summarize(AvgSize=mean(carat), AvgPrice=mean(price)) %>%
    arrange(-AvgPrice)

# counting number of rows in 2 differnt ways
diamonds %>%  
    group_by(cut) %>% 
    summarize(n()) # number of rows

diamonds %>% count(cut)
