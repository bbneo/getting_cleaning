
CodeBook.md
===========
 
This file describes the variables in the Getting and Cleaning Data Course Project resulting `tidyData.csv` dataset.  This is a result of a merge, subset and mean value summary of the
UCI Human Activity Recognition (UCI HAR) smartphone dataset:

* [raw data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

Brad Banko, 11/23/2014


# Overview

From the `feature_info.txt` overview file of that set:

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

```
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
```

The set of variables that were estimated from these signals are: 

```
mean(): Mean value
std(): Standard deviation
```

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

```
gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean
```


# Detailed list of feature variables in `tidyData.csv`


This is a detailed list of the variables in the tidyData. This list was 
generated with: `write.table(names(tidyData), quote=F, sep=" ")`


```
1 subjID
  * a subject identifier ranges from 1-30

2 actName
  * the activity of a feature set, one of:
    * LAYING SITTING STANDING WALKING WALKING_DOWNSTAIRS WALKING_UPSTAIRS
```


Feature variables 3-88 below are **mean values** of those features described above 
over on the order of 40-80 measurements for each subset of subjID and actName:

```
> table(mergedData$subjID,mergedData$actName)
    
     LAYING SITTING STANDING WALKING WALKING_DOWNSTAIRS WALKING_UPSTAIRS
  1      50      47       53      95                 49               53
  2      48      46       54      59                 47               48
  3      62      52       61      58                 49               59
  4      54      50       56      60                 45               52
  5      52      44       56      56                 47               47
  6      57      55       57      57                 48               51
  7      52      48       53      57                 47               51
  8      54      46       54      48                 38               41
  9      50      50       45      52                 42               49
  10     58      54       44      53                 38               47
  11     57      53       47      59                 46               54
  12     60      51       61      50                 46               52
  13     62      49       57      57                 47               55
  14     51      54       60      59                 45               54
  15     72      59       53      54                 42               48
  16     70      69       78      51                 47               51
  17     71      64       78      61                 46               48
  18     65      57       73      56                 55               58
  19     83      73       73      52                 39               40
  20     68      66       73      51                 45               51
  21     90      85       89      52                 45               47
  22     72      62       63      46                 36               42
  23     72      68       68      59                 54               51
  24     72      68       69      58                 55               59
  25     73      65       74      74                 58               65
  26     76      78       74      59                 50               55
  27     74      70       80      57                 44               51
  28     80      72       79      54                 46               51
  29     69      60       65      53                 48               49
  30     70      62       59      65                 62               65
```


Mean Value Feature Variables
============================
```
3 angle(tBodyAccJerkMean),gravityMean)
4 angle(tBodyAccMean,gravity)
5 angle(tBodyGyroJerkMean,gravityMean)
6 angle(tBodyGyroMean,gravityMean)
7 angle(X,gravityMean)
8 angle(Y,gravityMean)
9 angle(Z,gravityMean)
10 fBodyAcc-mean()-X
11 fBodyAcc-mean()-Y
12 fBodyAcc-mean()-Z
13 fBodyAcc-meanFreq()-X
14 fBodyAcc-meanFreq()-Y
15 fBodyAcc-meanFreq()-Z
16 fBodyAcc-std()-X
17 fBodyAcc-std()-Y
18 fBodyAcc-std()-Z
19 fBodyAccJerk-mean()-X
20 fBodyAccJerk-mean()-Y
21 fBodyAccJerk-mean()-Z
22 fBodyAccJerk-meanFreq()-X
23 fBodyAccJerk-meanFreq()-Y
24 fBodyAccJerk-meanFreq()-Z
25 fBodyAccJerk-std()-X
26 fBodyAccJerk-std()-Y
27 fBodyAccJerk-std()-Z
28 fBodyAccMag-mean()
29 fBodyAccMag-meanFreq()
30 fBodyAccMag-std()
31 fBodyBodyAccJerkMag-mean()
32 fBodyBodyAccJerkMag-meanFreq()
33 fBodyBodyAccJerkMag-std()
34 fBodyBodyGyroJerkMag-mean()
35 fBodyBodyGyroJerkMag-meanFreq()
36 fBodyBodyGyroJerkMag-std()
37 fBodyBodyGyroMag-mean()
38 fBodyBodyGyroMag-meanFreq()
39 fBodyBodyGyroMag-std()
40 fBodyGyro-mean()-X
41 fBodyGyro-mean()-Y
42 fBodyGyro-mean()-Z
43 fBodyGyro-meanFreq()-X
44 fBodyGyro-meanFreq()-Y
45 fBodyGyro-meanFreq()-Z
46 fBodyGyro-std()-X
47 fBodyGyro-std()-Y
48 fBodyGyro-std()-Z
49 tBodyAcc-mean()-X
50 tBodyAcc-mean()-Y
51 tBodyAcc-mean()-Z
52 tBodyAcc-std()-X
53 tBodyAcc-std()-Y
54 tBodyAcc-std()-Z
55 tBodyAccJerk-mean()-X
56 tBodyAccJerk-mean()-Y
57 tBodyAccJerk-mean()-Z
58 tBodyAccJerk-std()-X
59 tBodyAccJerk-std()-Y
60 tBodyAccJerk-std()-Z
61 tBodyAccJerkMag-mean()
62 tBodyAccJerkMag-std()
63 tBodyAccMag-mean()
64 tBodyAccMag-std()
65 tBodyGyro-mean()-X
66 tBodyGyro-mean()-Y
67 tBodyGyro-mean()-Z
68 tBodyGyro-std()-X
69 tBodyGyro-std()-Y
70 tBodyGyro-std()-Z
71 tBodyGyroJerk-mean()-X
72 tBodyGyroJerk-mean()-Y
73 tBodyGyroJerk-mean()-Z
74 tBodyGyroJerk-std()-X
75 tBodyGyroJerk-std()-Y
76 tBodyGyroJerk-std()-Z
77 tBodyGyroJerkMag-mean()
78 tBodyGyroJerkMag-std()
79 tBodyGyroMag-mean()
80 tBodyGyroMag-std()
81 tGravityAcc-mean()-X
82 tGravityAcc-mean()-Y
83 tGravityAcc-mean()-Z
84 tGravityAcc-std()-X
85 tGravityAcc-std()-Y
86 tGravityAcc-std()-Z
87 tGravityAccMag-mean()
88 tGravityAccMag-std()
```

