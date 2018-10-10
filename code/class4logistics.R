land <- readRDS(here::here('data', 'manhattan_Train.rds'))
table(land$HistoricDistrict) # look at data as table
class(land$HistoricDistrict) # bianry

# gaussion == linear model, default
# Binary == no/yes
# Poinsson == count
# multinomial == class

historic1 <- glm(HistoricDistrict ~ LotArea + BasementType + NumFloors,
                 data=land, 
                 family=binomial)
summary(historic1)

library(coefplot)
coefplot(historic1, sort='magnitude') # coefficients on log odds scale

landNew <- readRDS(here::here('data', 'manhattan_Test.rds'))

histPreds1.1 <- predict(historic1, newdata=landNew, se.fit=TRUE)
head(histPreds1.1)
histPreds1.2 <- predict(historic1, newdata=landNew, se.fit=TRUE, type='response')
head(histPreds1.2$fit, n=25) # gives probability of 'YES' because 'NO' was baseline
