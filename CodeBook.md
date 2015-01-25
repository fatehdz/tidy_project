Code Book
=================


The following code book describes the transformations and claning performed to get a tidy data set as well as the variables definitions and units.


1. Data ghatering and cleansing 
================================
### The first step was to load the relavant UCI data sets into R.

The datasets includes the following files:

- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

### The 2nd step was to merge the train and test data set:

- For this we first named the variables in the train and test data set with their corresponding names using the features.txt data set, We also assign the names activiy_id to the y-training and y-testing variable ,the names activity_id and activity_labels to the activity_labels variables and the name subject to the subject_train variable.
- Then we create a train data set by binding the collumns of both x_train, y_train and subject_train and then assign activity_labels to the the train data by merging the train data with the activity_labels data. 
- Then we apply the same operation to the test data sets.
- The reslt was 2 data set "train" and "test" with named variables and variables for activity_labels and subject_id.
- We then row bind the two data st into a new one called HAR.

### The 3rd step was to extract only the measurements on the mean and standard deviation for each measurement. 

The initial measured variables came from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

- in order to select only the measurements on the mean and standard deviation for the above listed variables, we construct a logical vector to indicies the position of the variables having the mean() and std() pattern in their names, we then extract only those variables into a new data set called HARS and keep the subject and activity_labels variables as well.


### The 4th step was to label the new data with descriptive variable name.
# One part of labeling the variabless has been already done in step 1. However the labeling provided by the file features_info.txt present some anomalies that need to be fixed in order to simplify the names and increase their meanings.
# We first detect some patterns in the variable names that should be removed as the brackets "()" and some names duplicate as "Body", then we replace the "-" by the "." notation as it is adviced in the the R guidlines.



2. Creating a second, independent tidy data set with the average of each variable for each activity and each subject: 
======================================================================================================================
# To create this new tidy data set we first grouped the data by activity and subject and then summarize each variable by applying the mean function
the result was a tidy data set with 180 records (30 subject * 6 activities) and 68 variables describer below :

body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) 
body linear acceleration and angular velocity Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). 
Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

 *[1] "subject"              
 *[2] "activity.labels"      
 *[3] "tBodyAcc.mean.X" : Average of average body acceleration signal for x axis (Time domaine signals).
 *[4] "tBodyAcc.mean.Y" : Average of average body acceleration signal for y axis (Time domaine signals).   
 *[5] "tBodyAcc.mean.Z" : Average of average body acceleration signal for z axis (Time domaine signals).    
 *[6] "tBodyAcc.std.X"  : Average of student-deviation of body acceleration signal for x axis (Time domaine signals).     
 *[7] "tBodyAcc.std.Y"  : Average of student-deviation of body acceleration signal for y axis (Time domaine signals).    
 *[8] "tBodyAcc.std.Z"  : Average of student-deviation of bosy acceleration signal for z axis (Time domaine signals).    
 *[9] "tGravityAcc.mean.X" : Average of average gravity acceleration signal for x axis (Time domaine signals).
*[10] "tGravityAcc.mean.Y" : Average of average gravity acceleration signal for y axis (Time domaine signals).    
*[11] "tGravityAcc.mean.Z" : Average of average gravity acceleration signal for z axis (Time domaine signals).  
*[12] "tGravityAcc.std.X"  : Average of student-deviation of gravity acceleration signal for x axis (Time domaine signals). 
*[13] "tGravityAcc.std.Y"  : Average of student-deviation of gravity acceleration signal for y axis (Time domaine signals). 
*[14] "tGravityAcc.std.Z"  : Average of student-deviation of gravity acceleration signal for y axis (Time domaine signals). 
*[15] "tBodyAccJerk.mean.X" : Average of average body acceleration jerk signal for x axis (Time domaine signals).
*[16] "tBodyAccJerk.mean.Y" : Average of average body acceleration jerk signal for y axis (Time domaine signals).
*[17] "tBodyAccJerk.mean.Z" : Average of average body acceleration jerk signal for z axis (Time domaine signals).
*[18] "tBodyAccJerk.std.X"  : Average of student-deviation of body acceleration jerk signal for x axis (Time domaine signals). 
*[19] "tBodyAccJerk.std.Y"  : Average of student-deviation of body acceleration jerk signal for y axis (Time domaine signals). 
*[20] "tBodyAccJerk.std.Z"  : Average of student-deviation of body acceleration jerk signal for z axis (Time domaine signals). 
*[21] "tBodyGyro.mean.X"    : Average of average body angular velocity signal for x axis (Time domaine signals).
*[22] "tBodyGyro.mean.Y"    : Average of average body angular velocity signal for y axis (Time domaine signals).
*[23] "tBodyGyro.mean.Z"    : Average of average body angular velocity signal for z axis (Time domaine signals).
*[24] "tBodyGyro.std.X"     : Average of student-deviation of body angular velocity signal for x axis (Time domaine signals).
*[25] "tBodyGyro.std.Y"     : Average of student-deviation of body angular velocity signal for y axis (Time domaine signals).
*[26] "tBodyGyro.std.Z"     : Average of student-deviation of body angular velocity signal for z axis (Time domaine signals).
*[27] "tBodyGyroJerk.mean.X" : Average of average body angular velocity Jerk signal for x axis (Time domaine signals).
*[28] "tBodyGyroJerk.mean.Y" : Average of average body angular velocity Jerk signal for y axis (Time domaine signals).
*[29] "tBodyGyroJerk.mean.Z" : Average of average body angular velocity Jerk signal for z axis (Time domaine signals).
*[30] "tBodyGyroJerk.std.X"  : Average of student-deviation of body angular velocity Jerk signal for x axis (Time domaine signals).
*[31] "tBodyGyroJerk.std.Y"  : Average of student-deviation of body angular velocity Jerk signal for y axis (Time domaine signals).
*[32] "tBodyGyroJerk.std.Z"  : Average of student-deviation of body angular velocity Jerk signal for z axis (Time domaine signals).
*[33] "tBodyAccMag.mean"     : Average of average body acceleration magnitude signal (Time domaine signals).
*[34] "tBodyAccMag.std"      : Average of student-deviation of body acceleration magnitude signal (Time domaine signals).
*[35] "travityAccMag.mean"  : Average of average gravity acceleration magnitude signal (Time domaine signals).
*[36] "travityAccMag.std"   : Average of student-deviation of  gravity acceleration magnitude signal (Time domaine signals).
*[37] "tBodyAccJerkMag.mean" : Average of average body acceleration jerk magnitude signal (Time domaine signals).
*[38] "tBodyAccJerkMag.std"  : Average of student-deviation of body acceleration magnitude jerk signal (Time domaine signals).
*[39] "tBodyGyroMag.mean"    : Average of average gravity acceleration magnitude signal (Time domaine signals).
*[40] "tBodyGyroMag.std"     : Average of student-deviation of  gravity acceleration magnitude signal (Time domaine signals).
*[41] "tBodyGyroJerkMag.mean" : Average of average gravity acceleration magnitude  jerk signal (Time domaine signals).
*[42] "tBodyGyroJerkMag.std"  : Average of student-deviation of  gravity acceleration magnitude  jerk signal (Time domaine signals).


[43] "fBodyAcc.mean.X" : Average of average body acceleration signal for x axis (frequency domain signals).
[44] "fBodyAcc.mean.Y" : Average of average body acceleration signal for y axis (frequency domain signals).
[45] "fBodyAcc.mean.Z" : Average of average body acceleration signal for z axis (frequency domain signals).
[46] "fBodyAcc.std.X"  : Average of student-deviation of  body acceleration signal for x axis (frequency domain signals).
[47] "fBodyAcc.std.Y"  : Average of student-deviation of  body acceleration signal for y axis (frequency domain signals).     
[48] "fBodyAcc.std.Z"  : Average of student-deviation of  body acceleration signal for z axis (frequency domain signals).

[49] "fBodyAccJerk.mean.X" : Average of average body acceleration jerk signal for x axis (frequency domain signals). 
[50] "fBodyAccJerk.mean.Y" : Average of average body acceleration jerk signal for y axis (frequency domain signals).
[51] "fBodyAccJerk.mean.Z" : Average of average body acceleration jerk signal for z axis (frequency domain signals).
[52] "fBodyAccJerk.std.X"  : Average of student-deviation of body acceleration jerk signal for x axis (frequency domain signals). 
[53] "fBodyAccJerk.std.Y"  : Average of student-deviation of body acceleration jerk signal for y axis (frequency domain signals). 
[54] "fBodyAccJerk.std.Z"  : Average of student-deviation of body acceleration jerk signal for z axis (frequency domain signals). 
[55] "fBodyGyro.mean.X"    : Average of average body angular velocity signal for x axis (frequency domain signals).
[56] "fBodyGyro.mean.Y"    : Average of average body angular velocity signal for y axis (frequency domain signals).
[57] "fBodyGyro.mean.Z"    : Average of average body angular velocity signal for z axis (frequency domain signals).
[58] "fBodyGyro.std.X"     : Average of student-deviation of body angular velocity signal for x axis (frequency domain signals).
[59] "fBodyGyro.std.Y"     : Average of student-deviation of body angular velocity signal for y axis (frequency domain signals)..
[60] "fBodyGyro.std.Z"     : Average of student-deviation of body angular velocity signal for z axis (frequency domain signals)..
[61] "fBodyAccMag.mean"     : Average of average body acceleration magnitude signal (frequency domain signals).
[62] "fBodyAccMag.std"      : Average of student-deviation of body acceleration magnitude signal (frequency domain signals).
[63] "fBodyAccJerkMag.mean" : Average of average body acceleration jerk magnitude signal (frequency domain signals).
[64] "fBodyAccJerkMag.std"  : Average of student-deviation of body acceleration magnitude jerk signal (frequency domain signals).
[65] "fBodyGyroMag.mean"    : Average of average gravity acceleration magnitude signal (frequency domain signals).
[66] "fBodyGyroMag.std"     : Average of student-deviation of  gravity acceleration magnitude signal (frequency domain signals).
[67] "tBodyGyroJerkMag.mean" : Average of average gravity acceleration magnitude  jerk signal (frequency domain signals)..
[68] "tBodyGyroJerkMag.std"  : Average of student-deviation of  gravity acceleration magnitude  jerk signal (frequency domain signals).

