#****************************************************************************************
#
# This R script, run_analysis.R will result in the following actions:
# 1). Merge the training and test sets to create one data set
# 2). Extract only the measurements on the mean and standard deviation for each
#     measurement
# 3). Use descriptive activity names to name the activities in the data set
# 4). Appropriately label the data set with descriptive variable names
# 5). Create a second, independent, tidy data set with the average of each variable
#     of each variable for each activity and each subject
#
# See CodeBook.md for a description of the data sets 
#
# Author: Tony
# Rev   : 1.0
# Date  : 25 Sep 2015
#
# ***************************************************************************************
#
# load the dplyr library
#
library(dplyr)
#
# Read in the data sets associated with the train data (see XXXX for a description
# of the data sets)
#
trainData <- read.csv("./UCI HAR Dataset/train/X_train.txt",sep="",header=FALSE)
trainLabels <- read.csv("./UCI HAR Dataset/train/y_train.txt",sep="",header=FALSE)
trainSubjects <- read.csv("./UCI HAR Dataset/train/subject_train.txt",sep="",header=FALSE)
#
# Read in the data sets associated with the test data (see XXXX for a description
# of the data sets)
#
testData <- read.csv("./UCI HAR Dataset/test/X_test.txt",sep="",header=FALSE)
testLabels <- read.csv("./UCI HAR Dataset/test/y_test.txt",sep="",header=FALSE)
testSubjects <- read.csv("./UCI HAR Dataset/test/subject_test.txt",sep="",header=FALSE)
#
# Read in the data sets associated with common information (see XXXX for a description
# of the data sets)
#
activityLabels <- read.csv("./UCI HAR Dataset/activity_labels.txt",sep="",header=FALSE)
features <- read.csv("./UCI HAR Dataset/features.txt",sep="",header=FALSE)
#
# combine the subjects, training data and labels in one data frame
#
combinedTrainData <- cbind(trainSubjects,trainData,trainLabels)
#
# combine the subjects, test data and labels in one data frame
#
combinedTestData <- cbind(testSubjects,testData,testLabels)
#
# label the columns of both combined data frames as appropriate (using the header
# names from the features data set)
#
colnames(combinedTrainData) <- c("subject",as.vector(features[,2]),"Activity")
colnames(combinedTestData) <- c("subject",as.vector(features[,2]),"Activity")
#
# now combine the two data frames (training and test) into one by appending the
# test data frame to the training data frame
#
trainTestData <- rbind(combinedTrainData,combinedTestData)
#
# Are really just interested in the columns that have "mean" OR "std" in them; so, find
# the names of those columns
#
colsOfInterestNames <- grep("mean\\(\\)|std\\(\\)",names(trainTestData))
#
# Extract only those columns from the combined training and test data set which are of
# interest along with the subject and activity numbers
#
combinedOfInterest <- trainTestData[c(1,colsOfInterestNames,563)]
#
# For simplicity, change the column names to be just Mean or Std, as appropriate, which
# will require the removal of any () or - and simplification of names
#
names(combinedOfInterest) <- gsub('\\(\\)','',names(combinedOfInterest))
names(combinedOfInterest) <- gsub('-mean','Mean',names(combinedOfInterest))
names(combinedOfInterest) <- gsub('-std','Std',names(combinedOfInterest))
names(combinedOfInterest) <- gsub('-','',names(combinedOfInterest))
#
# Arrange the data set ordered by subject number then activity number within the subject
#
orderedCombined <-arrange(combinedOfInterest,subject,Activity)
#
# create a new data frame to hold the results of the means and standard deviations as
# required
#
result <- NULL
result <- data.frame(result)
#
# record constants (this is for this particular case, should generalize should we want
# to handle other size data sets)
#
numSubjects   <- 30
numActivities <- 6
colStart      <- 2
colEnd        <- 67
#
# x will be a temporary vector
#
x <- NULL
for (i in 1:numSubjects) {
   x[1] <- i
   for (j in 1:numActivities) {
      x[2] <- j
      # get by subject and activity within subject
      f <-filter(orderedCombined,subject==i,Activity==j)
      for (k in colStart:colEnd) {
         # compute the mean
         x[k+1] <- mean(f[,k])
      }
      # take the transpose so as to add to data frame
      xT <- x
      # add to data frame
      result <- rbind(result,xT)
   }
}
#
# add the column names 
colnames(result) <- c("subject","Activity",as.vector(names(f[2:67])))
#
# now need to rename activity with the real names, using temporary sets
# to accomplish this (named A* for Activity and number)
#
A1 <- filter(result,Activity==1)
A1$Activity <- activityLabels[1,2]
A2 <- filter(result,Activity==2)
A2$Activity <- activityLabels[2,2]
A3 <- filter(result,Activity==3)
A3$Activity <- activityLabels[3,2]
A4 <- filter(result,Activity==4)
A4$Activity <- activityLabels[4,2]
A5 <- filter(result,Activity==5)
A5$Activity <- activityLabels[5,2]
A6 <- filter(result,Activity==6)
A6$Activity <- activityLabels[6,2]
#
# and now, finally create the resulting, final, data set
#
finalResult <- rbind(A1,A2,A3,A4,A5,A6)
#
# add the appropriate column names
#
colnames(finalResult) <- c("subject","Activity",as.vector(names(f[2:67])))
#
# Ensure the order of the resulting data set is by subject only
#
finalResult <-arrange(finalResult,subject)
#
# and, finally, write out the independent tidy data set
#
write.table(finalResult,"./tidyDataSet.txt",row.name=FALSE)
#