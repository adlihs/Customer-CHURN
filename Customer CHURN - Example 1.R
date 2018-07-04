#### CUSTOMER CHURN - EXAMPLE #1 ####
##SOURCE: https://mljar.com/blog/churn-prediction-auto-ml/
##TITLE: CHURN PREDICTION WITH AUTOMATIC ML
##DATA: https://github.com/WLOGSolutions/telco-customer-churn-in-r-and-h2o/tree/master/telco-customer-churn-in-r-and-h2o/data

#### Download data ####
library(RCurl)
git.file <- getURL("https://raw.githubusercontent.com/WLOGSolutions/telco-customer-churn-in-r-and-h2o/master/telco-customer-churn-in-r-and-h2o/data/edw_cdr.csv")
churn.df <- read.csv(text = git.file)



