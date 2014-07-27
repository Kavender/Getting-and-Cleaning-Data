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
    Step One: Download the original data file with the URL link. Then unizp the compressed file into the same directory.
              The list of filename contained in unziped folder can be accessed with the **fname** variable.
  ----------------------
    path<-getwd()
    #When use download.file() remember to change https to http
    url<-"http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    filename<-"Dataset.zip"
    if (!file.exists(path)){
     dir.create(path)
     }
    download.file(url,file.path(path,filename))
    unzip(file.path(path,filename),exdir=path,overwrite=TRUE)
    pathIn<-file.path(path,"UCI HAR Dataset")
    fname=list.files(pathIn,recursive=TRUE)
    

--------------------------------
    Step Two: Read the Subject,Data and Label file for both training and testing data in R. 
              Merge the traning and testing data using **rbind()** command. 
              The dimension of the original and merged dataset can be seen with **dim()** command.
  --------------------
    trainSubject<-read.table(paste0(pathIn,"/",fname[26]))
    trainData<-read.table(paste0(pathIn,"/",fname[27]))
    trainLabel<-read.table(paste0(pathIn,"/",fname[28]))
    testSubject<-read.table(paste0(pathIn,"/",fname[14]))
    testData<-read.table(paste0(pathIn,"/",fname[15]))
    testLabel<-read.table(paste0(pathIn,"/",fname[16]))
    dim(trainSubject);dim(trainData);dim(trainLabel) # [7352, 1];[7352 , 561];[7352, 1]
    dim(testSubject);dim(testData);dim(testLabel)    # [2947 ,1];[2947 , 561];[7352,1]
    mergedSubject<-rbind(trainSubject,testSubject)
    mergedData<-rbind(trainData,testData)
    mergedLabel<-rbind(trainLabel,testLabel)
    dim(mergedSubject);dim(mergedData);dim(mergedLabel) #[10299, 1];[10299, 561];[10299,1]
----------------------------------------------------------------------------------
    Step Three: Read the **measurement** from the feature dataset.
                Rename the column name to make it comparable to the column name in the previous merged datasets. 
                Subset the merged data based on the FeatureID/"measurement".
 ---------------
    features<-read.table(paste0(pathIn,"/",fname[2]))
    dim(features)
    colnames(features)<-c("FeatureID","FeatureName")
    subfeature<-features[grepl("mean\\(\\)|std\\(\\)",features$FeatureName),]
    subfeature$feature_colname<-paste0("V",subfeature$FeatureID)
    head(subfeature)
    subData<-mergedData[,subfeature$FeatureID]
    names(subData)<-subfeature$FeatureName
    names(subData)<-tolower(gsub("\\(|\\)","",names(subData)))
------------------------------------------------
    Step Four: Read in the **Activity** file and rename the activity with Descriptive name as Merged Label.
  ----------------
    activity_label<-read.table(paste0(pathIn,"/",fname[1]))
    colnames(activity_label)<-c("ActivityNum","ActivityName")
    activity_label[,2]<-gsub("_","",tolower(activity_label[,2]))
    mergedLabel[,1]<-activity_label[mergedLabel[,1],2]
    colnames(mergedLabel)<-"ActivityName"
----------------------------------------------------





III:Result
===================

The **tidy_dataset.txt** contains the output observations which has been cleaned up with the previous requirement.
The **summary_data_average.txt** containes the mean value of all 66 variables grouped by ActvitityName and Subject.

Both the cleanedup data files and the run_analysis.R file are listed in this branch. You can easily reproduce the results with my R code. 


© Kavender 2014 All Rights reserved.




