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

# other plots
ggplot(diamonds, aes(x=cut, y=price)) +
    geom_boxplot()

ggplot(diamonds, aes(x=cut, y=log(price))) +
    geom_violin()

ggplot(diamonds, aes(x=cut, y=price)) +
    geom_jitter() + # adds spread to points for visulaization
    geom_violin()

ggplot(diamonds, aes(x=cut, y=price)) +
    geom_jitter(alpha=1/3, shape=1, size=1, width=0.35, aes(color=carat)) + # adds spread to points for visulaization
    geom_violin(alpha=1/2, draw_quantiles=c(0.25, 0.5,0.75)) +
    scale_color_gradient('Diamond Size', low='#56b1f7',high='#c91010') +
    labs(x='Cut', y='Price', title='Price v. Cut & Carat') +
    theme_bw() +
    scale_y_continuous(labels=scales::dollar)

library(ggthemes)

g <- ggplot(diamonds, aes(x=carat, y=price, color=cut))
p <- g + geom_point()
p + theme_economist() +
    scale_color_economist()

p + theme_tufte()
p + theme_excel_new()
