# Univariate & Multivariate Time Series Analysis: Web Visit Frequency
### LINK()
## Information
* **Project Type:** Final Project
* **Delievered by:** DNSC6219: Time Series Forecasting for Analytics
  - *Master of Science in Business Analytics(MSBA) at The George Washington University*
* **Contributors:** Seungheon Han, Alexis Yang, Qunzhe Ding, Chengshu Yang
* **Email:** seung225@gwu.edu (SeungHeon Han)
* **Analysis Tool:** SAS v9.4

## Executivce Summary
* **Project Goal:** Analyze the time series data in a variety of methods to find out the best time series forecast model for a dependent variable. The analyses take different approaches encompassing univariate and multivariate deterministic and stochastic methods. 

* **Data Description:** the data contains 5 years of daily time series data for several measures of traffic on the [website](https://people.duke.edu/~rnau/411home.htm). The database consists of 7 columns and 2167 rows ranging from September 14, 2014, to August 19, 2020. 
  - Day: Day of week in text form (Sunday, etc.)
  - Day.Of.Week: Day of week in numeric form (1-7)
  - Date: Date in mm/dd/yyyy format
  - Unique.Visits: Daily number of visitors from whose IP addresses there haven't been hits on any page in over 6 hours
  - Page.Loads: Daily number of pages loaded
  - First.Time.Visits: Number of unique visitors who do not have a cookie identifying them as a previous customer
  - Returning.Visits: Number of unique visitors minus first time visitors 

* **Data:** daily-website-visitors.csv [link](https://github.com/hshehjue/Project_Machine_Learning/tree/main/Time_Series_Analysis/Daily_Web_Visits/data)
  - Source: [Kaggle](https://www.kaggle.com/bobnau/daily-website-visitors)
  - Cleaned Data: web_visit.csv [link](https://github.com/hshehjue/Project_Machine_Learning/tree/main/Time_Series_Analysis/Daily_Web_Visits/data)

* **Work Plan:** The variable is first included in multiple models as a unique variable to be analyzed at a univariate level. The next step is to incorporate **Page.Loads** and **Returning.Visits** variables as the independent variables to discern their influences on the dependent variable "First.Time.Visits" and build a multivariate time series forecast model. Throughout the processes, the Forecast-Horizon is set to 1 and Hold-out Sample to 300.

* **Models:**
  - **Univariate Models**
    - Seasonal Dummies and Trend Model
    - Cyclical Model
    - Cyclical Model + ARIMA(1,0,0)(1,1,0)
    - Error Model
    - ARIAMA Model (with seasonal ARIMA components if relevant)
  - **Multivariate Models**
    - Regression Model
    - Error Model using regression residuals

* **Used Variables:**
  - **Univariate Models**
    - Dependent Variable: First.Visits
  - **Multivariate Models**
    - Dependent Variable: 
      - *First.Visits*
    - Independent Variables: Page.Loads
      - *Page.Loads*
      - *Returning.Visits*
