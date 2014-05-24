# Course project for Getting And Cleaning Data
# Paul Balm - May 2014
#
# The instructions require to make the following steps: Write a script that
# (1) Merges the training and the test sets to create one data set.
# (2) Extracts only the measurements on the mean and standard deviation for 
#     each measurement. 
# (3) Uses descriptive activity names to name the activities in the data set
# (4) Appropriately labels the data set with descriptive activity names. 
# (5) Creates a second, independent tidy data set with the average of each 
#     variable for each activity and each subject. 
#
# These steps are referred to below. First some helper functions.

# Start with the files in the test set
testdata = readSet(getFilenames("test"))
#traindata = readSet(getFilenames("train"))

# Step (1) Result: Merged, appropriately labeled data with test and train sets
alldata = testdata # rbind(testdata, traindata)

# Now drop columns that are not standard deviation or mean, by subsetting with
# the desired column names, and that's
#
# Step (2) Result: The merged data, with only the mean and std.dev. data, but also keep
# the first column with the activity ID, for later on.
meanAndStdData = alldata[, c("Activity.ID", getMeanAndStdFeatures())]

# Now we need to label the activities.
# Read the labels from activity_labels.txt and find the right label for each number in the
# Activity.ID column:
activity = readActivityLabels()
activityLabels = sapply(meanAndStdData[, "Activity.ID"], getActivityLabel)

# Step (3) Result: Add the activity labels to the data
labeledData = cbind(activityLabels, meanAndStdData)
