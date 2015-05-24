Getting and Cleaning Data Course Project CodeBook
=================================================
This file describes all process to get clean up the data.  
* A full description is available at the site where the data was obtained: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones      
Source of the original data:  
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
* The run_analysis.R script performs the following steps to clean the data:   
 1. Do to Merges the training and test sets to create one data set, namely train/X_train.txt with test/X_test.txt,  train/subject_train.txt with test/subject_test.txt, and train/y_train.txt with test/y_test.txt.       
 2. This script reads features.txt and extracts only the measurements on the mean and standard deviation for each measurement.  
 3. This script reads activity_labels.txt and applies descriptive activity names to name the activities in the data set. 
 4. This script also appropriately labels the data set with descriptive names: all feature names (attributes) and activity names are converted to lower case, underscores and brackets () are removed. The result is saved as mcd.txt,
 5. The script creates a 2nd, independent tidy data set with the average of each measurement for each activity and each subject. The result is saved as dataset_averages.tx   
 
 
© Manuel Ramírez 2014 All Rights reserved.