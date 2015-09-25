---
title: "README - Data & Clean"
author: "Tony Smaldone"
date: "Friday, September 25, 2015"
output: html_document
---

### README.md

The contents within this repo are:

* README.md: This file
* CodeBook.md: Describes the variables, data and any transformation(s) or method(s) used to clean the data
* run_analysis.R: An `R` script which implements the transformation(s) or method(s) used to clean the data as described in `CodeBook.md`

### run_analysis.R Execution

The process for running the `run_analysis.R` script is as follows:

* Change working directory to an existing directory or create a new working 
directory and change the working directory to it
* Download the UCI HAR Dataset [Data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
* Unzip the data into the subdirectory `UCI HAR Dataset`
* Invoke `R` (or `RStudio`)
* Run the script: `source ./run_analysis.R`
* A text file, `tidyDataSet.txt` will be created in the current working 
directory which contains the tidied data and the means for each relevant variable as detailed
in `CodeBook.md`

### run_analysis.R Desciption

The `run_analysis.R` script performs the following tasks on the dataset and variables as
documented in `CodeBook.md`:

1. Merge the training and test sets to create one data set
2. Extract only the measurements on the mean and standard deviation for each measurement
3. Use descriptive activity names to name the activities in the data set
4. Appropriately label the data set with descriptive variable names
5. Create a second, independent, tidy data set with the average of each variable 
of each variable for each activity and each subject


