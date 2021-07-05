# Executive Summary

## Assignment
  * **Author:**
    - Seungheon Han
  * **Purpose:**
    - Assignment given by DNSC6211: Programming for Analytics
  * **Date:**
    - December 2020 
     
## Model
   * **Objective**
     - We are helping a chain of grocery stores to predict if sending out a personalized coupon to a customer will make him buy the product on the coupon.
     - **Predict which shoppers will become repeat buyers**

   * **Method**
     - Logistic Regression 
   * **Language/Software**
     - Python
     - Jupyter Notebook
## Data
   * **Source**
     - Prof. Shradha Gawankar in the DNSC6211: Programming for Analytics
     - Data is available [here](https://github.com/hshehjue/Data_Mining_Project/blob/main/Basic_Logics/Coupon/repeater_prediction.csv)
   * **Data Composition**
     - **Rows:** 47,954
     - **Columns:** 7
   * **Features**
     - *repeater(**Target**)* - 1 means the coupon was a success, 0 means the coupon was a failure
     - *chain* - An integer representing a store chain
     - *market* - An id representing a geographical region
     - *offervalue* - The dollar value of the offer
     - *avg_category_quantity* - The average number of units one must purchase to get the discount
     - *avg_category_amount* – The average dollar amount spend on the product category
     - *exact_item_bought* – The dollar amount of the purchase
    
