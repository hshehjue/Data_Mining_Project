## Description
#### The assignment is designed to test diverse linear models along with manifold model selection techniques on an arbitrarily created dataset and datasets from an R package "ISLR". While each model being establined, the execution of the model selection prevented the data from being over or under-fitted. It was expected to keep the models' performance at the moderate or better level. In the Set(A), only a set of model selection methods are tested to see whether the methods properly sift out the variables where were employed to create the target variable. 

## SET (A)
### Data
----
   * **Source** 
     - **Simulated data:**
       - Y_hat = X + X^2 + X^3 + X^4 + X^5 + X^6 + X^7 + X^8 + X^9 + X^10
      
   * **Composition**
     - Rows = 100
     - Columns = 10
     
   * **Used Features**
     - X^1 ~ X^10


   * **Target**
     - Y = 
     ```
      set.seed(123)
      X <- rnorm(100) 
      error <- rnorm(100)
     ```
     ```
      beta <- c(3, 2, -3, 0.3)
      X.mat <- matrix(c(rep(1, 100), X, X^2, X^3), ncol = 4) 
      Y <- X.mat%*%beta + error
     ```
 
----
   
### Model Selection Methods
----
   
### 1. Best Subset Selection
   
  <img src=https://github.com/hshehjue/Project_Data_Mining/blob/main/Supervised_Learning/Linear_Models_%26_Model_Selection/image/best_sub.png width=70% height=70%> 

     
   * **CP**
     
   <img src=https://github.com/hshehjue/Project_Data_Mining/blob/main/Supervised_Learning/Nonlinear_Models_%26_Classification/images/KNN%20.png width=70% height=70%> 
   
   * **Optimal Parameters**
     - Best K = 8 
       - CV error = 0.1162

   * **Performance on Test Set**
     - Test Error = 0.1486
     
