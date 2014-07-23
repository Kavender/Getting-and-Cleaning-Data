###Reference for Project/Data:
#[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
#- Features are normalized and bounded within [-1,1].
#- Each feature vector is a row on the text file.
########


###Step One:Merges the training and the test sets to create one data set.
path<-getwd()
#When use download.file() remember to change https to http
url<-"http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
filename<-"Dataset.zip"
if (!file.exists(path)){
     dir.create(path)
}
download.file(url,file.path(path,filename))
#unzip(file.path(path,filename),exdir=path,overwrite=TRUE)

#get the list of file name (fname) inside the unziped folder
pathIn<-file.path(path,"UCI HAR Dataset")
fname=list.files(pathIn,recursive=TRUE)

##read train and test dataset into R
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


##Step Two:Extracts only the measurements on the mean and standard deviation for each measurement. 
features<-read.table(paste0(pathIn,"/",fname[2]))
dim(features)
colnames(features)<-c("FeatureID","FeatureName")
subfeature<-features[grepl("mean\\(\\)|std\\(\\)",features$FeatureName),]
subfeature$feature_colname<-paste0("V",subfeature$FeatureID)
head(subfeature)
subData<-mergedData[,subfeature$FeatureID]
names(subData)<-subfeature$FeatureName
names(subData)<-tolower(gsub("\\(|\\)","",names(subData)))
head(subData)


##Step Three:Uses descriptive activity names to name the activities in the data set
activity_label<-read.table(paste0(pathIn,"/",fname[1]))
colnames(activity_label)<-c("ActivityNum","ActivityName")
activity_label[,2]<-gsub("_","",tolower(activity_label[,2]))
mergedLabel[,1]<-activity_label[mergedLabel[,1],2]
colnames(mergedLabel)<-"ActivityName"


##Step Four:Appropriately labels the data set with descriptive variable names. 
colnames(mergedSubject)<-"Subject"
cleanedData<-cbind(mergedSubject,mergedLabel,subData)
dim(cleanedData)
write.table(cleanedData,"tiday_dataset.txt")


###Step Five:Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
#table(cleanedData$ActivityName,cleanedData$Subject)
#addmargins(table(cleanedData$ActivityName,cleanedData$Subject))
#length(table(cleanedData$Subject))
#subjmean<-cast(meltData,Subject~variable,mean)


library(plyr)
library(reshape2)
meltData<-melt(cleanedData,id=c("Subject","ActivityName"))
summary_means<-ddply(meltData,c("variable","ActivityName","Subject"),summarise,
                     mean=mean(value))
write.table(summary_means,"summary_data_average.txt")




















