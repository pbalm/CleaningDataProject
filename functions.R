# Helper function to get the datafiles we need to read
# Call with test or train
getFilenames <- function(dset) { 
    xfile = paste(dset, "/X_", dset, ".txt", sep="")
    yfile = paste(dset, "/y_", dset, ".txt", sep="")
    c(xfile, yfile)
}

# Helper to read the features.txt file. This just returns a character vector
# with the features -- corresponding to the column names in the X data.
readFeatures <- function() {
    # Read the list of features -- this corresponds to the column names
    data = read.table("features.txt", stringsAsFactors = FALSE)
    data$V2    
}

# Helper to read the activity labels
readActivityLabels <- function() {
    act_labels = read.table("activity_labels.txt", stringsAsFactors = FALSE)
    names(act_labels) = c("Activity.ID","Activity.Label")
    act_labels
}

# Helper to get the label given an activity ID.
# This requires the existence of a data frame called act_labels with the activity labels
# (Note that "labels" is a function in the base plotting package)
act_labels = readActivityLabels()
getActivityLabel <- function(x) {
    row = act_labels[act_labels$Activity.ID == x,]
    row$Activity.Label
}

# Helper function: Read the files and produce on appropriately labeled dataframe
readSet <- function(files) {
    # The y-file contains the activity labels
    # Read it and label appropriately
    yfile = files[2]
    activity = read.table(yfile)
    names(activity) = "Activity.ID"
    
    # Read the X-file with all the features data
    xfile = files[1]
    features_data = read.table(xfile)
    
    # Label the features_data appropriately
    names(features_data) = readFeatures()
    
    data = cbind(activity, features_data)
    data
}

# First get the list of column names that contain either "mean" or "std"
getMeanAndStdFeatures <- function() {
    feats = readFeatures()
    
    # Select those columns that contain "mean"
    meancolslist = sapply(feats, grep, pattern="mean")
    # unlist leaves us with a vector containing only the selected columns
    # get the names of those
    meancols = names(unlist(meancolslist))
    
    # Now do the same for columns contains "std"    
    stdcolslist = sapply(feats, grep, pattern="std")
    stdcols = names(unlist(stdcolslist))
    
    sort(c(meancols, stdcols))
}
