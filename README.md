UCI_HAR_Data_Cleaning
=====================

UCI_HAR_Data_Cleaning for the assessment of GettingandCleaningData

Using the script runanalysis.R to make the tidy data set

1. Read the header and the data
   * Read the X, Y, subjects from the training dataset and test dataset
2. Merges the training and the test sets to create one data set
   * Make entire training dataset and test dataset by the function _cbind_ which bind the X, Y, subject together
   * Merge the training and test sets by the function _rbind_
3. Extracts only the measurements on the mean and standard deviation for each measurement
   * Extract the measurement needed using RegExpr in the function _grep_
4. Uses descriptive activity names to name the activities in the data set
   * Read the file _activity_labels.txt_ as the dictionary of activities
5. Appropriately labels the data set with descriptive activity names
   * Looking up the description names from the dictinoary made in step4 for each value in the variable of activity
6. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
   * Using the function _tapply_ to calculate the average against each layer of subject and activity