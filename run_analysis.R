#Assignment

#Load required packages
library(plyr)
library(dplyr)
library(data.table)

#download and unzip data files (first set your working directory to where you want to look for or create the folder containing the zipped data)

if(!file.exists("./assignment 4")){dir.create("./assignment 4")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./assignment 4/Dataset.zip")

# Unzip dataSet to /data directory
unzip(zipfile="./assignment 4/Dataset.zip",exdir="./assignment 4/data")


#read in txt files
# assign train.txt to _train 
x_train<-read.table("./assignment 4/data/UCI HAR Dataset/train/X_train.txt")
y_train<-read.table("./assignment 4/data/UCI HAR Dataset/train/y_train.txt")
subject_train<-read.table("./assignment 4/data/UCI HAR Dataset/train/subject_train.txt")

# read and assign test.txt to _test
x_test<-read.table("./assignment 4/data/UCI HAR Dataset/test/X_test.txt")
y_test<-read.table("./assignment 4/data/UCI HAR Dataset/test/y_test.txt")
subject_test<-read.table("./assignment 4/data/UCI HAR Dataset/test/subject_test.txt")

# read and assign features
features<-read.table("./assignment 4/data/UCI HAR Dataset/features.txt")

#read and assign activity levels
activity_labels<-read.table("./assignment 4/data/UCI HAR Dataset/activity_labels.txt")


#Use features to assign column names to the x_train and x_test data. 
colnames(x_train)<-features[,2]
colnames(x_test)<-features[,2]

#Rename columnames in y_train, y_test, and activity_labels
colnames(y_train)<-"activityName"
colnames(y_test)<- "activityName"

#Rename columname in subject_train and subject_test 
colnames(subject_train)<-"subjectID"
colnames(subject_test)<- "subjectID"

#Rename columnnames in activity_lables to match new column names
colnames(activity_labels)<-c("activityName", "Activity")

#merge into one dataset
traindata<-cbind(y_train, subject_train, x_train) #first combine all train data
testdata<-cbind(y_test, subject_test, x_test) # second combine all test data
alldata<-rbind(traindata, testdata) #last combine the two together

#Extract measurements (mean and stdev) for each 

#Store columnames in colNames
colNames<- colnames(alldata)

#create vector containing ID, mean, and stdev
mean_stdev<- (grepl("activityName", colNames) |
                grepl("subjectID", colNames) |
                grepl("mean..", colNames) |
                grepl("std..", colNames))

selectdata<-grep("mean\\(\\)|std\\(\\)", colNames, value=TRUE)

#subset based on mean_stdev
selectdata<-union(c("subjectID", "activityName"), selectdata)
sub_mean_stdev<-subset(alldata, select = selectdata)

#Use acitivityNames to name the activities in the dataset
AddActivityNames<-merge(sub_mean_stdev, activity_labels, by="activityName", all.x=TRUE)

#Create a tidy dataset
#average of each variable for each activity and each subject. 

TidyData<-aggregate(.~subjectID + Activity, AddActivityNames, mean)
TidyData<-TidyData[order(TidyData$subjectID, TidyData$Activity),]
TidyData<-TidyData[,-3]#remove ActicityName (numbered activity column)


#Save TidyData to .txt file
write.table(TidyData, 'TidyData.txt', row.name=FALSE)
