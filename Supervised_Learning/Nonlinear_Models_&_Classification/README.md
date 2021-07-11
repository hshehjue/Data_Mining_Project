## Description
#### This project is aimed to see which classification models demonstrate the best performance on two different datasets. The two datasets are handled by distinct sets of modeling methods and all the models are implemented with several combinations of parameters to obtain the most optimal predictions avoiding over-fit or under-fit. The performances generated from the different models for each data set are compared based on their train and test errors computed by subtracting the accuracy from 1. 

## SET 1
### Data
   * **Source** 
     - *"Auto"* from ISLR package
   * **Features**
     - *mpg (Target)* - miles per gallon
     - *cylinders* - Number of cylinders between 4 and 8
     - *displacement* - Engine displacement (cu. inches)
     - *horsepower* - Engine horsepower
     - *weight* - Vehicle weight (lbs.)
     - *acceleration* - Time to accelerate from 0 to 60 mph (sec.)
     - *year* - Model year (modulo 100)
     - *origin* - Origin of car (1. American, 2. European, 3. Japanese)


   * **Target**
     - *mpg01* - if mpg > median, 1 otherwise 0
     '''
     auto$mpg01 <- ifelse(auto$mpg > median(auto$mpg), 1,0)
     '''









