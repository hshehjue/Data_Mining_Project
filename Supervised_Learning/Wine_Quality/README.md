# Model Card - Classification of Wine Quality Scores

## 1. Introduction

   * **Purpose**
 
     - In the project, we tried finding a multiclass classification model that classifies the wine quality scores with the lowest test errors by comparing multiple linear and non-linear models. The resulting model is designed to label each wine with its quality scores ranging from 3 to 9 based on the input data corresponding to the wine.

   * **Usage & Caution** 
  
     - we are expecting the best model built in the project can be employed for individuals, wine producers, or sommeliers to estimate the quality of the wine they are intersted in. However, the usage of the model should be careful in that the training data are confined to only part of the observable features of wine.

## 2. Data

  * **Database**
    
    - Wine Quality

  * **Sources** 
    
    - Created by: 
      - Paulo Cortez (Univ. Minho), Antonio Cerdeira, Fernando Almeida, Telmo Matos and Jose Reis (CVRVV) @ 2009
    - [UCI Machine Learning Repository](https://archive.ics.uci.edu/ml/datasets/Wine+Quality)

  * **Database Composition**
    
    - Rows: 6,497
    - Columns: 14

  * **Features of interest**
    
    - *quality(Target)*
    - fixed.acidity      
    - volatile.acidity 
    - citric.acid   
    - residual.sugar    
    - chlorides         
    - free.sulfur.dioxide 
    - total.sulfur.dioxide
    - density      
    - pH            
    - sulphates        
    - alcohol                     
    - color  

  * Feature "good" is removed from the columns due to its duplication with "quality"
    - quality score > 6 = good(1)
    - quality score =< 6 = bad(0)
 
  * **Training & Test Sets**
  
    1. Spliting the whole data

      _  |  Train  |  Test 
    -----|---------|---------
    Ratio | 80% | 20%
    Col | 13 | 13
    Row | 5223 | 1274
  
  
## 3. Model Details
  
  * **Model Developers** 
    - **Name:** SeungHeon Han, Leqi Yin, Qunzhe Ding 
    - **Affiliation:** the Master of Science in Business Analytics at *the George Washington University*
    - **Project Assigned By:** DNSC6279 - Data Mining
    - **E-mail:** seung225@gwu.edu
    
  * **Established Date**
    - 2021, April
 
  * **Model Types**
    - Support Vector Machine(SVM) with Radial Kernel Trick
      

  * **Software & Language**
    - R v4.0.3
    - R Studio v1.3.1093
  
  * **Inputs:**
    - *fixed.acidity*    
    - *volatile.acidity* 
    - *citric.acid*   
    - *residual.sugar*    
    - *chlorides*        
    - *free.sulfur.dioxide*
    - *total.sulfur.dioxide*
    - *density*    
    - *pH*            
    - *sulphates*        
    - *alcohol*                     
    - *color* 

  * **Target:**
    - *quality*

  * **Parameters**
   
   <img src=https://github.com/hshehjue/Project_Data_Mining/blob/main/Supervised_Learning/Wine_Quality/images/svm_r.png width=60% height=60%>
  
    - Cost = 100
    - Gamma = 1


## 4. Quantitative Analysis

### **4.1 Model Performance** 
* **Metrics**
  - Sensitivity 
    - True Positive / (True Positive + False Negative)  
  - Benchmark values
    - the proportion of the number of observations of test set response by each class to the total number of the observations of the test set response. 
  - Accuracy
    - (True Positive + True Negative) / (True Positive + True Negative + False Positive + False Negative)
  - Error
    - 1 - Accuracy

* **ON TEST DATA SET**
  
  - **Confusion Matrix**
   
   <img src=https://github.com/hshehjue/Project_Data_Mining/blob/main/Supervised_Learning/Wine_Quality/images/Confusion_svm_r.png width=50% height=50%>

  - **Sensitivity**
    
    3 | 4 | 5 | 6 | 7 | 8 | 9 
    ---|---|---|---|---|---|---
    0.000|0.133|0.714|0.746|0.617|0.378|NaN
    
  - **Benchmark**  
    
    3 | 4 | 5 | 6 | 7 | 8 | 9 
    ---|---|---|---|---|---|---
    0.0016|0.0353|0.3155|0.4568|0.1617|0.0290|0.0000
 
     - According to the sensitivity, the quality score 4, 5, 6, 7, 8 are relatively well classified when compared with the benchmark. The class 3 which has been trained with very small number of training observations demonstrates unsatisfactory accuracy. In the case of the class 9, the number of its observations is too small to be assigned to the test set.

  - **Accuracy**
    
    - Accuracy = 0.6813
    - The overall accuracy of the SVM model with radial kernel is about 68.13%
    
  - **Test Error**
    
    - 1 - Accuracy = 0.3187
    - The test error produced by the fitted SVM model with radial kernel is approximately 31.87%

### **4.2 Kernel**
   
   - *Pairs of variables with the seven classes of “quality”*

   <img src=https://github.com/hshehjue/Project_Data_Mining/blob/main/Supervised_Learning/Wine_Quality/images/svm_r_pre.png width=70% height=70%>
   
    - X-axis and Y-axis correspond to the different pairs of the independent variables and the seven distinct quality scores 
      are differentiated with different point colors. The distributions of the seven quality labels between different pairs of predictors 
      seem hard to be dissected by linear decision boundary through the one-versus-one approach. 
      Under the circumstances, the quality labels should be better to be classified by SVM models with radial and polynomial kernels.

    - Taking radial kernel here 


### **4.3 Model Debugging** 
   
   * **Remediation: Removing Outliers**
     
     - Box plots by columns before removing outliers
        
     <img src=https://github.com/hshehjue/Project_Data_Mining/blob/main/Supervised_Learning/Wine_Quality/images/prior_out.png width=70% height=70%>

     - Box plots by columns after removing outliers
     
     <img src=https://github.com/hshehjue/Project_Data_Mining/blob/main/Supervised_Learning/Wine_Quality/images/removed_out.png width=70% height=70%>

 
### **4.4 An Alternative Models**

* **Models**
  - SVM with polynomial basis kernel trick
  - Multinomial Logistic Regression
  - K-Nearest Neighbor(KNN)
  - Quadratic Discriminant Analysis(QDA)

### *the details of all the alternative models are described in the [Final Report]()*

* **Comparison among the models**
 
Model  |  Test Error
-------|---------
**SVM(radial kernel)** | **0.3187**
SVM(Polynomial kernel) | 0.3917
Logistic Regression | 0.4639
KNN | 0.3603
QDA | 0.4702
 
 

   
    
  















