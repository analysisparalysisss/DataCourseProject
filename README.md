# Getting and Cleaning Data Course Project
--------------------------------------------
##DataCourseProject repo description and contents

The goal of the course project is to prepare tidy data that can be used for later analysis.
DataCourseProject repo contains the following files:
- **Run_analysis.R** is R script for performing the analysis (see details in the next section)
- **Code book** describes the variables, the data, and the transformations or work performed to clean up the data called CodeBook.md. 
- **README.md** explains how all of the scripts work and how they are connected.   
- **Tidy.txt** - a tidy data set which is the result output of the script.

##Course Project Description

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

 The goal is to create one R script called run_analysis.R that does the following: 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names. 
4. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##R version and packages used
* R version 3.1.3 (2015-03-09)
* Using `plyr` package

##Basic assumptions
Script assumes that the zip file http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip is loaded and unziped to the working directory

##Read project data files into R
```{r}
X_train=read.table("train/X_train.txt")
subject_train=read.table("train/subject_train.txt")
y_train=read.table("train/y_train.txt")
X_test=read.table("test/X_test.txt")
subject_test=read.table("test/subject_test.txt")
y_test=read.table("test/y_test.txt")
```



