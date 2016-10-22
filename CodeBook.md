# Code Book

This document describes the code inside run_analysis.R.

Even though the R script contains a lot of comments to describe each line of code, we will go through the script in this Codebook.

## Steps
#### Setting up the Data directory
1. The Data directory is created in the current working directory

#### Downloading and extracting the data file
* Downloads the UCI HAR zip file 
* Extracts the contents in the Data directory

#### Read activity_labels.txt
 * This file consists of 2 columns, showing the subject's activity
 * Populate variable named activitylabels

#### The Test data files
* Read the feature data file and store contents in variable named test
* Read the activity information and store contents in variable named testactivity
* Read the subjects data file and store contents in variable named testsubject
* Combine the above 3 datasets into test

#### The Train data files
* Read the feature data file and store contents in variable named train
* Read the activity information and store contents in variable named trainactivity
* Read the subjects data file and store contents in variable named trainsubject
* Combine the above 3 datasets into train

#### Combining test and train
* Combine datasets train and test in a variable named datafull

#### The column names for test/train data sets
* Read the column names data file (features.txt) in variable named columnnames, using appropriate column names

#### Tidy the data set
##### The below steps will be stored in variable named columnnames:

1. Remove dashes(-), commas, brackets, and lower case values to make dataset tidier

2. Replace abbreviations with full description within variables, for ex. replacing Gyro with Gyroscope

3. Add column names for activityid and subjectid

4. Finally replace the data frame headers with the tidy column names

#### Getting the activity description
1. Merge datafull with activitylabels to get the activity description, into variable named mergedata

#### Keeping inly the required columns
1. Get the indices of the variables that have either mean, std, activity, or subject in the name, into variable named requiredcolumns
2. Keep only the required columns, into variable named dataset1

11. Generate the mean across all variables
* Store the values in variable named dataset2

12. File output
Store dataset2 in a physical file on disk named TidyData.txt
