#Getting and Cleaning Data - Course Project
This project contains the following documents:
* Data Code Book - Explains the different variables for "mean by subject and activity.txt"
* run_analysis.R _ R script that rans an analysis on the raw data to get the mean of the variables by the Activity Completed and the Subject which outputs as "mean by subject and activity.txt""
* "mean by subject and activity.txt" - tidy data set

##run_analysis.R completes the following tasks:
1. Installs reshape2 package if not installed and loads it 
2. Downloads the dataset if it isn't in the working directory
3. Loads the activity and feature labels
4. Finds only the features that are the mean or std for each measurement
5. Loads both train and test data sets, including only the feature variables identified above
6. Loads the accompanying activity and subject data for the train and test data sets
7. Merges subject, activity and features variables for both train and test data sets
8. Merges test and train data sets
9. Ads column names to the variables
10. Changes the numbers used in the initial activities data set words using the labels
11. Changes the subject variable into a factor variable from an interger
12. Sets the Id's of the data fram as the Subjest and activities
13. Casts the dataframe into an array, finding the mean of the variables by the Subject and Activity