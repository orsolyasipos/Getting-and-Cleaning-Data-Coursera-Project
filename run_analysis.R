#getting the data
#get the location of the data
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

#download the zip file
download.file(fileURL, destfile = "activeData.zip", method = "curl")

#save the date when the data was downloaded
DateDownloaded <- date()

#unzip the downloaded files
all_files <- unzip("activeData.zip")

#read the important files you will use into dataframes
#get the labels for each activity
activity_labels <- read.table(all_files[1])

#get the features (variables) for the training and test sets
features <- read.table(all_files[2])

#get the IDs of the volunteers in the test set
test_subject <- read.table(all_files[14])

#get the data of the test set
test_set <- read.table(all_files[15])

#get the labels for the test set
test_label <- read.table(all_files[16])

#get the IDs of the volunteers in the training set
train_subject <- read.table(all_files[26])

#get the data of the training set
train_set <- read.table(all_files[27])

#get the labels for the training set
train_label <- read.table(all_files[28])

# 1. merge the training set and test set to create one data set 
data_set <- rbind(train_set, test_set)


# 2. extract the measurements on the mean and standard deviation for each 
#measurement
#get the names of the measurements on the mean and standard deviation from 
#features and save it (the_coloumns), this will be useful to pick the right 
#coloumns from our data set
the_coloumns <- grep("(.*)mean(.*)|(.*)std(.*)", features$V2)

#save the variable names too
var_names <- grep("(.*)mean(.*)|(.*)std(.*)", features$V2, value = TRUE)

#install the dplyr package (if needed)
install.packages("dplyr")
#call the dplyr package
library(dplyr)

#select the appropriate coloumns for our new data set (data_mean_sd)
data_mean_sd <- select(data_set, the_coloumns)


# 3. use descriptive activity names to name the activities in the data set
#create one data set for the activity labels of the training and the test sets
data_label <- rbind(train_label, test_label)

#change the values in data_label to descriptive activity names
#install the car package (if needed)
install.packages("car")#
#call the car package
library(car)

#change the values in data_label and save it (data_label_descr)
data_label_descr <- recode(data_label$V1, "'1' = 'walking'; '2' = 'walking_upstairs'; '3' = 'walking_downstairs'; '4' = 'sitting'; '5' = 'standing'; '6' = 'laying'")

#add the names of the activities (data_label_descr) to the new data set 
#(data_mean_sd) as a first coloumn
data_mean_sd <- cbind(data_label_descr, data_mean_sd)


# 4. appropriately label the data set with descriptive variable names
# add the subject IDs to the new dataset (data_mean_sd) as the first coloumn
#create one data set for the subject IDs of the training and the test sets
data_subject <- rbind(train_subject, test_subject)

#add the subject IDs (data_subject) to the new data set (data_mean_sd) 
#as a first coloumn
data_mean_sd <- cbind(data_subject, data_mean_sd)

#create the variable names for each coloumn of our data set (data_mean_sd)
var_names <- c("ID", "activity", var_names)

#give variable names to each coloumn in our data set (data_mean_sd)
colnames(data_mean_sd) <- var_names

# 5. from the data set in step 4, create a second, independent tidy data set 
#with the average of each variable for each activity and each subject
#calculate the average values for each variable for each activity and each 
#subject and save it to a second dataframe (data_2)
data_2 <- aggregate(data_mean_sd, by = list(data_mean_sd$activity, data_mean_sd$ID), FUN = mean)

#drop the ID and activity coloumn
data_2 <- data_2[-c(3,4)]

#rename Group.1 as activity and Group.2 as ID in the new data set (data_2)
names(data_2)[1:2] <- c("activity","ID")

#write this second tidy data set into a file called "tidy_data"
write.table(data_2, file = "tidy_data", row.name=FALSE)





