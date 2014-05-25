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
# These steps are referred to below.
#
# PREPARATION to run this code:
# - clone the Git repo
# - INSIDE the repo, unzip the data file for this project
# - call setwd("...") to change the working dir of R to the repo directory (which will end with
#   "CleaningDataProject".

# Import my helper functions from functions.R
source("functions.R")

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

# Appropriately labels the data set with descriptive activity names. I think that STANDING is pretty
# descriptive and appropriate. But OK, I'll relabel WALKING_UPSTAIRS to Walking Upstairs using the
# simpleCap function in functions.R.
newlevels = sapply(levels(labeledData$activityLabels), simpleCap)

# Step (4) Result: Set the pretty labels on labeledData.
levels(labeledData$activityLabels)  = newlevels

# Building the tidy data frame involves a bit of splitting and recombining... This is done in 
# the function buildTidyDataframe
# Step (5) Result: A tidy dataframe with one columnn per variable and just the requested data (averages
# for each variable for each activity)
tidydf = buildTidyDataframe(labeledData)

# And output it for separate submission
#write.csv(tidydf, file="tidy.data.csv")
