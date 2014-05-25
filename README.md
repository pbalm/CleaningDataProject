CleaningDataProject
===================

This is the Course project for Getting And Cleaning Data course on Coursera.

The instructions require to make the following steps: Write a script that

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

These steps are referred to in the [run_analysis.R](run_analysis.R) script, indicating when a specific step is completed.

## Running the scripts

Note that many steps in the analysis are done in functions, which for readability are in [functions.R](functions.R), so this script
has to be sourced by [run_analysis.R](run_analysis.R), and to source it, it will have to find it, of course. Therefore, to run the code:

- clone the Git repo
- INSIDE the repo, unzip the data file for this project
- call setwd("...") to change the working dir of R to the repo directory (which will end with "CleaningDataProject".
- then source [run_analysis.R](run_analysis.R)

## What the scripts do

The main steps of the analysis are as follows:

- Read the `acitvity_labels.txt` file. This file contains readable information about what the activity IDs mean. It's readable, but we will clean it up later.
- Read the file `features.txt`. This file explains the meaning of the columns in the `y_train.txt` and `y_test.txt`. This project uses the terms "feature" and "variable" interchangeably. They are understood to mean the same thing here. A variable is a feature is a variable.

The following steps are done for both the test and the train datasets. I'll refer here to the test set, but the script actually reads both sets, concatenates them and processes them as a whole.

- Read `y_test.txt` (just one column) and add a column with the activity label from `activity_labels.txt`
- Read `X_test.txt`, which has 561 columns, same as the rows in the features file. So use the features to label the columns.
- Merge these datasets so you can now see which activity the different X data is labeled with.

Then we select the *mean* and *standard deviation* variables. I select these by selecting columns that have either "mean" or "std" in their title. The `features_info.txt` file says:

    mean(): Mean value
    std(): Standard deviation

So that seems justified.

We proceed to cleaning up the textual labels for the activities and the variables.

- Activities are split by underscores and change to title case (all words capitalized): WALKING_UPSTAIRS becomes Walking Upstairs.
- From variables we remove the brackets `()`, we replace the dashes with dots and change the last letter to lower case. That way, `tBodyAcc-mean()-X` becomes `tBodyAcc.mean.x`. I think that formally one may argue that `tbodyacc.mean.x` would be better, however, I think this doesn't help readability.

Finally, we have to generate the *tidy data frame* and write it out to a standard CSV file.

This data frame shall have the sums of each of the variables for each activity. So you then get  a data frame like this:

| Activity label | Variable | Value  |
| ------ | ------ | -----: |
|  Sitting  |  tBodyAcc.mean.x  |   ...  |
|  Sitting  |  tBodyAcc.mean.y  |   ...  |
|  Sitting  |  tBodyAcc.mean.z  |   ...  |
| ...  |  ...  |   ...  |
|  Walking Upstairs  |  tBodyAcc.mean.x  |   ...  |
|  Walking Upstairs  |  tBodyAcc.mean.y  |   ...  |
|  Walking Upstairs  |  tBodyAcc.mean.z  |   ...  |
| ... etc ...  |  ...  |   ...  |

However the data we have so far looks more like:

| Activity label | tBodyAcc.mean.x  | tBodyAcc.mean.y  | tBodyAcc.mean.z  | ... more varables ... |
| ------ | ------ | ------ | ------ | -----: |
| Sitting | ... numbers for one subject ... |    |    |   |
| Sitting | ... numbers for one subject ... |    |    |   |
| Sitting | ... numbers for one subject ... |    |    |   |
| Sitting | ... numbers for one subject ... |    |    |   |
| ...  | ...  |    |    |   |
| Walking Upstairs | ... numbers for one subject ... |    |    |   |
| ... and so on ...  | ...  |    |    |   |

So we have to average the variable columns and correctly reshape to arrive at the tidy data frame. This is what the `buildTidyDataframe` function does -- see [functions.R](functions.R).

## Finally

I also provided the [Code Book](CodeBook.md) describing the final tidy dataset. And...

Many thanks for peer reviewing and good luck to you with your project!