Code Book for the Getting And Cleaning Data course project
===================

This is the Code Book for the course project for Getting And Cleaning Data.

What this Code Book actually clarifies is the meaning and origin of the "tidy data set" that
the course project is meant to produce as its final step.
 
## The Variables

The tidy data set contains the following columns:

* `activitynames`
* `variables`
* `vectormeans`

Each are described in a section below.

### Activity names

The source of the information for the `activitynames` is the  `activity_labels.txt` file. The text in that file has been slightly transformat to make it more readable: Underscore were replaced by spaces and it was set in title case.

The labels have been related to the sensor data in this dataset via the activity ID column in the sensor data.

### Variables column

The `variables` column contains selected items from `features_info.txt`. The project says to focus only only means and standard deviations. Therefore, as explained in README.md, only variables containing either "mean" or "std" have been selected.

### Vector means

The test data contains many records, relating to different test subjects, for each variable and given activity. The tidy data summarizes all these records for one activity by averaging the vector of these numbers.

## The Data

The data comes from [this source](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) (link taken directly from project instructions).

It has been transformed as described in the README.md and project instructions for the [Getting and Cleaning Data course](https://class.coursera.org/getdata-003).

The result is described in the variables section of this document, see above.



## Cleaning the Data