
#Set working directory:
setwd("~/Desktop/Data_Science/3-Getting_and_Cleaning_Data/Getting-and-Cleaning-Data-Project1")
filepath <- "~/Desktop/Data_Science/3-Getting_and_Cleaning_Data/Getting-and-Cleaning-Data-Project1/UCI HAR Dataset"

#Load packages:
library(tidyverse)


#Read in data:
#Testing data set:
test_raw <- read.table("~/Desktop/Data_Science/3-Getting_and_Cleaning_Data/Getting-and-Cleaning-Data-Project1/UCI HAR Dataset/test/X_test.txt")
#Activity labels for the test data set:
test_activity <- read.table("~/Desktop/Data_Science/3-Getting_and_Cleaning_Data/Getting-and-Cleaning-Data-Project1/UCI HAR Dataset/test/y_test.txt")
#IDs of test subjects:
test_subjects <- read.table("~/Desktop/Data_Science/3-Getting_and_Cleaning_Data/Getting-and-Cleaning-Data-Project1/UCI HAR Dataset/test/subject_test.txt")
#Training data set:
train_raw <- read.table("~/Desktop/Data_Science/3-Getting_and_Cleaning_Data/Getting-and-Cleaning-Data-Project1/UCI HAR Dataset/train/X_train.txt")
#Activity labels for train data set:
train_activity <- read.table("~/Desktop/Data_Science/3-Getting_and_Cleaning_Data/Getting-and-Cleaning-Data-Project1/UCI HAR Dataset/train/y_train.txt")
#IDs of train subjects:
train_subjects <- read.table("~/Desktop/Data_Science/3-Getting_and_Cleaning_Data/Getting-and-Cleaning-Data-Project1/UCI HAR Dataset/train/subject_train.txt")
#All features (column names for test/train data sets):
features <- read.table("~/Desktop/Data_Science/3-Getting_and_Cleaning_Data/Getting-and-Cleaning-Data-Project1/UCI HAR Dataset/features.txt")
#Activity labels:
activity_labels <- read.table("~/Desktop/Data_Science/3-Getting_and_Cleaning_Data/Getting-and-Cleaning-Data-Project1/UCI HAR Dataset/activity_labels.txt")

#Add column names to test_raw using features dataframe:
features <- features[,2, drop=F] #drop first column
features <- as.vector(features$V2) #convert to vector
colnames(test_raw) <- features

#Append test_labels to test_raw as new column: 
test_raw <- cbind(test_raw, test_activity) 
names(test_raw)[names(test_raw) == 'V1'] <- 'activity'

#Append test_subject to test_raw as new column:
test_raw <- cbind




#Merge y_test with y_train:
y <- rbind(y_test, y_train)


#Merge test and train datasets:


#Subset only the columns with "mean" or "std":
df[ , grepl("mean" | "std", names(df))]

#Convert activity_labels into a factor:

#Replace numbers in subject_test and subject train with above factor levels:




