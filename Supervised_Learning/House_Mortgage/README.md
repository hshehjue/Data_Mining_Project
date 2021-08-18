# Model Card - *Classifying Higher-priced Mortgage Loan*

## 1. Intended Use
* **Business Value**
  - The remediated model across gender and race is expected to be able to provide fair and objective reference to classifying loan applicanats into regular or higher-priced mortgage loan borrowers. 
  - The model will help mortgage loan lenders reduce the risk of having customers who can potentially default by giving extra information on the quality of the loan applicants other than their credits or APR etc.
  - The model trained on the only six most contributed features can produce accurate predictions requiring small cost on input data. 

* **Usage**
  - The model requires six data from a loan applicant:
    * *DTI, income, introductory rate period, whether the mortgage includes an introductory rate period, property value, and loan amount*
  - Input the data to the model after scaling
  - Based on the inputs, the model classifies the applicant's mortgage into either HPML or regular one. 
   
* **Users**
  - Lending companies or other financial institutions that make mortgage loans including nonmonetary institutions
    * insurance company
    * commercial bank
    * credit union
    * government lending agency

* **Caution**
  - The model may not be appropriate to be used as a main index for making decisions in business
  - The model performance can exponentially drop in special situations such as recession
  - The model is encouraged to be deployed only for mortage loans

----------------

## 2. Training Data
* **Data:** Home Mortgage Disclosure Act (HMDA)
* **Source:** Github repository of jphall663 [Link](https://github.com/jphall663/GWU_rml/tree/master/assignments/data)
  - Same data sets are also available [here](https://github.com/hshehjue/Project_Data_Mining/tree/main/Supervised_Learning/House_Mortgage/data)
* **Training & Validation Sets Composition:**
  1. Spliting the whole data

    _  |  Train  |  Valid 
  -----|---------|---------
  Ratio | 70% | 30%
   Col | 24 | 24
   Row | 112146 | 48026
   
   - 12 out of 24 features are used for the training process including the target variable ("high_priced")
  ------
  
  2. Spliting the repaired data in the debiasing process
  
    _  |  Train  |  Valid 
  -----|---------|----------
  Ratio | 70% | 30%
   Col | 13 | 13
   Row | 6792 | 3002
   
   - the transformed data is repaired by [DisparateImpactRemover - AIF360](https://github.com/Trusted-AI/AIF360/blob/master/aif360/algorithms/preprocessing/disparate_impact_remover.py) 
   - 1 out of 13 features is used for separating the data into "black" & "white" groups as a protected attribute
   - 7 out of 13 features are used for the training process including the target variable
   - transformed data is available [here](https://github.com/hshehjue/Project_Data_Mining/tree/main/Supervised_Learning/House_Mortgage/data)
   ------
   
  
* **Features of interest:**
  * **high priced (*Target*)** - Binary target, whether (1) or not (0) the annual percentage rate (APR) charged for a mortgage is 150 basis points (1.5%) or more above a survey-based  estimate of similar mortgages
  * **conforming** - Binary numeric input, whether the mortgage conforms to normal standards (1), or whether the loan is different (0)
  * **debt to income ratio std** - Numeric input, standardized debt-to-income ratio for mortgage applicants.
  * **debt to income ratio missing** - Binary numeric input, missing marker (1) for debt to income ratio std.
  * **income std** - Numeric input, standardized income for mortgage applicants.
  * **loan amount std** - Numeric input, standardized amount of the mortgage for applicants.
  * **intro rate period std** - Numeric input, standardized introductory rate period for mortgage applicants.
  * **loan to value ratio std** - Numeric input, ratio of the mortgage size to the value of the property for mortgage applicants.
  * **no intro rate period std** - Binary numeric input, whether or not a mortgage does not include an introductory rate period.
  * **property value std** - Numeric input, value of the mortgaged property.
  * **term 360** - Binary numeric input, whether the mortgage is a standard 360 month mortgage (1) or a different
type of mortgage (0).
  * **loan_amt:prprty_vl (*Inter*)** - Numeric input, an interaction variable created by multiplying "loan amount std" & "property value std".
    - "loan amount std" & "property value std" are the only highly correlated pair of features (ρ = 0.94)
    - Considering the interaction effect of the two features, combine the two by multiplying:
       ```
       tr_df["loan_amt:prprty_vl"] = tr_df["loan_amount_std"]*tr_df["property_value_std"]
       test["loan_amt:prprty_vl"] = test["loan_amount_std"]*test["property_value_std"]
       ```
----
## 3. Evaluation Data
* **Source:** Github repository of jphall663 [Link](https://github.com/jphall663/GWU_rml/tree/master/assignments/data)
  - Same data sets are also available [Here](https://github.com/hshehjue/Project_Data_Mining/tree/main/Supervised_Learning/House_Mortgage/data)
  
* **Test Data Composition:** 
  - number of row: 19,831
  - number of column: 23 + 1 (inter)
  - the interaction variable "loan_amt:prprty_vl" has to be included manually when obtaining prediction scores. 

----
## 4. Model Details
* **Model Developer:** 
  - **Name:** Han, Seungheon 
  - **Affiliation:** the Master of Science in Business Analytics at *the George Washington University*
  - **Project Assigned By:** DNSC6290_11 - Responsible Machine Learning
  - **E-mail:** seung225@gwu.edu
* **Established Date:**
2021, June
* **Model Type:**
*Explainable Boosting Machine ([EBM](https://github.com/interpretml/interpret))* 
  - EBM is a generalized additive version of GBM model which provides high-level of interpretability as a glass-box model
* **Software & Language**
  - Jupyter notebook v6.0.3
  - Python v3.8.3
* **Inputs:**
  - *debt to income ratio std*
  - *income std*
  - *intro rate period std*
  - *no intro rate period std*
  - *property value std*
  - *loan amount std*
* **Target:**
  - *high priced*
* **Parameters**
  Hyper Parameters | Value
  -----------------|---------
   max bins | 128
   max interaction_bins | 16
   interactions | 15
   outer bags | 4
   inner bags | 4
   learning rate | 0.05
   validation size | 0.25
   min samples leaf | 5
   max leaves | 5
   early stopping rounds | 100
   number of jobs | 4 
   random state | 12345
   cutoff | 0.17
  
   - These are the parameters found by a random grid search with the pre-set hyperparameters 
--------
## 5. Quantitative analysis

### **5.1 Model Performance** 
* **Metrics:**
  - AUC 
  - f1 
  - Accuracy 
  - MSE 
  - Logloss 
   
* **ON VALIDATION DATA**
    * **AUC = 0.7806**
    <img src=https://github.com/hshehjue/Project_Data_Mining/tree/main/Supervised_Learning/House_Mortgage/images/ROC.png width=50% height=50%>

    * **Confusion Matrix**
      _ | Positive | Negative
      --|----------|-----------
      Positive | 1,407 | 4,038
      Negative | 3,223 | 39,358
  
    * **True Positive Rate:** 0.304
    * **False Positive Rate:** 0.093
 
 * **ON TEST DATA**
    * each value was calculated over five folds  
      fold | ACC | AUC | F1 | Logloss | MSE
      -----|-----|-----|----|---------|-----
      1 | 0.901 | 0.839 | 0.407 | 0.251 | 0.077
      2 | 0.907 | 0.827 | 0.369 | 0.247 | 0.075
      3 | 0.909 | 0.829 | 0.372 | 0.244 | 0.073
      4 | 0.904 | 0.826 | 0.369 | 0.252 | 0.077
      5 | 0.898 | 0.830 | 0.397 | 0.264 | 0.080
    
    * average the five folds
      _ | ACC | AUC | F1 | Logloss | MSE
      --|-----|-----|----|---------|-----
      AVG | 0.904 | 0.830 | 0.383 | 0.252 | 0.076
   

### **5.2 Global Feature Importance**
* **Bar graph for Features vs. Mean Abs Feature Score**
  <img src=https://github.com/hshehjue/Responsible_ML/blob/main/images/feature_importance.png width=80% height=80%>
  - "loan_to_value_ratio_std" has the dominant influence on classifying "high_priced" label
  - "loan_amount_std", "property_value_std", and "debt_to_income_ratio_std" are also substantially affecting the response at the similar level

### **5.3 Feature Behavior**
* **ICE curve with histogram:**
  <img src=https://github.com/hshehjue/Responsible_ML/blob/main/images/ICE1.png width=80% height=80%>
  <img src=https://github.com/hshehjue/Responsible_ML/blob/main/images/ICE2.png width=80% height=80%>
  <img src=https://github.com/hshehjue/Responsible_ML/blob/main/images/ICE3.png width=80% height=80%>
  <img src=https://github.com/hshehjue/Responsible_ML/blob/main/images/ICE4.png width=80% height=80%>
  - Red line represents the partial dependence
  - Inconsistent local behaviors are observed in every feature except "term_360", "conforming", "debt_to_income_ratio_missing", and "loan_amount_property_value" 
  - In particular, the rows belonging to higher percentile groups are more likely to behave differently compared to the partial dependence

### **5.4 Bias Mitigation (Disparate Impact Remover)**
* **Protected Groups**
  - Asian people
  - Black people
  - Female
  
* **Referenced Groups**
  - White people
  - Male
  
* **Major metrics for bias:** *Adverse Impact Ratio (AIR)*
  - % accepted (prt) / % accepted (ref)
  
* **Threshold for AIR**
  - acceptable level: > 0.8 
  
* **AIR for the three groups of interest**
  Groups | AIR
  -------| ------
  White vs Asian | 1.204 > 0.8
  White vs Black | 0.686 **< 0.8**
  Male vs Female | 0.948 > 0.8

  - the model can potentially arouse discrimination against dark-skinned loan applicants
 
* **DEBIASING**
  - **Preprocessing Approach - Disparate Impact Remover provided by [AIF360](https://github.com/Trusted-AI/AIF360)** 
    * train EBM on the repaired data and then implementing another random grid search considering AIR with 0.17 cutoff 
    * retrain EBM with the optimal parameters and features obtained by the grid search
* **AIR from the remediated EBM**
  Groups | AIR
  -------| ------
  White vs Asian | 1.065 > 0.8
  White vs Black | 0.849 **> 0.8**
  Male vs Female | 0.981 > 0.8

  - All the three groups have the AIR greater than 0.8

### **5.5 Security**
* **White-hat Sorrogate Model & Adversarial Example**
  <img src=https://github.com/hshehjue/Responsible_ML/blob/main/images/stolen.png width=100% height=100%>
  <img src=https://github.com/hshehjue/Responsible_ML/blob/main/images/adversarial_ex.png width=80% height=80%>
  - restore the decision tree based on the simulated data and the predicted values
  - Based on the restored model, extremely high and low predictions can be generated
 
### **5.6 Model Debugging** 
* **Residual Plot Analysis**
  * <img src=https://github.com/hshehjue/Responsible_ML/blob/main/images/residual.png width=40% height=40%>
  * the model performance in classification can be unbalanced by labels
* **Remediation: Down-Sampling** 
  - Manually driving up the signal from high-priced loans to fix the unbalanced residuals
  - Leading to increase bias, which lowers the AIR for the "White vs Black" group 
     Groups | AIR
     -------| ------
    White vs Asian | 1.236 > 0.8
    White vs Black | 0.625 **< 0.8**
    Male vs Female | 0.969 > 0.8
  
* **Remediation: Removing Outliers**
  - the AUC on the original valid set has become lower than the original debiased model
  - 0.7806 -> 0.7658
    * The initial EBM was trained on the data where only the outliers from "loan_to_value_ratio_std" had been removed. So, the outliers detected from the other features may have some valuable information that the other values do not have when it comes to predicting high_priced. 

### **5.7 An Alternative Model**
* **Model:**
  - **Extreme Gradient Boosting Machine [XGBoost](https://xgboost.readthedocs.io/en/latest/tutorials/monotonic.html)**
* **Performance**
  - **on test data**
    * each value was calculated over five folds  
      fold | ACC | AUC | F1 | Logloss | MSE
      -----|-----|-----|----|---------|-----
      1 | 0.902 | 0.814 | 0.376 | 0.262 | 0.078
      2 | 0.906 | 0.790 | 0.339 | 0.263 | 0.078
      3 | 0.908 | 0.798 | 0.349 | 0.258 | 0.075
      4 | 0.903 | 0.793 | 0.342 | 0.268 | 0.079
      5 | 0.896 | 0.810 | 0.383 | 0.275 | 0.082
    
    * average the five folds
      *XGB* | ACC | AUC | F1 | Logloss | MSE
      --|-----|-----|----|---------|-----
      AVG | 0.903 | 0.801 | 0.358 | 0.265 | 0.078
      
      **Comparing to EBM**
      *EBM* | ACC | AUC | F1 | Logloss | MSE
      --|-----|-----|----|---------|-----
      AVG | 0.904 | 0.830 | 0.383 | 0.252 | 0.076
    
    * When comparing the two models, the average performance of the XGBM model is not as good as EBM 
    
---------
## 6. Ethical considerations
* **Potential Negative Impacts**
  - the model has not been established incorporating every possible unprivileged or minority groups. Therefore, any decisions made based on the model can have potential risks of threatening the customers in the groups of disabled people, LGBTQ, minority race etc.  

* **Potential Uncertainties**
  - changes in financial laws or government regulations related to mortgage loans can make the model out-dated, which cannot offer meaningful information anymore. 
  - the training data does not reflect special economic situations. In other words, the model performance can drastically vary by external factors such as recession. 
 

* **Unexpected Results during Training Process**
  - training model on under-sampled data incurred serious bias in black people and white people group 
