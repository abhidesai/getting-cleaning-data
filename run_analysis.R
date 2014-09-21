fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipfile <- "./accelerometers_galaxy_s2.zip"

featuresFile <- "./UCI HAR Dataset/features.txt"
labelNameFile <- "./UCI HAR Dataset/activity_labels.txt"

trainDataFile <- "./UCI HAR Dataset/train/X_train.txt"
trainLabelFile <- "./UCI HAR Dataset/train/y_train.txt"
trainSubjectFile <- "./UCI HAR Dataset/train/subject_train.txt"

testDataFile <- "./UCI HAR Dataset/test/X_test.txt"
testLabelFile <- "./UCI HAR Dataset/test/y_test.txt"
testSubjectFile <- "./UCI HAR Dataset/test/subject_test.txt"

columnActivity <- "activity"
columnSubject <- "subject"

## Download the data file and unzip it in current working directory.
download.file(fileUrl, destfile=zipfile, mode='wb')
unzip(zipfile)

## Read the feature names and create valid R column names
features <- read.table(featuresFile, header=FALSE, col.names = c("index", "feature.orig.name"))
features$feature.name <- features$feature.orig.name
features$feature.name <- gsub("-",".",gsub("\\(|\\)","_",features$feature.name))
features$feature.name <- gsub("__",".", features$feature.name)

activity_names <- read.table(labelNameFile, header=FALSE, col.names = c("activity", "name"))

## Read in training data
train_X <- read.table(trainDataFile, header=FALSE, col.names = features$feature.name)
train_y <- read.table(trainLabelFile, header=FALSE, col.names = c(columnActivity))
train_sub <- read.table(trainSubjectFile, header=FALSE, col.names= c(columnSubject))

## Read in test data
test_X <- read.table(testDataFile, header=FALSE, col.names = features$feature.name)
test_y <- read.table(testLabelFile, header=FALSE, col.names = c(columnActivity))
test_sub <- read.table(testSubjectFile, header=FALSE, col.names= c(columnSubject))

## STEP 1 - "Merges the training and the test sets to create one data set."
train_data <- cbind(train_X, train_y, train_sub)
test_data <- cbind(test_X, test_y, test_sub)
all_data <- rbind(train_data, test_data)

## STEP 2 - "Extracts only the measurements on the mean and standard deviation for each measurement."
## In order to achive this we extract out the column names having the word ".mean." and ".std." 
sub_cols <- c(sort( union(grep("\\.mean\\.", names(all_data), value=TRUE), grep("\\.std\\.", names(all_data), value=TRUE)) ), columnActivity, columnSubject) 
sub_data <- all_data[,sub_cols]

## STEP 3 - "Uses descriptive activity names to name the activities in the data set"
## Create a map of activity number to activity name
from <- activity_names$activity
to <- activity_names$name
map <- setNames(to, from)

## Make factors from activity numbers and replace the levels with activity names
sub_data$activity <- as.factor(sub_data$activity)
levels(sub_data$activity) <- map[levels(sub_data$activity)]
# Convert all the levels to lower then replace underscore to " " and then change first character to upper case.
levels(sub_data$activity) <- gsub("\\b([a-z])([a-z]+)", "\\U\\1\\L\\2" , 
                                  gsub("_"," ",tolower(levels(sub_data$activity))), 
                                  perl=TRUE)

## STEP 4 - "Appropriately labels the data set with descriptive variable names."
## The conversion is done as below
## t - time
## f - freq
## BodyBody - body
## Body - body
## Acc - accl
## Gyro - gyro
## Gravity - gravity
## Mag - magnitude
## Jerk - jerk
## std - std
## mean - mean

## all words are lower case and separated by the dot character.
sub.names <- names(sub_data)
sub.names <- gsub("^t", "time.", sub.names)
sub.names <- gsub("^f", "freq.", sub.names)
sub.names <- gsub("BodyBody", "body.", sub.names)
sub.names <- gsub("Body", "body.", sub.names)
sub.names <- gsub("Acc", "accl.", sub.names)
sub.names <- gsub("Gyro", "gyro.", sub.names)
sub.names <- gsub("Gravity", "gravity.", sub.names)
sub.names <- gsub("Mag", "magnitude.", sub.names)
sub.names <- gsub("Jerk", "jerk.", sub.names)
sub.names <- gsub("std", "std.", sub.names)
sub.names <- gsub("mean", "mean.", sub.names)
sub.names <- gsub("\\.\\.", ".", sub.names) ## replace double dots with single
sub.names <- gsub("\\.\\.", ".", sub.names) ## again replace double dots with single
sub.names <- gsub("\\.$", "", sub.names)
names(sub_data) <- sub.names

## STEP 5 - "From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject."
# Compute the mean per activity and subject
tidy_data <- aggregate(.~activity+subject, data=sub_data, FUN=mean)
tidy_data <- tidy_data[,names(sub_data)]

## Write the output to tidy data text file.
write.table(tidy_data, "uci-har-tidy-data.txt", row.names=FALSE)

