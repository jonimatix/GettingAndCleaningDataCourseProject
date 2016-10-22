# Create directory if directory does not exist
if(!file.exists("./Data")){dir.create("./Data")}

# Set the file Url and download file
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file( fileUrl, destfile="./data/Dataset.zip", method="curl" )

# Unzip the file
unzip(zipfile="./Data/Dataset.zip",exdir="./Data")

# We will use dplyr library
library(dplyr)

####################################################################
# Get the activity (consist of values 1 to 6, with description)
activitylabels <- read.table("./Data/activity_labels.txt", stringsAsFactors=FALSE)
# Add column names
names(activitylabels) <- c("activityid","activitydescription")

####################################################################
### Test data files ###
# Read the test data
test <- read.table("./Data/test/X_test.txt", stringsAsFactors=FALSE)
# Read the test activity data
testactivity <- read.table("./Data/test/y_test.txt", stringsAsFactors=FALSE)
# Read the test subjects data
testsubject <- read.table("./Data/test/subject_test.txt", stringsAsFactors=FALSE)

# Combine datasets test with testactivity and testsubject
test <- cbind(test, testactivity, testsubject)

####################################################################
### Train data files ###
# Read the train data
train <- read.table("./Data/train/X_train.txt", stringsAsFactors=FALSE)
# Read the test activity data
trainactivity <- read.table("./Data/train/y_train.txt", stringsAsFactors=FALSE)
# Read the test subjects data
trainsubject <- read.table("./Data/train/subject_train.txt", stringsAsFactors=FALSE)

# Combine datasets train with trainactivity and trainsubject
train <- cbind(train, trainactivity, trainsubject)

####################################################################
# Combine datasets train and test 
datafull <- rbind(test, train)

####################################################################
# Read the column names data file (features.txt)
columnnames <- read.table("./Data/features.txt", stringsAsFactors=FALSE)
# Add column names
names(columnnames) <- c("columnindex","columnname")

# Remove dashes(-), commas, brackets, and lower case values to make dataset tidy
columnnamestidy <- gsub("-","", columnnames$columnname)
columnnamestidy <- gsub("\\(|\\)", "", columnnamestidy)
columnnamestidy <- gsub(",", "", columnnamestidy)
columnnamestidy <- tolower(columnnamestidy)

# Also replace abbreviations with full description within variables 
columnnamestidy <- gsub("^t", "time", columnnamestidy)
columnnamestidy <- gsub("^f", "frequency", columnnamestidy)
columnnamestidy <- gsub("Acc", "Accelerometer", columnnamestidy)
columnnamestidy <- gsub("Gyro", "Gyroscope", columnnamestidy)
columnnamestidy <- gsub("Mag", "Magnitude", columnnamestidy)
columnnamestidy <- gsub("BodyBody", "Body", columnnamestidy)

# Replace the column names with the tidy version
columnnames$columnname <- columnnamestidy

# Add the column names for activityid and subjectid
newrecord <- data.frame(columnindex=c(562,563), columnname=c("activityid","subjectid"))
columnnames <- rbind(columnnames, newrecord)

####################################################################
# Replace the data frame headers with the tidy column names
names(datafull) <- columnnames$columnname

####################################################################
# Merge datafull with activitylabels to get the activity description
mergedata <- merge(x = datafull, y = activitylabels, by.x ="activityid", by.y ="activityid", all = T)

####################################################################
# Get the indices of the variables that have mean or std or activity or subject in the name
requiredcolumns <- grep("mean|std|activity|subject", names(mergedata))

# Keep only the required columns
dataset1 <- mergedata[,requiredcolumns]

####################################################################
# Generate the mean across all variables
dataset2 <- aggregate(. ~subjectid + activitydescription, dataset1, mean)
dataset2 <- dataset2[order(dataset2$subjectid,dataset2$activitydescription),]

####################################################################
# Output the file to working directory
write.table(dataset2, file = "TidyData.txt", row.names = FALSE)
