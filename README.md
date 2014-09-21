Getting and Cleaning Data
=========================

This is a repository for Coursera - John Hopkins Data Scince Track - Getting and cleaning data Course Project.

### Original Data
The datasource can be obtained from the below link.
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The original data can be obtained from below link. It also describes the project for collecting the data.
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The archive has the following set of important files.

* UCI HAR Dataset/activity_labels.txt   -   Provides the names to the activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
* UCI HAR Dataset/features.txt          -   Provides the list of feature names.
* UCI HAR Dataset/features_info.txt     -   Description of how the features are created.
* UCI HAR Dataset/README.txt            -   Description of the original project.
* UCI HAR Dataset/test/subject_test.txt -   Subject value for each of the observation from the test data
* UCI HAR Dataset/test/X_test.txt       -   Test observations
* UCI HAR Dataset/test/y_test.txt       -   Test labels
* UCI HAR Dataset/train/subject_train.txt   - Subject value for each of the observation from the test data
* UCI HAR Dataset/train/X_train.txt     -   Training observations
* UCI HAR Dataset/train/y_train.txt     -   Training labels


In general X refers to observation data, y refers to the corresponding activity labels list.

### run_analysis.R
When sourced, the script performs the following set of actions.

1. Get the data.
  * Download the zip file from the datasource.
  * Unzip it to the present working directory.

2. Load the tables
  * Read the feature names and convert them to a form which can be used as R column names. The original names contain characters like () and - which are not permitted as column names.
  * Read activity labels to memory.
  * Read X,y and subject values for training and test data. X uses the feature names as column names.

3. (STEP 1) Combine tables
  * combine X, subject and y by binding against the columns. This is done separately for trainig and test data.
  * Append test data to training data and create a new union data set.

4. (STEP 2) Create a subset of the data by extracting only the columns which contain the column names ".mean." and ".std."
5. (STEP 3) Add descriptive activity labels to the data set.
  * Convert the activity numbers to factors.
  * Replace the factor levels with the activity names from activity_labels.txt
  * lower case all the activity names and replace the "_" with " ".
  * Convert the first character of every word to upper case.

6. (STEP 4) The column names are converted to a readable form by substituting as shown below. Each of the words is separated by a dot and all words are in lowecase.

  * t - time
  * f - freq
  * BodyBody - body
  * Body - body
  * Acc - accl
  * Gyro - gyro
  * Gravity - gravity
  * Mag - magnitude
  * Jerk - jerk
  * std - std
  * mean - mean

    Refer code book for column names

7. (STEP 5) - The script uses the aggregate function with FUN=mean to compute the mean of each column against each activity and subject.

8. Write the output to a file "./uci-har-tidy-data.txt" in the current working directory.

