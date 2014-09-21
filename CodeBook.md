#Code Book
##Original input data
The training and test data used comes from the following text files of the Human Activity Recognition database:

###Features' names and activity labels

* features.txt - List with the features' names
* activity_labeles.txt - List that links the class labels with their activity name

###Training observations

* subject_train.txt - Subjects who performed the activity for each window sample
* X_training.txt - Training data with the features' observations
* y_training.txt - Training class labels

###Testing observations

* subject_test.txt - Subjects who performed the activity for each window sample
* X_test.txt - Test data with the features' observations
* y_test.txt - Test class labels


## Output Data
After runing the run_analysis.R on output with following varible names and formats is obtained.

The data and the experiment details can be obtained from 
[link 1] http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
Refer to the README and features_info.txt files for details of how the data was collected.

###Variables

The variables extracted from this database was the subject who performed the activity, the activity label, and those with the mean or the standard deviation estimated from the accelerometer and gyroscope 3-axial raw signals:

* subject - The subjects who performed the activity for each window sample (coded from 1  to 30)
* activity - The activity label ("Walking", "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying" )
* All other variables refer to the mean of the column name taken per subject per activity and has the following format
    * all variable names consists of one or more lower case words (except the axes which is maintained in upper case X,Y or X) each separated by a dot.
    * X, Y or Z - refers to the axis against whose values, the feature was computed.
    * accl - Accelerometer reading
    * gyro - gyroscope reading
    * body - body motion component. This can be for both acceleration signal or gyroscope signal.
    * gravity - gravity motion component. This is limited to the accelerometer.
    * time - refers to to the fact that it is the time domain reading.
    * freq - refers to to the fact that it is the frequency domain reading.
    * jerk - linear acceleration incase of accelerotmeter and angular velocity in case of gyroscope.
    * mean - mean for the sliding window of samples.
    * std - standard deviation for the sliding window of samples.
    * magnitude - Magnitude of the three-dimensional signals were calculated using the Euclidean norm.
    
