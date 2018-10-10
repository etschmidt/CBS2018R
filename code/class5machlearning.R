# categorization and regression trees

library(useful)
library(xgboost)
library(coefplot)
library(magrittr)
library(dygraphs)

land_train <- reader::read_csv(here::here('data', 'manhattan_Train.csv')) # train
land_val <- readRDS(here::here('data', 'manhattan_validate.rds')) # tune
land_test <- readRDS(here::here('data', 'manhattan_Test.rds')) # test

table(land_train$HistoricDistrict) # is the plot historic or not?

histFormula <- HistoricDistrict ~ FireService + ZoneDist1 + ZoneDist2 + 
    Class + LandUse + OwnerType + LotArea + BldgArea + ComArea + 
    ResArea + OfficeArea + RetailArea + GarageArea + FactryArea +
    NumBldgs + NumFloors + UnitsRes + UnitsTotal + LotFront + LotDepth +
    BldgFront + BldgDepth+ Landmark + BuiltFAR + Built + TotalValue - 1

# built x & y matrices

landX_train <- build.x(histFormula, data=land_train, contrasts=FALSE, sparse=TRUE)

landY_train <- build.y(histFormula, data=land_train) %>% 
    as.factor() %>% as.integer() - 1 # factor variables that store special characters

landX_val <- build.x(histFormula, data=land_val, contrasts=FALSE, sparse=TRUE)

landY_val <- build.y(histFormula, data=land_val) %>% 
    as.factor() %>% as.integer() - 1 # xgboost expects 0 or 1

xgTrain <- xgb.DMatrix(data=landX_train, label=landY_train) # holds x and y matrices

xgVal <- xgb.DMatrix(data=landX_val, label=landY_val)

hist1 <- xgb.train(
    data=xgTrain,
    objective='binary:logistic',
    nrounds=1
)

hist1


xgb.plot.multi.trees(hist1, feature_names=colnames(landX_train)) # creates data tree

hist2 <- xgb.train(
    data=xgTrain, 
    objective='binary:logistic',
    nrounds=1,
    eval_metric='logloss', 
    watchlist=list(train=xgTrain),
    print_ever_n=1
)
hist3 <- xgb.train(
    data=xgTrain, 
    objective='binary:logistic',
    nrounds=300, #keeps learning from previous models
    eval_metric='logloss', 
    watchlist=list(train=xgTrain, validate=xgVal),
    print_ever_n=1
)

dygraph(hist3$evaluation_log)

hist3$evaluation_log$validate_logloss %>%  which.min

hist6 <- xgb.train(
    data=xgTrain, 
    objective='binary:logistic',
    nrounds=300, #keeps learning from previous models
    eval_metric='logloss', 
    watchlist=list(train=xgTrain, validate=xgVal),
    print_ever_n=1, 
    early_stopping_rounds = 60 # if the validation hasn't gotten better in 60 boosts, just stop
)

xgb.plot.multi.trees(hist6, feature_names = colnames(landX_train)) # plot the black box model

hist6 %>% xgb.importance(feature_names = colnames(landX_train)) %>% 
    xgb.plot.importance() # plotting the relative importance of variable

hist7 <- xgb.train(
    data=xgTrain, 
    objective='binary:logistic',
    nrounds=300, #keeps learning from previous models
    eval_metric='logloss', 
    watchlist=list(train=xgTrain, validate=xgVal),
    print_ever_n=1, 
    early_stopping_rounds = 60,
    max_depth =8 # set depth on tree, can prevent overfitting
)

hist7 <- xgb.train(
    data=xgTrain, 
    objective='binary:logistic',
    nrounds=300, #keeps learning from previous models
    eval_metric='logloss', 
    watchlist=list(train=xgTrain, validate=xgVal),
    print_ever_n=1, 
    early_stopping_rounds = 60,
    max_depth =3
)

# MINIMIZE 'VALIDATE-LOGLOSS'

