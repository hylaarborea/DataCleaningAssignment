# Peer-graded Assignment: Getting and Cleaning Data Course Project
# Origin data:
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

#set some variables
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
filename<-"DataSet.zip"

#download file, unzip and set folder
download.file(url,filename)
unzip(filename)
file.remove(filename)
folder<-"UCI HAR Dataset"
setwd(folder)

#read activity labels (I will use it later)
activityLabel <- read.table("activity_labels.txt", col.names = c("level", "label"))

#read features and make proper names (these will be the name of the columns)
features <- read.table("features.txt")
features <- features[[2]]
features<-make.names(features)

################################################################################
# Tidy before test set
################################################################################

#read data
dataTest <- read.table("test/X_test.txt")

#read activity and transform in factor
activityTest <- read.table("test/y_test.txt")
activityTest <- factor(activityTest[[1]], levels = activityLabel$level, labels = activityLabel$label)

#read subjects and transform in factor
subjectTest <- read.table("test/subject_test.txt")
subjectTest  <- as.factor(subjectTest[[1]])

#set colname for dataTest
colnames(dataTest) <- features

#add to dataTest a new column with subject
dataTest$subject <- subjectTest

#add to dataTest a new column with activity
dataTest$activity <- activityTest





################################################################################
# Tidy now training set
################################################################################

#read data
dataTrain <- read.table("train/X_train.txt")

#read activity and transform in factor
activityTrain <- read.table("train/y_train.txt")
activityTrain <- factor(activityTrain[[1]], levels = activityLabel$level, labels = activityLabel$label)

#read subjects and transform in factor
subjectTrain <- read.table("train/subject_train.txt")
subjectTrain  <- as.factor(subjectTrain[[1]])

#set colname for dataTrain
colnames(dataTrain) <- features

#add to dataTrain a new column with subject
dataTrain$subject <- subjectTrain

#add to dataTrain a new column with activity
dataTrain$activity <- activityTrain



#now merge the training and the test sets to create one data set
dataTotal <- rbind(dataTest, dataTrain)

#Extracts only the measurements on the mean and 
#standard deviation for each measurement. 
namesMean <- grep("\\.mean\\.",names(dataTotal), value = T)
namesStd <- grep("\\.std\\.",names(dataTotal), value = T)
dataSub <- dataTotal[,c(namesMean,namesStd, "subject", "activity")]

#load library
library(dplyr)

#group data
dataGrouped <- group_by(dataSub, activity, subject)

#new dataset with average of each variable for each activity and each subject
dataSummary <- summarise_all(dataGrouped, funs(mean))
# dim(dataSummary) => 180  68

#save table
setwd("../")
write.table(dataSummary, file = "table.txt" , row.name=FALSE)
