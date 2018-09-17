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

# slect %in% from a vector
diamonds %>% filter(cut %in% c('Ideal', 'Premium'))
