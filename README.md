# Getting and Cleaning Data Course Project
## Project Overview

This project is part of the Coursera Data Science Track course **Getting & Cleaning Data**. The goal of this project is to demonstrate the ability to collect, work with, and clean a data set from the Human Activity Recognition Using Smartphones dataset.

The project focuses on creating an R script called 'run_analysis.R' that performs the following tasks:

1. Merges the training and test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive variable names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Solution Steps
### Step 1: Merge Training and Test Data
* Downloads the dataset and extracts it.
* Loads activity labels and features information.
* Extracts mean and standard deviation measurements from the features.
* Loads training and test datasets.
* Merges training and test datasets into a single dataset.
### Step 2: Extract Mean and Standard Deviation Measurements
* Converts activity labels to descriptive activity names.
### Step 3: Assign Descriptive Activity Names
* Simplifies measurement names for better clarity.
* Labels the dataset columns with meaningful variable names.
### Step 4: Create Tidy Dataset
* Creates a tidy dataset with the average values of each variable for each subject and activity pair.
* Saves the tidy dataset to a file called 'tidyData.txt'.

## Author
Jesus Andres Alvarez Alvarado.
