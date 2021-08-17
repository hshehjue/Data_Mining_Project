pacman::p_load(ggplot2, nnet,dplyr,class,ISLR, e1071, caret, kknn, MASS, standardize)
wine <- read.csv("winequality.csv", header = TRUE)

#----------- Data exploration -----------#
dim(wine)
str(wine)
summary(wine)



### Detecting Null values
colSums(is.na(wine))



### converting ddata type
wine$quality <- factor(wine$quality)
wine$color <- as.factor(wine$color)
wine$good <- as.factor(wine$good)



### Target variable "quality"
qual.freq <- wine %>%
  group_by(quality) %>%
  summarise(frequency = n())

ggplot(qual.freq, aes(x = quality, y = frequency)) +
  geom_bar(stat="identity", fill = "pink") +
  geom_text(aes(label = frequency), vjust=0.3, size = 3.5) +
  theme_minimal()
# most of the data is concentrated on the classes 5,6,7
round(prop.table(table(wine$quality)),2) # the proportion of each class



### Variables correlation plot
dummy_var <- c('color', 'quality', 'good')
corrplot::corrplot(cor(wine[,setdiff(names(wine), dummy_var)]),type = 'upper', diag=T)



### Variable "good" = splitting quality 
qual.new <- ifelse(wine[,"quality"] %in% c(7,8,9), 1, 0)
# quality score > 6 = good(1)
# quality score =< 6 = bad(0)
table(qual.new == wine$good)
# good should be deleted



### relationships of each predictor with "quality" (bargraph)
for(i in 1:11){
  print(ggplot(wine, aes_string("quality", colnames(wine)[i]))+
          geom_jitter(aes(col=color, alpha = 0.1)))
}

### boxplot
featurePlot(x = wine[, 1:11], 
            y = wine$quality, plot = "box", 
            scales = list(x = list(relation="free"), y = list(relation="free")), 
            adjust = 1.5, pch = ".", 
            layout = c(4, 3), auto.key = list(columns = 3))

# most of the variables show weak relationships with "quality"
# a lot of outliers



#------------- Preprocessing -------------#
### Deleteing "good"
wine <- wine[,setdiff(names(wine), c("good"))]



### Removing outliers 
q.u <- 0.95
q.l <- 0.01
var.list <- setdiff(names(wine), c("quality", "color"))
for (i in 1:length(var.list)) {
  var <- var.list[i]
  eval(parse(text = paste0('v <- wine$',var)))
  q.v.u <- quantile(v, c(q.u))
  q.v.l <- quantile(v, c(q.l))
  v.r <- ifelse(v > q.v.u, q.v.u, v)
  v.r <- ifelse(v.r < q.v.l, q.v.l, v.r)
  eval(parse(text = paste0('wine$',var,'<- v.r')))
}


### boxplot after removing outlier
featurePlot(x = wine[, 1:11], 
            y = wine$quality, plot = "box", 
            scales = list(x = list(relation="free"), y = list(relation="free")), 
            adjust = 1.5, pch = ".", 
            layout = c(4, 3), auto.key = list(columns = 3))



### Scaling data
wine.scaled <- scale(wine[,-c(12,13)])
wine <- cbind(wine.scaled, wine[,c("quality","color")])
summary(wine)



### Train & Test sets 
set.seed(111)
split <- sample(2, nrow(wine), replace=T, prob = c(0.8, 0.2)) # split the data set into 8:2
train <- wine[split == 1,]
test <- wine[split == 2,]


train.x <- as.data.frame(train[,setdiff(names(train), c("quality"))])
train.y <- train[, "quality"]
test.x <- as.data.frame(test[, setdiff(names(test), c("quality"))])
test.y <- test[, "quality"]



#-------------- Modeling & Validation --------------#

#--------- (1) SVM --------#
dev.off()
par(mfrow = c(3,2))
plot(train[,c("density", "residual.sugar")], col = train$quality)
plot(train[,c("citric.acid", "volatile.acidity")], col = train$quality)
plot(train[,c("chlorides", "free.sulfur.dioxide")], col = train$quality)
plot(train[,c("total.sulfur.dioxide", "volatile.acidity")], col = train$quality)
plot(train[,c("pH", "sulphates")], col = train$quality)
plot(train[,c("density", "alcohol")], col = train$quality)
# support vector classifier should not be linear
# use kernel tricks 



### SVM with One vs One Approach 

### Radial kernel
### Find the optimal tuning parameters(cost & gamma)
set.seed(111)
cost = c(1,10,100)
gamma = c(0.01,0.1,1,3,5)
k.fold <- 5
folds <- createFolds(train.y, k = k.fold)

error.vec = NULL
for(i in cost){
  for(g in gamma){
    error.list = NULL
    for(j in 1:k.fold){
      svm.fit <- svm(quality~., train[-unlist(folds[j]),], kernel="radial", cost = i, gamma = g)
      svm.pred <- predict(svm.fit, train.x[unlist(folds[j]),])
      cv.error <- sum(svm.pred != train.y[unlist(folds[j])])/length(unlist(folds[j]))
      error.list <- c(error.list, cv.error)
    }
    avg.error <- round(mean(error.list),4)
    error.vec <- c(error.vec, avg.error)
    print(paste("cost =", i, "gamma =",g,"cv-error:", avg.error))
  }
}


### graph for tuning parameters
Error <- error.vec
cost <- c(rep(1,5), rep(10,5), rep(100,5))
gamma <- c(0.01, 0.1, 1, 3, 5, 0.01, 0.1, 1, 3, 5, 0.01, 0.1, 1, 3, 5)
plot.angle <- 45
scatterplot3d(cost, gamma, Error, type="h", angle=plot.angle, color="blue", pch=20, cex.symbols=2, 
              col.axis="gray", col.grid="gray")

### model fitting 
svmfit.rad = svm(quality~., data = train, kernel="radial", cost=100, gamma = 1) 
summary(svmfit.rad)



### Validation 
## confusion matrix
pred.rad <- predict(svmfit.rad, test.x)
## confusion matrix
t.rsvm <- table(pred.rad, test.y)

## sensitivity
sensitivity <- t.rsvm/colSums(t.rsvm)
diag(sensitivity) # classes 4, 5, 6, 7 are relatively better predicted 

## benchmark
n <- table(test.y) 
n/sum(n) # Quality 5, 6, 7 cases outnumber the rest of the cases in the Test Set

## test error
1-sum(diag(t.rsvm))/sum(t.rsvm)

## accuracy
sum(diag(t.rsvm))/sum(t.rsvm)





### polynomial kernel
## Find the optimal tuning parameters(cost & degree)
set.seed(111)
cost = c(1,10,100)
degree = seq(2,10,2)
k.fold <- 5
folds <- createFolds(train.y, k = k.fold)

error.vec = NULL
for(i in cost){
  for(d in degree){
    error.list = NULL
    for(j in 1:k.fold){
      svm.fit <- svm(quality~., train[-unlist(folds[j]),], kernel = "polynomial", cost = i, degree = d)
      svm.pred <- predict(svm.fit, train.x[unlist(folds[j]),])
      cv.error <- sum(svm.pred != train.y[unlist(folds[j])])/length(unlist(folds[j]))
      error.list <- c(error.list, cv.error)
    }
    avg.error <- round(mean(error.list),4)
    error.vec <- c(error.vec, avg.error)
    print(paste("cost =", i, "degree =", d,"cv-error:", avg.error))
  }
}

### graph for tuning parameters
Error <- error.vec
cost <- c(rep(1,5), rep(10,5), rep(100,5))
degree <- c(rep(seq(2,10,2),3))
plot.angle <- 45
scatterplot3d(cost, degree, Error, type="h", angle=plot.angle, color="blue", pch=20, cex.symbols=2, 
              col.axis="gray", col.grid="gray")


### model fitting 
svmfit.pol = svm(quality~., data = train, kernel="polynomial", cost=100, degree = 4) 
summary(svmfit.pol)


### Validation 
## confusion matrix
pred.pol <- predict(svmfit.pol, test.x)
t.psvm <- table(pred.pol, test.y)

## sensitivity
sensitivity.poly <- t.psvm/colSums(t.psvm)
diag(sensitivity.poly) 

## benchmark
n <- table(test.y) 
n/sum(n) # Quality 5, 6, 7 cases outnumber the rest of the cases in the Test Set

### test error
1-sum(diag(t.psvm))/sum(t.psvm)

### accuracy
sum(diag(t.psvm))/sum(t.psvm)



#----------- (3) Logistic Regression ------------#

### model fitting 
train$quality <- relevel(train$quality, ref = "3") # Setting the reference group of the target variable
train.logit <- multinom(quality~., data = train)
summary(train.logit)


### p-value
z <- summary(train.logit)$coefficients/summary(train.logit)$standard.errors
p <- (1-pnorm(abs(z),0,1)) * 2 # p-values 
p  # the predictors: total.sulfur.dioxide is not statistically significant


### Remove the nonsignificant variable from the train set
train.new <- train[,-c(3,7)]
test.new <- test[,-c(3,7)]

### Refit the logistic regression model
logit.new <- multinom(quality~., data = train.new)
summary(logit.new)
z.new <- summary(logit.new)$coefficients/summary(logit.new)$standard.errors
p.new <- (1-pnorm(abs(z.new),0,1)) * 2 # p-values 
p.new # every feature is significant based on their p-values



### Prediction
pred.test <- predict(logit.new, test.new) 

## confusion matrix
t.logit <- table(pred.test, test.y)

## sensitivity
sensitivity <- t.logit/colSums(t.logit)
diag(sensitivity) # classes 4, 5, 6, 7 are relatively better predicted 

## benchmark
n <- table(test.y) 
n/sum(n) # Quality 5, 6, 7 cases outnumber the rest of the cases in the Test Set

## test error
1-sum(diag(t.logit))/sum(t.logit) 

## accuracy
sum(diag(t.logit))/sum(t.logit)







#----------- (2) KNN -----------#
### 5-fold CV for the optimal K
set.seed(111)
K.knn = c(1:20)
k.fold <- 5
folds <- createFolds(train.y, k = k.fold)

error.vec = NULL
for(i in K.knn){
  error.list = NULL
  for(j in 1:k.fold){
    knn.pred <- kknn(quality~., train[-unlist(folds[j]),], train[unlist(folds[j]),], k = i, distance=2)
    cv.error <- sum(knn.pred$fitted.values != train.y[unlist(folds[j])])/length(unlist(folds[j]))
    error.list <- c(error.list, cv.error)
  }
  avg.error <- round(mean(error.list),4)
  error.vec <- c(error.vec, avg.error)
  print(paste("K =", i, "cv-error:", avg.error))
}
print(paste("The K minimizing the CV error: K =", match(min(error.vec), error.vec), "with error", min(error.vec)))

knn.tune.df <- data.frame("Error" = error.vec, "K" = c(1:20))
ggplot(data = knn.tune.df, aes(x = K, y = Error)) +
  geom_line(col = "blue") + 
  geom_point(col = "blue")


### model fitting 
knn.fit <- kknn(quality~.,train, test, k=1, distance = 2)
pred.knn <- knn.fit$fitted.values



### Validation 
## confusion matrix
t.knn <- table(pred.knn, test.y)
t.knn

## test errors 
1-sum(diag(t.knn))/sum(t.knn) 

## accuracy
sum(diag(t.knn))/sum(t.knn) 

## sensitivity
diag(t.knn/colSums(t.knn))  

## benchmark
n <- table(test.y) 
n/sum(n) 



#-----------(4) QDA -----------#
table(wine$quality)
# type 9 is very small
# So qda model is not suitable to this dataset 
# first, we drop quality = 9 and 3 and try again

wine <- read.csv("winequality.csv")
wine <- wine[wine$quality != 3,]
wine <- wine[wine$quality != 9,]
wine$quality <- as.factor(wine$quality)
wine$color <- as.factor(wine$color)



### deleting "good"
wine <- wine[,setdiff(names(wine), c("good"))]



### Removing outliers 
q.u <- 0.95
q.l <- 0.01
var.list <- setdiff(names(wine), c("quality", "color"))
for (i in 1:length(var.list)) {
  var <- var.list[i]
  eval(parse(text = paste0('v <- wine$',var)))
  q.v.u <- quantile(v, c(q.u))
  q.v.l <- quantile(v, c(q.l))
  v.r <- ifelse(v > q.v.u, q.v.u, v)
  v.r <- ifelse(v.r < q.v.l, q.v.l, v.r)
  eval(parse(text = paste0('wine$',var,'<- v.r')))
}



### Scaling data
wine.scaled <- scale(wine[,-c(12,13)])
wine <- cbind(wine.scaled, wine[,c("quality","color")])
summary(wine)



### spliting the dataset into train and test sets
set.seed(2020)
train_sample <- sample(1:dim(wine)[1],0.8*dim(wine)[1])
train_wine <- wine[train_sample,]
test_wine <- wine[-train_sample,]



### fitting QDA model
model_qda <- qda(quality~., data = train_wine)



### prediction
pred_test_qda <- predict(model_qda, test_wine)$class



### confusion martix
confusion_matrix_test <- table(pred_test_qda, test_wine$quality)
confusion_matrix_test


### test error
1-sum(diag(confusion_matrix_test))/sum(confusion_matrix_test) 


### accuracy
sum(diag(confusion_matrix_test))/sum(confusion_matrix_test) 


### sensitivity
diag(confusion_matrix_test/colSums(confusion_matrix_test))   


### benchmark
n <- table(test_wine$quality) 
n/sum(n) 


14.8569+(175.7*-0.03575)+(960.3*0.04711)-(1.47*0.09444)
14.86-0.034*168.6+0.047*952.1+0.094*(-1.653)+1.519*(1.4645)-0.629*-1.6586



22.9606+0.7860*2


#----------- Best Model -----------#
# SVM with radial ketnel with test error: 0.32






