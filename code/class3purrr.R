library(purrr)
list1 <- list(Fish=1:5, Pizza=3)
list1

list1$Fish
list1[[1]]
list1[['Fish']]

list3 <- list(A=1:5, B=LETTERS, 
              C=c('Hockey', 'Lacrosse', 'Curling'))
list3

list4 <- list(A=1:5, B=letters, list3)
list4
list4[[3]]$B[[5]]

head(iris)

list5 <-  list(list3, 1:5, iris)


theList <- list(A=1:100, B=17, C=c(3, 1, 8, 12))
theList
length(theList)
class(theList)
sum(theList[[1]])
sum(theList[[2]])

# from purrr 
map(theList, mean)

theList %>% map(sum) %>% class()

theList %>% map_dbl(sum) %>% mean() #returns a vector
