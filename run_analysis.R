## Do not forget to properly set the working directory
## setwd('D:/Formation/Data Science/Devoirs/Module 3 - Getting and Cleaning Data/Semaine 4/Projet')
## Required package : reshape2



## Making sure that the data set is present
# Zip file has been properly downloaded and named
downFile<-"UCI HAR Dataset.zip"
if(!file.exists(downFile)){
        downURL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(downURL,downFile)
}
# Data set has been properly unzipped
if(!file.exists("UCI HAR Dataset")){ 
        unzip(downFile) 
}



## 1 - Merge Training and Test sets into one data set
# Training files import
trainingData<-read.table('./UCI HAR Dataset/train/X_train.txt')
trainingLabels<-read.table('./UCI HAR Dataset/train/y_train.txt')
trainingSubjects<-read.table('./UCI HAR Dataset/train/subject_train.txt')
# Test files import
testData<-read.table('./UCI HAR Dataset/test/X_test.txt')
testLabels<-read.table('./UCI HAR Dataset/test/y_test.txt')
testSubjects<-read.table('./UCI HAR Dataset/test/subject_test.txt')
# Merging imported files
mergedData<-rbind(trainingData,testData)
mergedLabels<-rbind(trainingLabels,testLabels)
mergedSubjects<-rbind(trainingSubjects,testSubjects)



## 2 - Extract only measurements for mean & standard deviation
# Column names import
colNames<-read.table('./UCI HAR Dataset/features.txt')
# Wanted measurements extraction
finalColIndex<-grep("mean\\(\\)|std\\(\\)",colNames[,2])
finalNames<-colNames[finalColIndex,2]
finalData<-mergedData[,finalColIndex]
# Cleaning names : we keep upcase for readability, upcase Mean and Std,
#       remove (), remove -
finalNames<-gsub("\\-mean\\(\\)(\\-)?","Mean",finalNames)
finalNames<-gsub("\\-std\\(\\)(\\-)?","Std",finalNames)
# Insert names in finalData
names(finalData)<-finalNames



## 3 - Use descriptive activity names to name activities in data set
# Activity labels import
activityLabels<-read.table('./UCI HAR Dataset/activity_labels.txt')
# Lowercase all (with exceptions), remove _
activityLabels[,2]<-tolower(activityLabels[,2])
activityLabels[,2]<-sub("_d","D",activityLabels[,2])
activityLabels[,2]<-sub("_u","U",activityLabels[,2])
# Replace index by label in mergedLabels
mergedLabels[,1]<-activityLabels[mergedLabels[,1],2]



## 4 - Appropriately label data set with descriptive variable names
# Name descriptive data in mergedLabels and mergedSubjects
names(mergedLabels)<-"activity"
names(mergedSubjects)<-"subject"
# Turn descriptive data into factors
mergedLabels[,1]<-as.factor(mergedLabels[,1])
mergedSubjects[,1]<-as.factor(mergedSubjects[,1])
# Create and export clean data frame
cleanData<-cbind(mergedLabels,mergedSubjects,finalData)
write.table(cleanData,"clean_data.txt",row.names=FALSE)



## 5 - Create 2nd data set with average of each variable per activity & subject
# Load required package
library(reshape2)
# Melting cleanData
meltedData<-melt(cleanData,id=c("activity","subject"))
# Create and export averages
cleanAverage<-dcast(meltedData,activity+subject~variable,mean)
write.table(cleanAverage,"clean_average.txt",row.names=FALSE)