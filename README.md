# Getting And Cleaning Data - Course Project

For creating a tidy data set of wearable computing data originally from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Files in Repo
README.md -- the current document, highlights the entire process
CodeBook.md -- codebook describing variables, the data and transformations
run_analysis.R -- The R script

## Introduction
This reposiroty contains all the project files for the Coursera course named "Getting And Cleaning Data".
This course forms part of the Data Science specialization.

The script named run_analysis.R contains all R code that reads and transform the file contents into a tidy data set and ultimately the result
The script performs the following tasks:

1. Create Data directory if it is not already created
2. Download UCI HAR zip file to Data directory
3. Unzips file to extract contents
4. Read and combines data files
5. Transforms the data set to make it tidy
6. Output data file to a text file

The file CodeBook.md explains the above in more detail.

## The files
Once the zip file is downloaded, it is extracted into a folder named Data via R script. 
The script assumes the the following files and folders are in its working directory:

activity_labels.txt
features.txt
test/
train/
The output is created in working directory with the name of TidyData.txt


