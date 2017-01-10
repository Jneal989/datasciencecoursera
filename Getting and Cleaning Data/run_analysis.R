run_analysis(){
        ## Checks for Required Package loads if installed, installed if not
        if(!is.element("reshape2", installed.packages()[,1])){
              n <- readline(prompt = "This function requires the reshape2 package to be installed. Would you like it installed? 1. Yes 2. No:")
              if(n=="1"){
                      install.packages("reshape2")
                      library(reshape2)
              }else{
                      stop("The reshape2 package is required to run this function")
              }
        }else{
                library(reshape2)
        }
        filename <- "getdata-projectfiles-UCI HAR Dataset.zip"
        ## Download and unzip file
        if(!file.exists(filename)){
                fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
                download.file(fileurl, filename, method = "curl")
        }
        if(!file.exists("UCI HAR Dataset")){
                unzip(filename)
        }
        ## Load the activity labels and features
        activitylables <- read.table("UCI HAR Dataset/activity_labels.txt")
        activitylables[,2] <- as.character(activitylables[,2])
        features <- read.table("UCI HAR Dataset/features.txt")
        features[,2] <- as.character(features[,2])
        
        ## Find only the variables with mean or Standard Deviation
        featuresWanted <- grep(".*mean.*|.*std.*", features[,2])
        featuresWanted.names <- features[featuresWanted,2]
        featuresWanted.names <- gsub("[()-]", "", featuresWanted.names)
        featuresWanted.names <- gsub("mean", "Mean", featuresWanted.names)
        featuresWanted.names <- gsub("std", "Std", featuresWanted.names)
        
        ## Load the data set with only wanted variables
        train <- read.table("UCI HAR Dataset/train/X_train.txt")[featuresWanted]
        trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
        trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
        train <- cbind(trainSubjects, trainActivities, train)
        
        test <- read.table("UCI HAR Dataset/test/X_test.txt")[featuresWanted]
        testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
        testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
        test <- cbind(testSubjects, testActivities, test)
        
        ## Merge the 2 data sets and add labels
        alldata <- rbind(train, test)
        colnames(alldata) <- c("Subject", "Activity",featuresWanted.names)
        
        ## Turn Activity and Subjects into factors
        alldata[,2] <- factor(alldata[,2], levels = activitylables[,1], labels = activitylables[,2])
        alldata[,1] <- as.factor(alldata[,1])
        
        ## Sets ID Variables and finds mean by ID variables.
        alldata.melted <- melt(alldata, id =  c("Subject", "Activity"))
        alldata.mean <- dcast(alldata.melted, Subject + Activity ~ variable, mean)
        
        ## Saves final data set as csv file
        write.table(alldata.mean, "mean by subject and activity.txt",row.names = FALSE, quote = FALSE)
        
}

