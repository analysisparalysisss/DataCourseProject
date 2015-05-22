
#CodeBook purpose:
To describe the variables, the data, and any transformations or work  performed to clean up the data in the Course Project

##Project data description
###Input Data overview
The data represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

###The dataset includes the following files:


- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

###Variables description
The experiments have been carried out with a group of 30 volunteers . Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope,  3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz were captured.  
Full description of variables in the input dataset is provided in *README.txt*, *features.txt* and *features_info.txt* files which are part of the zip file.

##Data transformations
* Train and test data is read into R
* Use 'rbind' to merge the train and test data into new data frame *alldata*. Combine activity and subjects as well.
* Add the column names (variables names) from the features.txt file.
* Add subjects and activity columns and name them as "Subject" and "Activity"
* Only measurements with names containing "mean" or  "std" (not case sensitive) are selected to extract to the sample data set. Using `grep()` to check the matching.
* Activity descriptions for each numeric activity code are taken from *activity_labels.txt* file. Using `join()` function from `plyr` package to combine the Subjects and Activity columns from sample data (result of the previous step) with the activity description. Activity code is used to join the data, order of rows remains the same as in sample data frame.  
* Use cbind to create the sample with the Subject, Activity description and all the measurements of mean and std.
* Use `gsub()` to replace abbreviations with the complete descriptions for all variables:
  * *t* stands for *Time*
  * *Acc* stands for *Accelerometer*
  * *Gyro* stands for *Gyroscope*
  * *Mag* stands for *Magnitude*
  * *f* and *Freq* stand for *Frequency*
  * *BodyBody* is a duplicate of *Body* 
* Extract the averages of all measurements for each Activity and Subject (using `aggregate()` function). 
* Put columns into the right order (Subject, Activity, then all the average measurements of mean and std).
* Write data into tidy.txt file using `write.table()` with `row.names` set to FALSE. 
* *Tidy.txt* is the final output of the script. 

###Output data description
*Tidy.txt* is the final output of the script in a text format. The first row represents the decriptions of the data set (Subject, Activity description and the descriptive name of each measurement). If read into table, data set is 180 rows*88 columns table, each row represents the Subject and Activity combination and the averages for each of 86 mean and std measurements performed during experiments. 

