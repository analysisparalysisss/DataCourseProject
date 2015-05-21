##The zip file "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
##is loaded and unziped to the working directory

##Read files into R
X_train=read.table("train/X_train.txt")
subject_train=read.table("train/subject_train.txt")
y_train=read.table("train/y_train.txt")
X_test=read.table("test/X_test.txt")
subject_test=read.table("test/subject_test.txt")
y_test=read.table("test/y_test.txt")
##1.Merge the training and the test sets to create one data set
alldata=rbind(X_train,X_test)
activity=rbind(y_train,y_test)
subjects=rbind(subject_train,subject_test)
features=read.table("features.txt")
colnames(alldata)=features[,2]
##add subjects and activity columns and name them
named_data<-cbind(subjects,activity,alldata)
colnames(named_data)[1:2]<-c("Subjects","Activity")

##2.Extract only the measurements on the mean and standard deviation for each measurement
##defined as measurements names containing "mean" or  "std" irrespective of case.
sample<-named_data[,c(1,2,grep("mean|std",colnames(named_data),ignore.case=TRUE))]

##3.Uses descriptive activity names to name the activities in the data set
labels=read.table("activity_labels.txt",col.names=c("Activity","Activity_description"))
library(plyr)
activity_description<-join(sample[,1:2],labels,by="Activity")
sample_with_labels<-cbind(Subject=activity_description[,1],Activity=activity_description[,3],sample[,-(1:2)])

##4.Appropriately labels the data set with descriptive variable names
colnames(sample_with_labels)<-gsub("tBody","TimeBody",colnames(sample_with_labels))
colnames(sample_with_labels)<-gsub("Acc","Accelerometer",colnames(sample_with_labels))
colnames(sample_with_labels)<-gsub("tGravity","TimeGravity",colnames(sample_with_labels))
colnames(sample_with_labels)<-gsub("Gyro","Gyroscope",colnames(sample_with_labels))
colnames(sample_with_labels)<-gsub("Mag","Magnitude",colnames(sample_with_labels))
colnames(sample_with_labels)<-gsub("fBody","FrequencyBody",colnames(sample_with_labels))
colnames(sample_with_labels)<-gsub("Freq()","Frequency()",colnames(sample_with_labels),fixed=TRUE)
colnames(sample_with_labels)<-gsub("BodyBody","Body",colnames(sample_with_labels))

##5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
data<-aggregate(sample_with_labels[,-(1:2)],by=list(Activity=sample_with_labels$Activity,Subject=sample_with_labels$Subject),mean)
tidy<-data[,c(2,1,3:88)]
write.table(tidy,"tidy.txt",row.names=FALSE)