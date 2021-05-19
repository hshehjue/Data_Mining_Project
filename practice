for(i in 1:ncol(auto)){
  print(ggplot(auto, aes_string("mpg01", colnames(auto)[i]))+
          geom_jitter(aes(col=origin)))
}
### the most associated predictors: cylinders, displacement, horsepower, weight, year
train <- train %>%
  select(-c("acceleration", "origin"))
test <- test %>%
  select(-c("acceleration", "origin"))

train_x <- as.data.frame(train[,setdiff(names(train), c("mpg01"))])
train_y <- train[, "mpg01"]
test_x <- as.data.frame(test[, setdiff(names(test), c("mpg01"))])
test_y <- test[, "mpg01"]
### k-fold CV for find the best K in KNN model 
set.seed(123)
K.knn = c(1:20)
k.fold <- 10
folds <- createFolds(train_y, k = k.fold)

error.vec = NULL
for(i in K.knn){
  error.list = NULL
  for(j in 1:k.fold){
    knn.pred <- knn(train_x[-unlist(folds[j]),], train_x[unlist(folds[j]),], train_y[-unlist(folds[j])], k = i)
    cv.error <- sum(knn.pred != train_y[unlist(folds[j])])/length(unlist(folds[j]))
    error.list <- c(error.list, cv.error)
  }
  avg.error <- round(mean(error.list),4)
  error.vec <- c(error.vec, avg.error)
  print(paste("K =", i, "cv-error:", avg.error))
}

print(paste("The K minimizing the CV error: K =", match(min(error.vec), error.vec), "with error", min(error.vec)))

# tune.knn function generates the same result
set.seed(123)
tune.out.knn <- tune.knn(x = train_x, y = train_y, k=1:20)
print(paste("Best K:", tune.out.knn$best.parameters))

### comment ###
# K=8 generates the smallest validation error.
