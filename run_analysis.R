require("dplyr")

###Read the training and testing data sets
x_train <-read.table("~/UCI HAR Dataset/train/X_train.txt")
y_train <-read.table("~/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("~/UCI HAR Dataset/train/subject_train.txt")


x_test <-read.table("~/UCI HAR Dataset/test/X_test.txt")
y_test <-read.table("~/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("~/UCI HAR Dataset/test/subject_test.txt")


activity_labels <- read.table("~/UCI HAR Dataset/activity_labels.txt")
features <- read.table("~/UCI HAR Dataset/features.txt")


### Step 1 to 4. 
### I am not going to respect the same order provided in #### the assigment.

#### Creating the Trainng and Testing data set
#Assigning names to variables
names(y_test)<-c("activity_id")
names(y_train)<-c("activity_id")
names(activity_labels)<-c("activity_id","activity_labels")
names(x_test)<-features[,2]
names(x_train)<-features[,2]
names(subject_test)<-c("subject")
names(subject_train)<-c("subject")

## Creating the testing data set
# Binding the x_test and Y_test
test<-cbind(x_test, y_test,subject_test)
# Adding Activity labels to Test data set
test<-inner_join(test,activity_labels)

## Creating the training data set
# Binding the x_trin and Y_train
train<-cbind(x_train, y_train, subject_train)
# Adding Activity labels to train data set
train<-inner_join(train,activity_labels)

# Binding the testing and training data into one data frame
HAR<-rbind(train, test)


### Extracting  only the measurements on the mean and 
### standard deviation for each measurement. 
#### I will not consider meanFreq() variables

## Creating a logical vector to index variables matching 
## mean() and std()
keywords<-c("\\<mean()\\>","\\<std()\\>")
feature_select<-data.frame(sapply(keywords, grepl, names(HAR)))
feature_select<-as.logical(feature_select[,1]+feature_select[,2])
## Extracting the matching variables
HARS<-(HAR[,feature_select])
## Re-adding the Activity_labels and subject variables
## droped by the previous operation
HARS$activity.labels<- HAR$activity_labels
HARS$subject<- HAR$subject

## labeling the data with descriptive variable name

varname<-names(HARS)
# Removing "()"
varname <-gsub("\\()", "", varname)
#Replacing "BodyBody" with "Body"
varname <-gsub("BodyBody", "Body", varname)
# Replacing  "-" with "."
varname <-gsub("-", ".", varname)
# Assigning new cleaned names to HARS
names(HARS) <-varname

#### Creating a second, independent tidy data set with the average of each variable for each activity and each subject
## grouping by subject and activity
by_group <- group_by(HARS, subject, activity.labels)
tidy <-summarise_each(by_group,funs(mean))

## Exporting the new tidy data set to tidy.tt file
write.table(tidy, "~/EBOOK/Formation/MOC/DATA SCIENCE SPECIALIZATION/Getting and Cleaning Data/Project/UCI HAR Dataset/tidy.txt", sep="\t", row.name=FALSE)

