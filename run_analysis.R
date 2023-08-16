# Getting and Cleaning Data Course Project

################################################################################

# Instructions
## One of the most exciting areas in all of data science right now is wearable computing - see for example 
## this article. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. 
## The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. 
## A full description is available at the site where the data was obtained:
      
##    http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Here are the data for the project:
      
##    https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## You should create one R script called run_analysis.R that does the following. 
##    1. Merges the training and the test sets to create one data set.
##    2. Extracts only the measurements on the mean and standard deviation for each measurement. 
##    3. Uses descriptive activity names to name the activities in the data set
##    4. Appropriately labels the data set with descriptive variable names. 
##    5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

################################################################################

# Solution
      
# Load required libraries
library(dplyr)
library(data.table)

# Step 1: Merge training and test data into a single dataset
## Define path and download the data
data_path <- getwd()
data_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(data_url, file.path(data_path, "dataFiles.zip"))
unzip(zipfile = "dataFiles.zip")

## Load activity labels and features info
activityLabels <- fread(file.path(data_path, "UCI HAR Dataset/activity_labels.txt"),
                        col.names = c("classLabels", "activityName"))
features <- fread(file.path(data_path, "UCI HAR Dataset/features.txt"),
                  col.names = c("index", "featureNames"))
featuresWanted <- grep("(mean|std)\\(\\)", features$featureNames)
measurements <- features$featureNames[featuresWanted]
measurements <- gsub('[()]', '', measurements)

## Load training datasets
train <- fread(file.path(data_path, "UCI HAR Dataset/train/X_train.txt"))[, featuresWanted, with = FALSE]
colnames(train) <- measurements
trainActivities <- fread(file.path(data_path, "UCI HAR Dataset/train/Y_train.txt"),
                         col.names = c("Activity"))
trainSubjects <- fread(file.path(data_path, "UCI HAR Dataset/train/subject_train.txt"),
                       col.names = c("SubjectNum"))
train <- cbind(trainSubjects, trainActivities, train)

## Load test datasets
test <- fread(file.path(data_path, "UCI HAR Dataset/test/X_test.txt"))[, featuresWanted, with = FALSE]
colnames(test) <- measurements
testActivities <- fread(file.path(data_path, "UCI HAR Dataset/test/Y_test.txt"),
                        col.names = c("Activity"))
testSubjects <- fread(file.path(data_path, "UCI HAR Dataset/test/subject_test.txt"),
                      col.names = c("SubjectNum"))
test <- cbind(testSubjects, testActivities, test)

## Merge training and test datasets
combined <- bind_rows(train, test)

# Step 2: Extract mean and standard deviation measurements
## Convert classLabels to descriptive activityName
combined$Activity <- factor(combined$Activity,
                            levels = activityLabels$classLabels,
                            labels = activityLabels$activityName)

# Step 3: Assign descriptive activity names
## Simplify measurement names for clarity
clean_measurements <- gsub("-", "", measurements)
clean_measurements <- tolower(clean_measurements)
colnames(combined)[3:length(measurements) + 2] <- c("subjectnum", "activity", clean_measurements)

# Step 4: Label the dataset with meaningful variable names
## Create a tidy dataset with average values
tidyData <- combined %>%
      group_by(subjectnum, activity) %>%
      summarize(across(starts_with("t"), mean))

# Save the tidy dataset to a file
write.table(tidyData, file = "tidyData.txt", row.names = FALSE)

# Author: Jesus Andres Alvarez ALvarado