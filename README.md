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

##Preparation:Read project data files into R
```{r}
X_train=read.table("train/X_train.txt")
subject_train=read.table("train/subject_train.txt")
y_train=read.table("train/y_train.txt")
X_test=read.table("test/X_test.txt")
subject_test=read.table("test/subject_test.txt")
y_test=read.table("test/y_test.txt")
```
##1.Merge the training and the test sets to create one data set.
Use 'rbind' to merge the train and test data into new data frame *alldata*. 
```{r}
alldata=rbind(X_train,X_test)
activity=rbind(y_train,y_test)
subjects=rbind(subject_train,subject_test)
```
Add the column names from the features.txt file
```{r}
features=read.table("features.txt")
colnames(alldata)=features[,2]
```
Add subjects and activity columns and name them as "Subjects" and "Activity"
```{r}
named_data<-cbind(subjects,activity,alldata)
colnames(named_data)[1:2]<-c("Subjects","Activity")
```
##2.Extract only the measurements on the mean and standard deviation for each measurement.
Measurements to be selected are defined as measurements names containing "mean" or  "std" (not case sensitive).
```{r}
sample<-named_data[,c(1,2,grep("mean|std",colnames(named_data),ignore.case=TRUE))]
```
##3.Uses descriptive activity names to name the activities in the data set.
Activity descriptions for each numeric activity code are taken from *activity_labels.txt* file. Using `join()` function from `plyr` package to combine the Subjects and Activity columns from sample data (result of the previous step) with the activity description. Activity code is used to join the data, order of rows remains the same as in sample data frame (so that we can add the remaining columns on the next step).  
```{r}
labels=read.table("activity_labels.txt",col.names=c("Activity","Activity_description"))
library(plyr)
activity_description<-join(sample[,1:2],labels,by="Activity")
```
Use cbind to create the sample with the Subject, Activity description and all the measurements of mean and std.
```{r}
sample_with_labels<-cbind(Subject=activity_description[,1],Activity=activity_description[,3],sample[,-(1:2)])
```
##4.Appropriately labels the data set with descriptive variable names
Use `gsub()` to replace abbreviations with the complete descriptions for all variables:
* *t* stands for *Time*
* *Acc* stands for *Accelerometer*
* *Gyro* stands for *Gyroscope*
* *Mag* stands for *Magnitude*
* *f* and *Freq* stand for *Frequency*
* *BodyBody* is a duplicate of *Body* 
```{r}
colnames(sample_with_labels)<-gsub("tBody","TimeBody",colnames(sample_with_labels))
colnames(sample_with_labels)<-gsub("Acc","Accelerometer",colnames(sample_with_labels))
colnames(sample_with_labels)<-gsub("tGravity","TimeGravity",colnames(sample_with_labels))
colnames(sample_with_labels)<-gsub("Gyro","Gyroscope",colnames(sample_with_labels))
colnames(sample_with_labels)<-gsub("Mag","Magnitude",colnames(sample_with_labels))
colnames(sample_with_labels)<-gsub("fBody","FrequencyBody",colnames(sample_with_labels))
colnames(sample_with_labels)<-gsub("Freq()","Frequency()",colnames(sample_with_labels),fixed=TRUE)
colnames(sample_with_labels)<-gsub("BodyBody","Body",colnames(sample_with_labels))
```
##5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Use `aggregate()` to extract averages of all measurements (given in all columns except column 1 and column 2 of sample_with_labels data frame). Group by Activity and Subject (criterias should be given as a list, making sure to specify columns names as otherwise `aggregate()` function would replace the column names in the data frame). Put columns into the right order (Subject, Activity, then all the average measurements of mean and std) and write data into tidy.txt file using `write.table()` with row.names set to FALSE. Tidy.txt is the final output of the script. 
```{r}
data<-aggregate(sample_with_labels[,-(1:2)],by=list(Activity=sample_with_labels$Activity,Subject=sample_with_labels$Subject),mean)
tidy<-data[,c(2,1,3:88)]
write.table(tidy,"tidy.txt",row.names=FALSE)
```

