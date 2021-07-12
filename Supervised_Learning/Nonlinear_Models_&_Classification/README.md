## Description
#### This project is aimed to see which classification models demonstrate the best performance on two different datasets. The two datasets are handled by distinct sets of modeling methods and all the models are implemented with several combinations of parameters to obtain the most optimal predictions avoiding over-fit or under-fit. The performances generated from the different models for each data set are compared based on their train and test errors computed by subtracting the accuracy from 1. 

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
     
### 2. Support Vector Machine (SVM) with Linear Classifier     
   * **Parameters**
     - Cost = [0.1, 1, 10, 100, 1000, 10000, 30000]
       
   <img src=https://github.com/hshehjue/Project_Data_Mining/blob/main/Supervised_Learning/Nonlinear_Models_%26_Classification/images/SVM_linear.png
 width=65% height=65%>
 
   * **Optimal Parameters**
     - Cost = 10000
       - CV-Error = 0.0817
       - Dispersion = 0.03
   
   * **Performance on Test Set**
     - Test Error = 0.0956
   
### 3. Support Vector Machine (SVM) with Radial Kernel  
   
   * **Parameters**
     - Cost = [0.1, 1, 10, 100, 1000]
     - Gamma = [0.5, 1, 2, 3, 4]
       
   <img src=https://github.com/hshehjue/Project_Data_Mining/blob/main/Supervised_Learning/Nonlinear_Models_%26_Classification/images/SVM_radial.png
 width=65% height=65%>  
 
 
   * **Optimal Parameters**
     - Cost = 1
     - Gamma = 3
       - CV-Error = 0.0627
       - Dispersion = 0.0388
 
   * **Performance on Test Set**
     - Test Error = 0.1081
  
 ### 4. Support Vector Machine (SVM) with Polynomial Kernel 
     
   * **Parameters**
     - Cost = [0.1, 1, 10, 100, 1000]
     - Degree = [1:10]
      
   <img src=https://github.com/hshehjue/Project_Data_Mining/blob/main/Supervised_Learning/Nonlinear_Models_%26_Classification/images/SVM_poly.png width=65% height=65%>
   
   
   * **Optimal Parameters**
     - Cost = 1000
     - Degree = 1
       - CV-Error = 0.0817
       - Dispersion = 0.0260
       
   * **Performance on Test Set**
     - Test Error = 0.0811

### Best Model 
  
  * the SVM model with polynomial basis kernel produces the smallest test error (= 0.0811).

----
## SET (B)
### Data
----
   * **Source** 
     - *"OJ"* from ISLR package
     
   * **Composition**
     - Rows = 1070
     - Columns = 18
     
   * **Used Features**
     - *Purchase(Target)* - A factor with levels CH and MM indicating whether the customer purchased Citrus Hill or Minute Maid Orange Juice
     - *WeekofPurchase* - Week of purchase
     - *StoreID* - Store ID
     - *PriceCH* - Price charged for CH
     - *PriceMM* - Price charged for MM
     - *DiscCH* - Discount offered for CH
     - *DiscMM* - Discount offered for MM
     - *SpecialCH* - Indicator of special on CH
     - *SpecialMM* - Indicator of special on MM
     - *LoyalCH* - Customer brand loyalty for CH
     - *SalePriceMM* - Sale price for MM
     - *SalePriceCH* - Sale price for CH
     - *PriceDiff* - Sale price of MM less sale price of CH
     - *Store7* - A factor with levels No and Yes indicating whether the sale is at Store 7
     - *PctDiscMM* - Percentage discount for MM
     - *PctDiscCH* - Percentage discount for CH
     - *ListPriceDiff* - List price of MM less list price of CH
     - *STORE* - Which of 5 possible stores the sale occured at


   * **Target**
     - *Purchase* - A factor with levels CH and MM indicating whether the customer purchased Citrus Hill or Minute Maid Orange Juice
     
   * **Train & Test Set**
     _ | Train | Test
     --|-------|-------
     Num|800|270
 
----
   
### Models
----
### 1. Classification Tree

#### Pruned Tree
   <img src=https://github.com/hshehjue/Project_Data_Mining/blob/main/Supervised_Learning/Nonlinear_Models_%26_Classification/images/tree_size_error.png width=60% height=60%> 
   
   * **Optimal Parameters**
     - Tree size: 8 or 9
   
   <img src=https://github.com/hshehjue/Project_Data_Mining/blob/main/Supervised_Learning/Nonlinear_Models_%26_Classification/images/pruned.png width=75% height=75%>    

   * **Tree Info** 
     - Num of terminal nodes: 8
     - Residual Mean Deviance: 0.7598
     - Training Error: 0.1588
     - Used Features:
       - *LoyalCH* 
       - *PriceDiff* 
       - *SpecialCH* 
       - *ListPriceDiff* 
       - *PctDiscMM*
    
   * **Performance on Test Set**
     - Test Error = 0.1704 

   
### 2. Gradient Boosting Machine (GBM)
  
   * **Parameters**
     - Distribution: Bernoulli
     - Tree size: 1000
     - Depth: 4
     - Shrinkage: [0.1, 0.3, 0.5, 0.7, 0.9]
   
  <img src=https://github.com/hshehjue/Project_Data_Mining/blob/main/Supervised_Learning/Nonlinear_Models_%26_Classification/images/train_error_shrinkage.png width=80% height=80%>   
  
  * **Optimal Parameters**
    - Distribution: Bernoulli
    - Tree size: 1000
    - Depth: 4
    - Shrinkage: 0.3
     
  * **Global Feature Importance** 
    
  <img src=https://github.com/hshehjue/Project_Data_Mining/blob/main/Supervised_Learning/Nonlinear_Models_%26_Classification/images/influence.png width=80% height=80%> 
  
  * **Performance on Test Set**
    - Test Error: 0.1963
    
    
### 3. Bagging 
   
   * **Parameters**
     - mtry: 17
   * **Results**
 <img src=https://github.com/hshehjue/Project_Data_Mining/blob/main/Supervised_Learning/Nonlinear_Models_%26_Classification/images/bagging.png width=50% height=50%>   
 
   * **Top3 Features**
     - *LoyalCH*
     - *WeekofPurchase*
     - *PriceDiff*
     
   * **Performance on Test Set**
     - Test Error = 0.1852

### 4. Randon Forest
   
   * **Parameters**
     - mtry: sqrt(p)
   * **Results**
 <img src= width=50% height=50%> 
   
 <img src= width=50% height=50%>    









