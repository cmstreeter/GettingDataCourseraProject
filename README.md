GettingDataCourseraProject
==========================

This repository contains the following files:

1. README.md - This file describing repository contents.
2. run_analysis.R - R script to download and manipulate data from the UCI Machine Learning Repository Human Activity Recognition Using Smartphones (HARUS) project. See detailed description below.
3. codebook.md - A description of the variables contained in the "Mean_HARUS_data_by_subject_and_activity.txt" file produced by running "run_analysis.R".


Overview - run_analysis.R
-------------------------
This script downloads data from the UCI Machine Learning Repository Human Activity Recognition Using Smartphones (HARUS) project (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and outputs the following:

1. Mean_HARUS_data_by_subject_and_activity.txt - A tidy data set (space-delimited) containing the mean measurements for each subject / activity pair for each of the HARUS features representing a mean or standard deviation measurement.
2. Merged_HARUS_data.txt - The merged data set (space-delimited) showing the non-aggregated, raw data used to calculate the data in Mean_HARUS_data_by_subject_and_activity.txt.
3. download_ts.txt - A text file recording the date and time of data download.

Reading data into R
-------------------
The data from either data file can be read into R using the following command:
read.table("[NAME OF FILE]", header = T)

Detailed description
--------------------
run_analysis.R performs the following tasks

1. Downloads HARUS data zip file.
2. Unzips contents into a separate data directory ("./data").
3. Writes the file "download_ts.txt" which records the date and time of data download. 
4. Combines the training and test set data for both the data features ("X_test.txt" and "X_train.txt") and the activity labels ("Y_text.txt" and "Y_train.txt").
5. Extracts only those features reporting a mean or standard deviation measurement (i.e., feature names contain either "mean" or "std").
6. Adds descriptive feature (a.k.a. variable or column) names using the names from the original data set (for consistency and cross reference).
7. Adds descriptive activity labels to each record ("Activity_name").
8. Calculates means for each feature for each subject / activity pair.
9. Writes summary tidy data set out to "Mean_HARUS_data_by_subject_and_activity.txt".
10. Writes non-aggregated, raw data out to "Merged_HARUS_data.txt".
11. Returns user to original working directory.
