# Classification of Wine Quality Scores

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
  
  
       


   
    
  















