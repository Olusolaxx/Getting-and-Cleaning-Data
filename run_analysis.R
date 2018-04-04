#' ----
#' title: run_analysis.R
#' description: Getting and Cleaning Data Course Project
#' author: samanthactoet@gmail.com
#' ---


library(tidyverse)
setwd("~/Desktop/Data_Science/3-Getting_and_Cleaning_Data")


####Download and Unzip####

zip_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zip_file <- "UCI HAR Dataset.zip"

# Download the zip file:
if (!file.exists(zip_file)) {
    download.file(zip_url, zip_file, mode = "wb")
}

# Unzip:
data_path <- "UCI HAR Dataset"
if (!file.exists(data_path)) {
    unzip(zip_file)
}

####Load####

# Testing data:
test_raw <- read.table("~/Desktop/Data_Science/3-Getting_and_Cleaning_Data/UCI HAR Dataset/test/X_test.txt")
test_activity <- read.table("~/Desktop/Data_Science/3-Getting_and_Cleaning_Data/UCI HAR Dataset/test/y_test.txt")
test_subjects <- read.table("~/Desktop/Data_Science/3-Getting_and_Cleaning_Data/UCI HAR Dataset/test/subject_test.txt")

# Training data:
train_raw <- read.table("~/Desktop/Data_Science/3-Getting_and_Cleaning_Data/UCI HAR Dataset/train/X_train.txt")
train_activity <- read.table("~/Desktop/Data_Science/3-Getting_and_Cleaning_Data/UCI HAR Dataset/train/y_train.txt")
train_subjects <- read.table("~/Desktop/Data_Science/3-Getting_and_Cleaning_Data/UCI HAR Dataset/train/subject_train.txt")

# Features and activity labels:
features <- read.table("~/Desktop/Data_Science/3-Getting_and_Cleaning_Data/UCI HAR Dataset/features.txt")
activity_labels <- read.table("~/Desktop/Data_Science/3-Getting_and_Cleaning_Data/UCI HAR Dataset/activity_labels.txt")


####Tidy####

# Add column names to test_raw using features dataframe:
features <- features[,2, drop=F] #drop first column
features <- as.vector(features$V2) #convert to vector
colnames(test_raw) <- features

# Append test_activity to test_raw as new column: 
test_raw <- cbind(test_raw, test_activity) 
names(test_raw)[names(test_raw) == 'V1'] <- "activity"

# Append test_subject to test_raw as new column:
test_raw <- cbind(test_raw, test_subjects)
names(test_raw)[names(test_raw) == "V1"] <- "subject"

# Add column names to train_raw using features dataframe:
colnames(train_raw) <- features

# Append train_activity to train_raw as new column:
train_raw <- cbind(train_raw, train_activity) 
names(train_raw)[names(train_raw) == "V1"] <- "activity"

# Append train_subject to train_raw as new column:
train_raw <- cbind(train_raw, train_subjects)
names(train_raw)[names(train_raw) == "V1"] <- "subject"

# Merge raw test and train datasets:
total <- rbind(test_raw, train_raw)

# Remove duplicated column names:
total_dup <- total[ , !duplicated(colnames(total))]

# Subset only the columns with "mean", "std", "activity" and "subject":
subsetted <- select(total_dup, activity, subject, matches("(mean|std)"))

# Replace activity number with corresponding activity values:
decode <- activity_labels$V2
names(decode) <- 1:6
subsetted$activity <- decode[subsetted$activity]

# Gather into long form:
long <- gather(subsetted, "measurement", "value", -subject, -activity)

#Create second dataset with the average of each variable for each activity 
#and each subject:
tidy <- group_by(long, activity, subject, measurement) %>% 
    summarise(mean = mean(value)) 

# Save:
write.table(tidy, "tidy.txt", row.names = FALSE, quote = FALSE) 


#Visualize (for fun):
ggplot(tidy, aes(activity, mean)) +
    geom_point() +
    facet_wrap(~measurement)














