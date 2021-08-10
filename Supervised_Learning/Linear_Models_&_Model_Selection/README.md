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
     - Y = 3 + 2*X + (-3)*X^2 + (0.3)*X^3 + Error
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
   
  <img src=https://github.com/hshehjue/Project_Data_Mining/blob/main/Supervised_Learning/Linear_Models_%26_Model_Selection/image/best_sub.png width=58% height=58%> 

     
   * **Cp**
     
   <img src=https://github.com/hshehjue/Project_Data_Mining/blob/main/Supervised_Learning/Linear_Models_%26_Model_Selection/image/best_cp.png
 width=87% height=87%> 
   
     - Optimal Number of Variables = 3
     - Cp with 3 = 2.185
     
       
   * **BIC**
     
   <img src=https://github.com/hshehjue/Project_Data_Mining/blob/main/Supervised_Learning/Linear_Models_%26_Model_Selection/image/best_BIC.png
 width=87% height=87%> 
   
    - Optimal Number of Variables = 3
    - BIC with 3 = -267.576
    
   * **Adjusted R-sq**
     
   <img src=https://github.com/hshehjue/Project_Data_Mining/blob/main/Supervised_Learning/Linear_Models_%26_Model_Selection/image/best_adjR.png
 width=87% height=87%> 
   
     - Optimal Number of Variables = 6
     - adj-R^2 with 6 = 0.9418
     

### 2. Forward Stepwise Selection
     
  <img src=https://github.com/hshehjue/Project_Data_Mining/blob/main/Supervised_Learning/Linear_Models_%26_Model_Selection/image/fwd.png width=58% height=58%> 
  
  
   * **Cp**
     
   <img src=https://github.com/hshehjue/Project_Data_Mining/blob/main/Supervised_Learning/Linear_Models_%26_Model_Selection/image/fwd_cp.png
 width=87% height=87%> 
   
     - Optimal Number of Variables = 3
     - Cp with 3 = 2.185


   * **BIC**
     
   <img src=https://github.com/hshehjue/Project_Data_Mining/blob/main/Supervised_Learning/Linear_Models_%26_Model_Selection/image/fwd_BIC.png
 width=87% height=87%> 
   
    - Optimal Number of Variables = 3
    - BIC with 3 = -267.576
    
   
   * **Adjusted R-sq**
     
   <img src=https://github.com/hshehjue/Project_Data_Mining/blob/main/Supervised_Learning/Linear_Models_%26_Model_Selection/image/fwd_adj.png
 width=87% height=87%> 
   
     - Optimal Number of Variables = 4
     - adj-R^2 with 4 = 0.9411
  
  
### 3. Backward Stepwise Selection
     
  <img src=https://github.com/hshehjue/Project_Data_Mining/blob/main/Supervised_Learning/Linear_Models_%26_Model_Selection/image/bwd.png width=58% height=58%> 
  
  
   * **Cp**
     
   <img src=https://github.com/hshehjue/Project_Data_Mining/blob/main/Supervised_Learning/Linear_Models_%26_Model_Selection/image/bwd_cp.png
 width=87% height=87%> 
   
     - Optimal Number of Variables = 6
     - Cp with 3 = 4,261


   * **BIC**
     
   <img src=https://github.com/hshehjue/Project_Data_Mining/blob/main/Supervised_Learning/Linear_Models_%26_Model_Selection/image/bwd_BIC.png
 width=87% height=87%> 
   
    - Optimal Number of Variables = 6
    - BIC with 3 = -258.02
    
   
   * **Adjusted R-sq**
     
   <img src=https://github.com/hshehjue/Project_Data_Mining/blob/main/Supervised_Learning/Linear_Models_%26_Model_Selection/image/bwd_adj.png
 width=87% height=87%> 
   
     - Optimal Number of Variables = 6
     - adj-R^2 with 4 = 0.9416
     
 

### 4. Lasso Regression 

   * **Data Split**
     - Train (50%) & Test (50%)

   * **Best Tuning Parameter (Lambda)**
   
   <img src=https://github.com/hshehjue/Project_Data_Mining/blob/main/Supervised_Learning/Linear_Models_%26_Model_Selection/image/lambda.png
 width=87% height=87%> 
 
    - by 10-fold cross validation   
  
   * **Lasso Coefficient (with the optimal lambda)**
   
   <img src=https://github.com/hshehjue/Project_Data_Mining/blob/main/Supervised_Learning/Linear_Models_%26_Model_Selection/image/lasso_coeff1.png
 width=57% height=57%> 
   <img src=https://github.com/hshehjue/Project_Data_Mining/blob/main/Supervised_Learning/Linear_Models_%26_Model_Selection/image/lasso_coeff2.png
 width=57% height=57%> 
   
