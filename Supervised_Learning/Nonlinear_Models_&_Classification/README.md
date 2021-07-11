## Description
#### This project is aimed to see which classification models demonstrate the best performance on two different datasets. The two datasets are handled by distinct sets of modeling methods and all the models are implemented with several combinations of parameters to obtain the most optimal predictions avoiding over-fit or under-fit. The performances generated from the different models for each data set are compared based on their train and test errors computed by subtracting the accuracy from 1. 

## SET 1
### Data
   * **Source** 
     - *"Auto"* from ISLR package
     
   * **Number of Rows**
     - 392
     
   * **Used Features**
     - *mpg (Target)* - miles per gallon
     - *cylinders* - Number of cylinders between 4 and 8
     - *displacement* - Engine displacement (cu. inches)
     - *horsepower* - Engine horsepower
     - *weight* - Vehicle weight (lbs.)
     - *year* - Model year (modulo 100)


   * **Target**
     - *mpg01* - if mpg > median, 1 otherwise 0
     ```
     auto$mpg01 <- ifelse(auto$mpg > median(auto$mpg), 1,0)
     ```
     
   * **Train & Test Set**
     _ | Train | Test
     --|-------|-------
     Ratio|0.8|0.2
     Num|318|74
   
### Models
#### 1. K - Nearest Neighbor (KNN)
   * **Parameters**
     - K = 1:20
     - 10 folds for cross validation
   
   * **CV Errors by K:**
     
   
     
     
 <img src= width=50% height=50%>    









