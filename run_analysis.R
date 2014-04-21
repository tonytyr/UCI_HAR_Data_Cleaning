setwd("E:\\study\\MOOC\\JH_MOOC\\GettingandCleaningData\\files\\UCI_HAR_Dataset")

## Read the header and the data
header <- read.table("features.txt", header=F)
header <- as.character(header$V2)

X_test <- read.table("test\\X_test.txt", header=F)
Y_test <- read.table("test\\Y_test.txt", header=F)
subject_test <- read.table("test\\subject_test.txt", header=F)
X_train <- read.table("train\\X_train.txt", header=F)
Y_train <- read.table("train\\Y_train.txt", header=F)
subject_train <- read.table("train\\subject_train.txt", header=F)

## Merges the training and the test sets to create one data set
test_data <- cbind(X_test, Y_test, subject_test)
train_data <- cbind(X_train, Y_train, subject_train)
CleanData <- rbind(train_data, test_data)

## Extracts only the measurements on the mean and standard deviation for each measurement
header_subset <- grep("mean\\(\\)|std\\(\\)", header)
CleanData <- CleanData[, c(header_subset,562, 563)]
names(CleanData) <- c(header[header_subset], "activity", "subject")

## Uses descriptive activity names to name the activities in the data set
activity_labels <- read.table("activity_labels.txt", header=F)
activity_labels <- as.character(activity_labels[,2])


## Appropriately labels the data set with descriptive activity names. 
CleanData$activity_name <- sapply(CleanData$activity, function(x){activity_labels[x]})


## Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
TidyData <- expand.grid(subject=1:30, activity= activity_labels)
CleanData$activity_name <- factor(CleanData$activity_name, levels = activity_labels)

for(i in 1:66){
  tmp <- tapply(CleanData[,i], list(CleanData$subject, CleanData$activity_name), mean)
  TidyData <- cbind(TidyData, as.vector(tmp))
}

TidyHeader <- paste0(header[header_subset], "_average")
names(TidyData)[3:68] <- TidyHeader

## Output the data in txt file
write.table(TidyData, "tidydata.txt", row.names = F)
