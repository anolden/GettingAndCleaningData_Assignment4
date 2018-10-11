# Getting And Cleaning Data
## Assignment4


### This README document is a guide for cleaning the dataset associated with the week 4 assignment. 

1. Download and unzip the data files. (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
2. Open and copy the "run_analysis.R" file into your working directory. 
3. Check that the following files are unzipped, and set this folder to your working directory.
  *activity_labels.txt
  *features.txt
  *X_train.txt
  *y_train.txt
  *subject_train.txt
  *subject_test.txt
  *X_test.txt
  *y_test.txt
4. Run the "run_analysis.R" script. 


### This script performs the following:
1. Use the read.table command to read in the data from each of the .txt files
2. Rename column names from the features.txt
3. Use cbind to horizontally (long data set) merge the train data (subject_train, X_train, y_train) and repeat for test data. 
4. Use rbind to merge test and train data. 
5. Use grepl to extract columns with mean, stdev for each measurement
6. Subset data with only measurements with mean and stdev
7. save new tidydata as a txt file 

