# Download the zipped "Human Activity Recognition Using Smartphones Data Set" 
# from the UCI Machine Learning Repository.  Put in temp data directory.
if(!file.exists("./data")){
  dir.create("./data")
}

setwd("./data")

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "humanAR.zip")

# Record download timestamp to txt file
writeLines(paste("UCI Machine Learning Repository Human Activity Recognition", 
                 "Using Smartphones (HARUS) Data Set downloaded:", 
                 date()), "../download_ts.txt")

# Unzip contents of zipped data set, flattening directory structure
unzip("humanAR.zip", junkpaths=T,)

# Create data frame of feature ids and names
features <- read.table("features.txt", header=F, col.names=(c("Feature_id", "Feature_name")), as.is=T)

# Create data frame of activity ids and names
activities <- read.table("activity_labels.txt", header=F, col.names=(c("Activity_id", "Activity_name")), as.is=T)

# Read in and merge the subject id data sets
subjectdatafiles <- c("subject_test.txt", "subject_train.txt")
subject_data <- data.frame()

for(i in subjectdatafiles){
  # Create data frame of subject ids
  tmptable <- read.table(i, header=F, col.names=c("Subject_id"))
  subject_data <- rbind(subject_data, tmptable)
  rm(tmptable)
}

# Read in and merge training and test data sets (the "X" files)
xdatafiles <- c("X_test.txt", "X_train.txt")
X_data <- data.frame()

for(i in xdatafiles){
  # Create data frame using feature names as column header
  tmptable <- read.table(i, header=F, col.names=c(features$Feature_name))
  X_data <- rbind(X_data, tmptable)
  rm(tmptable)
}

# Select out only "mean" and "standard deviation" data in X_data
X_data <- X_data[, grep(".*(mean|std).*", colnames(X_data))]

# Read in and merge training and test activity labels (the "Y" files)
ydatafiles <- c("Y_test.txt", "Y_train.txt")
Y_data <- data.frame()

for(i in ydatafiles){
  # Create data frame using feature names as column header
  tmptable <- read.table(i, header=F, col.names=c("Activity_id"))
  Y_data <- rbind(Y_data, tmptable)
  rm(tmptable)
}

# Merge subject, X, and Y datasets
merged_data <- cbind(subject_data, X_data, Y_data)

# Add descriptive activity names by merging data with activity names
merged_data <- merge(activities, merged_data, by = "Activity_id")

# Sort data first by subject id, then activity
merged_data <- merged_data[order(merged_data$Subject_id, merged_data$Activity_id),]

# Reset row.names to avoid confusion
rownames(merged_data) <- NULL

# Create new data frame showing means of each feature grouped by subject id
# and activity.  Sort by subject id then activity
mean_data <- aggregate(. ~ Subject_id + Activity_id + Activity_name, merged_data, FUN = mean)
mean_data <- mean_data[order(mean_data$Subject_id, mean_data$Activity_id), ]

# Prepend "Mean of " to column headings for clarity
colnames(mean_data)[4:ncol(mean_data)] <- paste("Mean of", colnames(mean_data[4:ncol(mean_data)]))

# Reset row.names to avoid confusion
rownames(mean_data) <- NULL

# Write merged_data and mean_data out to txt file
write.table(merged_data, "../Merged_HARUS_data.txt", row.names=F)
write.table(mean_data, "../Mean_HARUS_data_by_subject_and_activity.txt", row.names=F)

# Return to initial working directory
setwd("../")
