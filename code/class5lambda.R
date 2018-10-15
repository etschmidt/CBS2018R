library(glmnet)
library(useful)
library(coefplot)
library(magrittr)

land_train <- readr::read_csv(here::here('data', 'manhattan_Train.csv'))
names(land_train)

valueFormula <- TotalValue ~ FireService + ZoneDist1 + ZoneDist2 + 
    Class + LandUse + OwnerType + LotArea + BldgArea + ComArea + 
    ResArea + OfficeArea + RetailArea + GarageArea + FactryArea +
    NumBldgs + NumFloors + UnitsRes + UnitsTotal + LotFront + LotDepth +
    BldgFront + BldgDepth+ Landmark + BuiltFAR + Built + HistoricDistrict - 1 # remove the alpha

value1 <- lm(valueFormula, data=land_train)

coefplot(value1, sort='magnitude', lambda='lamnda.min')

landY_train <- build.y(valueFormula, data=land_train)

y ~ x
output ~ input
~ input

head(landX_train)
head(landY_train)

value2 <- glmnet(x=landX_train, y=landY_train, family='gaussian')

plot(value2, xvar='lambda')

coefpath(value2) # interactive and labled plot
# but where is the best lambda to explain the model?

# have to CROSS VALIDATE model

value3 <- cv.glmnet(x=landX_train, y=landY_train, family='gaussian', nfolds=5) #lasso penalty

coefpath(value3) # shows minimal lambda

plot(value3) # shows mean squared error and number of variables in models

value4 <- cv.glmnet(x=landX_train, y=landY_train, family='gaussian', nfolds=5, alpha=0) #ridge penalty, never gets to Zero

coefpath(value4)

coefplot(value3, sort='magnitude', lambda='lambda.1se') # plot using number for lambda
value3$lambda.1se # get number for lambda
