# Getting-and-Cleaning-Data-Coursera-Project
Getting and Cleaning Data course assaignment
Orsolya Sipos

During the project R Studio Version 0.99.893 was used.

The data cleaning process started with getting access to the data.
First the data was downloaded with the download.file() command, and the actual
date was saved using the date() command.

Then the zipped file was unzipped using the unzip() command and saved into
"all_files" object.

By printing out "all_files", the important files (to create a tidy dataset)
were selected and each one of them was read into a data frame.

The following data frames were created:
1. activity_labels (to know the label of each activity)
      from "./UCI HAR Dataset/activity_labels.txt"

2. features (to know the variable names for the data sets)
      from "./UCI HAR Dataset/features.txt"

3. test_subject (to get the IDs of the volunteers in the test set)
      from "./UCI HAR Dataset/test/subject_test.txt"

4. test_set (to get the data of the test set)
      from "./UCI HAR Dataset/test/X_test.txt"

5. test_label (to get the activity labels for the test set)
      from "./UCI HAR Dataset/test/y_test.txt"

6. train_subject (to get the IDs of the volunteers in the training set)
      from "./UCI HAR Dataset/train/subject_train.txt"

7. train_set (to get the data of the training set)
      from "./UCI HAR Dataset/train/X_train.txt"

8. train_label (to get the activity labels for the training set)
      from "./UCI HAR Dataset/train/y_train.txt"


Problem 1. "Merge the training set and test set to create one data set."

Using the rbind() command the train_set and test_set data frames were merged
into one data frame, called data_set.


Problem 2. "Extract the measurements on the mean and standard deviation for each
measurement."

Using the grep() command the columns with variable names containing "mean" or
"std" were selected. The number of the relevant columns and the variable names
were saved into the objects the_columns and var_names, respectively.

After calling the dplyr package, a new data set (data_mean_sd) was created using the select() command, where the columns contained measurements on the mean and standard deviation from the original data.


Problem 3. "Use descriptive activity names to name the activities in the data set."

Using the rbind() command one data set was created (data_label) for the activity labels, containing both the training and the test sets.

After calling the car package, using the recode() command the values in the data_label was changed to descriptive names and saved into data_label_descr. The descriptive names for the activity labels was chosen based on the original activity_labels.txt file.

Using the cbind() command, a new column (data_label_descr) with the descriptive activity labels was added as the first column to the data_mean_sd data set.


Problem 4. "Appropriately label the data set with descriptive variable names."

Using the rbind() command one data set was created (data_subject) for the IDs of the volunteers, containing both the training and the test sets.

Using the cbind() command, a new column with the subject IDs (data_subject) was added as the first column to the data_mean_sd data set.

In a string vector (var_names) all the variable names were collected for each column of the data set (data_mean_sd) using ID, activity, and the variables names from var_names.

The new var_names vector was assigned to the colnames() command, and the variable names were added to the data_mean_sd data set.


Problem 5. "From the data set in step 4, create a second, independent tidy data set
with the average of each variable for each activity and each subject."

A new tidy data set (data_2) was created using the aggregate() command, in which the average of the variables of the original data_mean_sd data set for each activity and each subject were created.

For clarity the ID an activity columns were dropped, as aggregate() created two new columns Group.1, which referred to the activity and Group.2, which referred to the subject ID.

Then the Group.1 column was renamed as activity and Group.2 as ID in the new data set (data_2).

As a final step this second tidy data set (data_2) was written into a file called "tidy_data" using the write.table() command.
