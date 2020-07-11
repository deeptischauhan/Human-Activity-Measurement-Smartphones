mergedata <- function(){
        library(dplyr)
        features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
        activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("activity_code", "activity_label"))
        
        subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
        x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
        y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "activity_code")
        
        subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
        x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
        y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "activity_code")
        
        complete_X <- rbind(x_train, x_test)
        complete_Y <- rbind(y_train, y_test)
        complete_Subject <- rbind(subject_train, subject_test)
        allmergeddata <- cbind(complete_Subject, complete_Y, complete_X)

        TidyData <- allmergeddata %>% select(subject, activity_code, contains("mean"), contains("std"))
        TidyData$activity_code <- activities[TidyData$activity_code, 2]
        
        names(TidyData)[2] = "activity_label"
        
        names(TidyData)<-gsub("-mean()", "mean", names(TidyData), ignore.case = TRUE)
        names(TidyData)<-gsub("-std()", "std", names(TidyData), ignore.case = TRUE)
        names(TidyData)<-gsub("Acc", "accelerometer", names(TidyData))
        names(TidyData)<-gsub("Gyro", "gyroscope", names(TidyData))
        names(TidyData)<-gsub("Mag", "magnitude", names(TidyData))
        names(TidyData)<-gsub("angle", "angle", names(TidyData))
        
        names(TidyData)<-gsub("^t", "time", names(TidyData))
        names(TidyData)<-gsub("tBody", "timebody", names(TidyData))
        
        names(TidyData)<-gsub("^f", "frequency", names(TidyData))
        names(TidyData)<-gsub("-freq()", "frequency", names(TidyData), ignore.case = TRUE)
        names(TidyData)<-gsub("fBody", "frequencybody", names(TidyData))
        
        IndependentData <- TidyData %>%
                group_by(subject, activity_label) %>%
                summarise_all(mean)
        write.table(IndependentData, "IndependentData.txt", row.name=FALSE)
        
        IndependentData
}