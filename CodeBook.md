---
title: "CodeBook - Data & Clean"
author: "Tony Smaldone"
date: "Friday, September 25, 2015"
output: html_document
---

## CodeBook.md

### Introduction

This project will acquire, work with and clean (or `tidy`) a data set to be used
for future analysis. The `raw` data used in this project comes from a Human
Activity Recognition (HAR) database from UCI which contains data from 30 subjects
performing daily activities while carrying a Samsung Galaxy S II smartphone 
equipped with embedded inertial sensors.

Details on the UCI HAR database can be found at 
[UCI HAR](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) 

The actual UCI HAR dataset can be gotten from 
[UCI HAR Dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

### UCI HAR Dataset Overview

The experiments were conducted on a group of 30 subjects (age group of 19-48 years).
They performed six activities and the various mechanics of their movements were
recorded via the above mentioned smartphone. The six activities were:

1. Walking
2. Walking Upstairs
3. Walking Downstairs
4. Sitting
5. Standing
6. Laying

The data collected was divided into two datasets, `train` and `test`. The
`training` dataset could be used to train a model (as discussed in the
Practical Machine Learning course) and the `test` dataset could be used to
evaluate the model developed using the training dataset. The two datasets are
roughly 70% (train) and 30% (test) of the total data collected.

### UCI HAR Dataset Files

The dataset (referred to above) will unzip into the following relevant files:

* `./train/X_train.txt`: the training data (exclusive of column headers)
* `./train/y_train.txt`: The *activity* labels for the training data; the labels 
are numeric with each value corresponding to the activity type as detailed
above
* `./train/subject_train.txt`: Provides a corresondance between subject number
(1-30) and the train data
* `./test/X_test.txt`: the test data (exclusive of column headers)
* `./test/y_test.txt`: The *activity* labels for the test data; the labels 
are numeric with each value corresponding to the activity type as detailed
above
* `./test/subject_test.txt`: Provides a corresondance between subject number
(1-30) and the test data
* `/activity_labels.txt`: Provides the mapping between the numeric number and
activity type as discussed above
* `/features.txt`: provides the description of each column in the training and
test data sets (i.e., the data in `/train/X_train.txt` or `./train/X_test.txt`

### UCI HAR Dataset Manipulation

The train data set contains 7352 observations (corresponding to each of the 
thirty subjects for each of the six activities over the duration of the 
experiment) and 561 columns (corresponding to the measurements taken for each
observation). The test data set 2947 observations and (obviously) 561 columns,
with meaning per the train data set.

Not all of these measurements are of interest for the purpose herein. Only those
columns that represent a `mean` or a `std` (standard deviation) are of 
interest. Of the 561 columns, there will only be 66 of interest. **Note: The 
actual meaning of each of the measurements is beyond the scope of this 
code book. To get further information on the meaning of the various measurements
see the above referenced document. Of note here is that this work is only
concerned with those columns that contain mean of std.**

The objective herein, is to first create on dataset containing 

* Both the training and test datasets
* Filter the data to only have columns with a mean or std in their
title
* Replace the title with something more meaningful
* Add subject number to identify the subject to whom a given row (observation)
pertains
* Add the activity type to each observation.

It is from this dataset that the means of each measurement type will be computed.
Then will create a *tidy* dataset that contains 180 *observations* and 68 columns.
Each observation will identify the subject number, the type of activity performed
and the mean values of each measurement type (66). This tidy dataset could be
then used for subsequent analysis wherein the researcher will have a user
friendly dataset to read into `R` and then perform any given analysis.


### run_analysis.R

To perform the actual transformations listed above, the `R` script
`run_analysis.R` was created. The script will:

* Read in the data sets listed above from the UCI HAR database
* Merge the training and test data sets
* Add subject and activity numbers to the merged dataset
* Extract only those columns containing `mean` or `std`
* Rename those columns to a more user friendly, readable name 
* Compute the mean for each measurement (column) for each activity type
for each subject
* Replace the activity number with the English equivalent
* Create the `tidy` dataset as described above

See `README.md` for a further description, including how to run the
script and `run_analysis.R` which is commented to provide details on the
specific means by with the above transformations were accomplished.



