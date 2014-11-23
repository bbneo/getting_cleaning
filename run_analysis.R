#
#  This will be my R script to analyze and merge the smartphone data
#  to analyze and merge the smartphone dataset for the Course Project
#
#  Brad Banko, 11/17/2014
#
# 
# The purpose of this project is to demonstrate your ability to collect, work
# with, and clean a data set. The goal is to prepare tidy data that can be used
# for later analysis. You will be graded by your peers on a series of yes/no
# questions related to the project. You will be required to submit: 1) a tidy
# data set as described below, 2) a link to a Github repository with your script
# for performing the analysis, and 3) a code book that describes the variables,
# the data, and any transformations or work that you performed to clean up the
# data called CodeBook.md. You should also include a README.md in the repo with
# your scripts. This repo explains how all of the scripts work and how they are
# connected.
# 
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
# 
# Here are the data for the project:
# 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# 
# You should create one R script called run_analysis.R that does the following.
# 
#     Merges the training and the test sets to create one data set.
#     Extracts only the measurements on the mean and standard deviation for each
#     measurement.
#     Uses descriptive activity names to name the activities in the data set
#     Appropriately labels the data set with descriptive variable names. 
# 
#     From the data set in step 4, creates a second, independent tidy data set
#     with the average of each variable for each activity and each subject.
#     
# Good luck!
# 


#
# start in the root directory:  setwd("UCI HAR Dataset/")
#

rootdir <- "~/Dropbox/Courses/Getting_and_Cleaning_Data//CourseProject//getting_cleaning//UCI HAR Dataset"

setwd(rootdir)

# 
#  read in the list of:
# 
# feature names (and ids) of interest
# activity labels (and ids)
# 
# the "id" is the row or "element" number that the feature appears at in a
# stream of data, or that labels an activity type
#  
# "./mean_std_features.lst" is a file listing all features with "mean" or "std"
# in the name.  
#  this was created from "features.txt" by a "grep" pattern match 
#  on a Linux system:
#
# grep -i 'mean\|std' features.txt > mean_std_features.lst
#
featureNames <- read.table("./features.txt", header = F, sep=" ",
                           stringsAsFactors=F)
names(featureNames) <- c("featId", "featName")

stdmeanNames <- read.table("./mean_std_features.lst", header = F, sep=" ",
                           stringsAsFactors=F,skip=5)
names(stdmeanNames) <- c("featId", "featName")

# fid                 fname
# 1    1     tBodyAcc-mean()-X
# 2    2     tBodyAcc-mean()-Y
# 3    3     tBodyAcc-mean()-Z
# 4    4      tBodyAcc-std()-X
# 5    5      tBodyAcc-std()-Y
# 6    6      tBodyAcc-std()-Z
# 7   41  tGravityAcc-mean()-X
# 8   42  tGravityAcc-mean()-Y
# 9   43  tGravityAcc-mean()-Z
# ...


activityNames <- read.table("./activity_labels.txt", header = F, sep=" ",
                           stringsAsFactors=F)
names(activityNames) <- c("activId", "actName")

#
#  read raw test data
#

subjectTest <- read.table("./test//subject_test.txt", header=F)
dataTest <- read.table("./test//X_test.txt", header=F)
activTest <- read.table("./test//y_test.txt", header=F)

#
#  read raw train data
#

subjectTrain <- read.table("./train//subject_train.txt", header=F)
dataTrain <- read.table("./train//X_train.txt", header=F)
activTrain <- read.table("./train//y_train.txt", header=F)

#
# select only the mean and std columns and apply the labels to the columns
#  

dataTest <- dataTest[,stdmeanNames$featId]
names(dataTest) <- stdmeanNames$featName

dataTrain <- dataTrain[,stdmeanNames$featId]
names(dataTrain) <- stdmeanNames$featName

#
#  Assign names to the subject and activity data
#

names(subjectTest) <- "subjID"
names(subjectTrain) <- "subjID"

names(activTest) <- "activId"
names(activTrain) <- "activId"

subjectTest$set <- "test"
subjectTrain$set <- "train"

dataTest2 <- cbind( subjectTest, activTest, dataTest)
dataTrain2 <- cbind( subjectTrain, activTrain, dataTrain)

dataTest2 <- merge(activityNames, dataTest2, by="activId")
dataTrain2 <- merge(activityNames, dataTrain2, by="activId")

#
#  merge all of the test and training data together (a full or outer join)
#


mergedData <- merge(dataTest2, dataTrain2, all=T)

library(data.table)


