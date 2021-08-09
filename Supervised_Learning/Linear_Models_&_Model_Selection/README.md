## Description
#### The assignment is designed to test diverse linear models on an arbitrarily created dataset and datasets from an R programming package. While each model being establined, model selection was excuted to avoid being over or under-fitted, which would be expected to keep the performance at the moderate level. 
## SET (A)
### Data
----
   * **Source** 
     - *"Auto"* from ISLR package
     
   * **Composition**
     - Rows = 392
     - Columns = 9
     
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
 
----
   
### Models
----

##### *10-Folds Cross Validation*
   
### 1. K - Nearest Neighbor (KNN)
     
   * **Parameters**
     - K = [1:20]
     
   <img src=https://github.com/hshehjue/Project_Data_Mining/blob/main/Supervised_Learning/Nonlinear_Models_%26_Classification/images/KNN%20.png width=70% height=70%> 
   
   * **Optimal Parameters**
     - Best K = 8 
       - CV error = 0.1162

   * **Performance on Test Set**
     - Test Error = 0.1486
     
