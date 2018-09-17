library(ggplot2)
data(diamonds, package='ggplot2')

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
    geom_point(aes(color=cut), shape=1, size=1, alpha=1/3) + # trend line for whole set, not by cut
    geom_smooth()
ggplot(diamonds, aes(x=carat, y=price)) +
    geom_point(aes(color=cut), shape=1, size=1) +
    geom_smooth(aes(color=cut)) + # trend for each cut
    geom_smooth(color='red') # trend for whole set as well, and hard-coded color
