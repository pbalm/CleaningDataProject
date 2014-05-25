CleaningDataProject
===================

This is the Course project for Getting And Cleaning Data course on Coursera.

The instructions require to make the following steps: Write a script that

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

These steps are referred to in the run_analysis.R script, indicating when a specific step is completed.

Note that many steps in the analysis are done in functions, which for readability are in functions.R, so this script
has to be sourced by run_analysis.R, and to source it, it will have to find it, of course. Therefore, to run the code:

- clone the Git repo
- INSIDE the repo, unzip the data file for this project
- call setwd("...") to change the working dir of R to the repo directory (which will end with "CleaningDataProject".

Many thanks and good luck to you with your project!
