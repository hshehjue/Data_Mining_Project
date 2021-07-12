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
   
   * **CV Errors by K:**
     <img src=https://github.com/hshehjue/Project_Data_Mining/blob/main/Supervised_Learning/Nonlinear_Models_%26_Classification/images/KNN%20.png width=70% height=70%> 
   
   * **Optimal Parameters**
     - Best K = 8 
     - CV error = 0.1162

   * **Performance on Test Set**
     - Test Error = 0.1486
     
### 2. Support Vector Machine (SVM) with Linear Classifier     
   * **Parameters**
     - Cost = [0.1, 1, 10, 100, 1000, 10000, 30000]
   
   * **CV Errors by Cost**
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
   
   * **CV Errors by Cost & Gamma**
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

   * **CV Errors by Cost & Gamma**
     <img src=https://github.com/hshehjue/Project_Data_Mining/blob/main/Supervised_Learning/Nonlinear_Models_%26_Classification/images/SVM_poly.png width=65% height=65%>
   
   
   * **Optimal Parameters**
     - Cost = 1000
     - Degree = 1
       - CV-Error = 0.0817
       - Dispersion = 0.0260
       
   * **Performance on Test Set**
     - Test Error = 0.0811

 <img src= width=50% height=50%>    









