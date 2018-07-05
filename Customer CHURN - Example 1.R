#### CUSTOMER CHURN - EXAMPLE #1 ####
##SOURCE: https://mljar.com/blog/churn-prediction-auto-ml/
##TITLE: CHURN PREDICTION WITH AUTOMATIC ML
##DATA: https://github.com/WLOGSolutions/telco-customer-churn-in-r-and-h2o/tree/master/telco-customer-churn-in-r-and-h2o/data
##mljar Api R: https://cran.r-project.org/web/packages/mljar/README.html

#### Libraries ####
ipak <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg)) 
    install.packages(new.pkg, dependencies = TRUE)
  sapply(pkg, require, character.only = TRUE)
}


ipak('mljar')
ipak('data.table')
ipak('RCurl')
ipak('dplyr')


### Set environment variable MLJAR_TOKEN ###
Sys.setenv(MLJAR_TOKEN="cee2c6900d64fbb53f31d8c1d0eca272830ba119")

#### Download data ####

git.file <- getURL("https://raw.githubusercontent.com/WLOGSolutions/telco-customer-churn-in-r-and-h2o/master/telco-customer-churn-in-r-and-h2o/data/edw_cdr.csv")
churn.df <- read.csv(text = git.file)



#### Read and clean the dataset  ####
#Remove month and year column
all_data <- churn.df[,1:27]

#Only complete records
all_data <- all_data[complete.cases(all_data),]

#Remove duplicates
all_data <- all_data[!duplicated(all_data),]

all_data <- all_data %>%
  mutate(churn = ifelse(churn == 1,"churn","nochurn"))

####Split the dataset into training and test set (70% - 30%)####
ds <- sort(sample(nrow(all_data),nrow(all_data) * .7))
x_tr <- all_data[ds,]
x_tr <-  x_tr %>%
  mutate(ind = "Train")


y_tr <- as.data.frame(x_tr[,27])

colnames(y_tr) <- "churn"
x_tr <- x_tr[,-27]

x_ts <- all_data[-ds,]
x_ts <- x_ts %>%
  mutate(ind = "Test")
y_ts <- as.data.frame(x_ts[,27])
colnames(y_ts) <- "churn"
x_ts <- x_ts[,-27]

#### Run models training ####
model <- mljar_fit(x_tr, y_tr, NULL, NULL, proj_title = "CHURN",
                   exp_title = "FirstChurn", dataset_title = "churn_data",
                   algorithms = c("logreg","xgb","lgb","etc","rgfc","knnc"),
                   metric = "auc")


