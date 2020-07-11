The Run_Analysis.R script get the data from the link provided in the project and converts it into a separate tidy data set by following the following functions

1. Dataset extracted under the folder called UCI HAR Dataset

2. Load information about the experiment performed into R
features <- features.txt 
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
activities <- activity_labels.txt 
List of activities performed when the corresponding measurements were taken and its codes (labels)

3. Load train and test data into R
subject_test <- test/subject_test.txt 
contains test data of 9/30 volunteer test subjects being observed
x_test <- test/X_test.txt 
contains recorded features test data
y_test <- test/y_test.txt 
contains test data of activities’code labels

subject_train <- test/subject_train.txt 
contains train data of 21/30 volunteer subjects being observed
x_train <- test/X_train.txt 
contains recorded features train data
y_train <- test/y_train.txt 
contains train data of activities’code labels

4. Merges the training and the test sets to create one data set
complete_X (10299 rows, 561 columns) is created by merging x_train and x_test using rbind() function
complete_Y (10299 rows, 1 column) is created by merging y_train and y_test using rbind() function
complete_Subject (10299 rows, 1 column) is created by merging subject_train and subject_test using rbind() function
allmergeddata (10299 rows, 563 column) is created by merging complete_Subject, complete_Y and complete_X using cbind() function

5. Extracts only the measurements on the mean and standard deviation(std) for each measurement
TidyData (10299 rows, 88 columns) is created by subsetting Merged_Data, selecting only columns: subject, code and the measurements on the mean and standard deviation (std) for each measurement

6.Uses descriptive activity names to name the activities in the data set
Entire numbers in code column of the TidyData replaced with corresponding activity taken from second column of the activities variable

Appropriately labels the data set with descriptive variable names
code column in TidyData renamed into activities
All Acc in column’s name replaced by Accelerometer
All Gyro in column’s name replaced by Gyroscope
All Mag in column’s name replaced by Magnitude
All start with character f in column’s name replaced by Frequency
All start with character t in column’s name replaced by Time

From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
IndependentData (180 rows, 88 columns) is created by sumarizing TidyData taking the means of each variable for each activity and each subject, after groupped by subject and activity.
Export IndependentData into IndependentData.txt file.