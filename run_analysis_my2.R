#
#  run_analysis.R
#
#  This R script will subset, merge and summarize the smartphone dataset
#  for the Getting and Cleaning Data Course Project
#
#  Brad Banko, 11/23/2014
#
# Running time on my HP5800 with Quad Core processor
#  64-bit fedora 20 Linux
#
#    Intel® Core™2 Quad CPU Q9650 @ 3.00GHz × 4
#
# > source('~/Dropbox/Courses/Getting_and_Cleaning_Data/CourseProject/getting_cleaning/run_analysis_my2.R')
# [1] "Running..."
# user  system elapsed 
# 26.858   0.050  26.927 
#
###
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
##

#require(reshape2)
require(dplyr)

#
# check for existence of data, download if necessary
#
# start in the root directory:  setwd("UCI HAR Dataset/")
#

if (!file.exists("UCI HAR Dataset")) {
    if (!file.exists("Dataset.zip")) {
        print("Downloading dataset...")
        download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", 
                      method = "curl", destfile = "Dataset.zip")
    }
    print("Unzipping dataset...")
    unzip("Dataset.zip")
}

print("Running...")
startTime <- proc.time()

rootdir <- "./UCI HAR Dataset"
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

stdmeanNames <- featureNames[grep("std|mean",featureNames$featName),]

#stdmeanNames <- read.table("./mean_std_features.lst", header = F, sep=" ",
#                           stringsAsFactors=F)
#names(stdmeanNames) <- c("featId", "featName")

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

# subjectTest$set <- "test"
# subjectTrain$set <- "train"

dataTest2 <- cbind( subjectTest, activTest, dataTest)
dataTrain2 <- cbind( subjectTrain, activTrain, dataTrain)

dataTest2 <- merge(activityNames, dataTest2, by="activId")
dataTrain2 <- merge(activityNames, dataTrain2, by="activId")

#
#  merge all of the test and training data together (a full or outer join)
#


mergedData <- merge(dataTest2, dataTrain2, all=T)


# library(reshape2)
# 
# dataMelt <- melt(mergedData, id=c("subjID","actName"), 
#                  measure.vars=stdmeanNames$featName)
# 
# tidyData <- dcast(dataMelt, subjID + actName ~ stdmeanNames$featName, mean)


library(dplyr)

groupedMerged <- group_by(mergedData, subjID, actName)

tidyData <- summarise_each(groupedMerged, funs(mean))


write.csv(tidyData, file="../tidyData.csv", row.names=F)

setwd("..")

runTime <- proc.time() - startTime
runTime
print(runTime)

