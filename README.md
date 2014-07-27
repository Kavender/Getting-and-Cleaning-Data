Project Submission for Coursera.com
========================
Author: Kavender, July 22, 2014


I: Description of this Project
==================================
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

 


II:The run_analysis.R script
==============================

2.1 The run_analysis.R file is writen in R to fulfill the following tasks:
--------------------------------------------------------------------------

1.  Merges the training and the test sets to create one data set.
2.  Extracts only the measurements on the mean and standard deviation for each measurement. 
3.  Uses descriptive activity names to name the activities in the data set.
4.  Appropriately labels the data set with descriptive variable names. 
5.  Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 


2.2 Steps to solve the above steps
--------------------------------------
    Before 









III:Result
===================

The **tidy_dataset.txt** contains the output observations which has been cleaned up with the previous requirement.
The **summary_data_average.txt** containes the mean value of all 66 variables grouped by ActvitityName and Subject.

Both the cleanedup data files and the run_analysis.R file are listed in this branch. You can easily reproduce the results with my R code. 


© Kavender 2014 All Rights reserved.




