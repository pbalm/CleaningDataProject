datasetdir = "UCI\ HAR\ Dataset/"

# Helper function to get the datafiles we need to read
# Call with test or train
getFilenames <- function(dset) { 
    xfile = paste(datasetdir, dset, "/X_", dset, ".txt", sep="")
    yfile = paste(datasetdir, dset, "/y_", dset, ".txt", sep="")
    c(xfile, yfile)
}

# Helper to read the features.txt file. This just returns a character vector
# with the features -- corresponding to the column names in the X data.
readFeatures <- function() {
    # Read the list of features -- this corresponds to the column names
    data = read.table(paste(datasetdir, "features.txt", sep=""), stringsAsFactors = FALSE)
    data$V2    
}

# Helper to read the activity labels
readActivityLabels <- function() {
    act_labels = read.table(paste(datasetdir, "activity_labels.txt", sep=""), stringsAsFactors = FALSE)
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

# Helper to replace the underscores in strings by a space and capitalize each word.
# This changes "WALKING_UPSTAIRS" to "Walking Upstairs".
simpleCap <- function(x) {
  s <- strsplit(x, "_")[[1]]
  paste(toupper(substring(s, 1,1)), tolower( substring(s, 2)),
        sep="", collapse=" ")
}

# Build one dataframe starting from the labeled data, following the requirements for step 5.
buildTidyDataframe <- function(labeledData) {
  # the data without the activity labels and IDs
  noactdata = labeledData[, 3:ncol(labeledData)]
  splitlist = split(noactdata, labeledData$activityLabels)
  splitlistmeans = lapply(splitlist, lapply, mean)
  # Unlisting gives us a numeric vector with a names for each row: activity[dot]variable
  vectormeans = unlist(splitlistmeans)
  # Create the activity column. Unlisting puts the activity in the odd rows and the variable in the even rows
  columntitles = unlist(sapply(names(vectormeans), strsplit, "\\."))
  
  oddrows = seq(1, length(columntitles), 2)
  evenrows = oddrows + 1
  
  # Extract vectors with activity labels and the variable names
  activitynames = columntitles[oddrows]
  variables = columntitles[evenrows]
  
  # Use nice names for the variables
  variables = sapply(variables, getCleanVarName)
  
  # Build the tidy data frame
  tidydf = data.frame(activitynames, variables, vectormeans)
  
  # Remove rownames as they're just a bit messy
  rownames(tidydf) = NULL
  
  # Done!
  tidydf
}

# Get a clean variable name.
# tBodyAcc-std()-X  --> tBodyAcc.std.x
getCleanVarName <- function(varname) {
    # Remove the brackets
    varname = gsub("\\(","", varname)
    varname = gsub("\\)","", varname)
    
    # split by dashes
    varnames = unlist(strsplit(varname, "-"))
    
    # last one to lower case (this is X, Y or Z)
    varnames[length(varnames)] = tolower(varnames[length(varnames)])
    
    # now join it back together with dots
    varname = paste(varnames, collapse=".")
    
    varname
}

