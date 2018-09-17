library(ggplot2)
data(diamonds, package='ggplot2')

# 2D displays
ggplot(diamonds, aes(x=carat, y=price))

ggplot(diamonds, aes(x=carat, y=price)) + geom_point()

ggplot(diamonds, aes(x=carat, y=price, color=cut)) + geom_point()

ggplot(diamonds, aes(x=carat, y=price, color=cut)) + geom_point(shape=1)

ggplot(diamonds, aes(x=carat, y=price, color=cut)) + geom_point(shape=1, size=1)

ggplot(diamonds, aes(x=carat, y=price, color=cut)) + 
    geom_point(shape=1, size=1, alpha=1/3) # format the points

ggplot(diamonds, aes(x=carat, y=price, color=cut)) + 
    geom_point(shape=1, size=1, alpha=1/3) + 
    geom_smooth() # trend lines for each color

ggplot(diamonds, aes(x=carat, y=price)) + 
    geom_point(aes(color=cut), shape=1, size=1, alpha=1/3) + 
    geom_smooth() # trend line for whole set, not by cut

ggplot(diamonds, aes(x=carat, y=price)) +
    geom_point(aes(color=cut), shape=1, size=1) +
    geom_smooth(aes(color=cut)) + # trend for each cut
    geom_smooth(color='red') # trend for whole set as well, and hard-coded color

ggplot(diamonds, aes(x=carat, y=price)) +
    geom_point(aes(color=cut), shape=1, size=1) +
    geom_smooth(aes(color=cut)) +
    geom_smooth(color='red') +
    facet_wrap(~cut) # separate plots for each cut

ggplot(diamonds, aes(x=carat, y=price)) +
    geom_point(aes(color=cut), shape=1, size=1) +
    geom_smooth(aes(color=cut)) +
    geom_smooth(color='red') +
    facet_wrap(~cut) +
    theme(legend.position='none') +
    ggtitle('Diamonds')

# 1-Dimentional display

# Histogram
ggplot(diamonds, aes(x=price)) +
    geom_histogram()

ggplot(diamonds, aes(x=price)) +
    geom_histogram(bins=50)

ggplot(diamonds, aes(x=price)) +
    geom_histogram(binwidth=500)

ggplot(diamonds, aes(x=price)) +
    geom_histogram

# Density plot
ggplot(diamonds, aes(x=price)) +
    geom_density(aes(fill=cut), alpha=1/3) # each cut as color

# Box plot