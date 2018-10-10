data(father.son, package="UsingR")
head(father.son)

library(ggplot2)

# plot x and y
ggplot(father.son, aes(x=fheight, y=sheight)) +
        geom_point() +
        geom_smooth(method='lm')

# trend line on plot
height1 <- lm(sheight ~ fheight, data=father.son)
height1

summary(height1)

# tidy up summary of output
library(broom)
tidy(height1)

# land data set
land <- readRDS(here::here('data', 'manhattan_Train.rds'))
head(land)
View(land)

# plot that shit
names(land)
land1 <- lm(TotalValue ~ LotArea + NumFloors + BldgArea, data=land)
land1
summary(height1)

# graph it
library(coefplot)
coefplot(land1, sort='magnitude')

# zoom in
coefplot(land1, sort='magnitude') + xlim(-100, 100)

# scale by standard deviation Z-scale
land2 <- lm(TotalValue ~ scale(LotArea) + scale(NumFloors) + scale(BldgArea), 
            data=land)
coefplot(land2, sort='magnitude')
# more standard deviations
coefplot(land2, sort='magnitude', outerCI=4)
summary(land2)


# some dummy variable stuff
boros <- tibble::tribble(
    ~ Boro, ~ Pop, ~ Size, ~ Random, # labels
    "Manhattan", 1600000, 23, 15,
    "Brooklyn", 2800000, 78, 42,
    "Queens", 2400000, 104, 9,
    "Bronx", 1500000, 42, -6.5,
    "Staten Island", 475000, 60, 37
)

boros

library(useful)

# formulai multiplicitive effect
build.x( ~ Pop, data=boros)
build.x( ~ Pop + Size, boros)
build.x( ~ Pop * Size, boros)
build.x( ~ Pop * Size * Random, boros)
build.x( ~ Pop * Size * Random, boros)

# dummy variables
build.x( ~ Pop + Boro, boros)
build.x( ~ Pop + Boro, boros, contrasts=FALSE)
build.x( ~ Pop * Boro, boros)

# add math
build.x( ~ Pop + I(Pop^2), boros)
# get rid of intercept
build.x( ~ Pop + Size -1, boros)

names(land)
table(land$LandUse)

land3 <- lm(TotalValue ~ I(LotArea/1000) + I(BldgArea/1000) + NumFloors + BasementType,
            land)

coefplot(land3, sort="magnitude")

# how to determine the quality of model
AIC(land1, land2, land3) # lower is better
BIC(land1, land2, land3)

# TESTING THE DATA
landnew <- readRDS(here::here('data', 'manhattan_Test.rds'))

land3Predictions <- predict(land3, newdata=landnew, se.fit = TRUE)
head(land3Predictions$fit) # each row number and the predicted Y-values from the model
head(land3Predictions$se.fit)

# put into tibble
library(dplyr)
tibble::tibble(Prediction=land3Predictions$fit, SE=land3Predictions$se.fit) %>% 
    mutate(Lower=Prediction - 2*SE, 
            Upper=Prediction + 2*SE)

