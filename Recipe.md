Recipe.md
=========

This file describes the steps to produce the tidy data summary from the UCI HAR dataset using 
my `run_analysis.R` script and process.

Brad Banko, 11/24/2014


## Unpack the [raw data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) 

into the directory with the `run_analysis.R` script.

```
$ unzip getdata_projectfiles_UCI HAR Dataset.zip  # on a Linux system
```

This will create the `UCI HAR Dataset` directory in the directory containing `run_analysis.R`.


### Subsetting for *mean* and *std* feature variables

Subsetting the feature list to those feature variables (see `CodeBook.md`) with *mean* or *std* in
their names was a tripping point for me. My procedure relies on the user having already *created a 
feature variable **mean/std** variable list* from the original dataset `features.txt` file.

On a Linux system, this can be accomplished from the command line with the following command in the 
root directory of the `UCI HAR Dataset` directory:

```
$ grep -i 'mean\|std' features.txt > mean_std_features.lst
```

`mean_std_features.lst` then contains a list of features with the words *mean* or *std* in their names
case insensitive.  (86 altogether)


## Start R:

```
$ R
```

## Source the script:

```
source("run_analysis.R")
```

The resulting tidy data set **dataframe is `tidyData`**, and the .csv file is written to the starting
directory as **`tidyData.csv`**.


**Voila!**


```
> source("run_analysis.R")
Loading required package: reshape2
> head(tidyData,5)[,1:4]
  subjID            actName angle(tBodyAccJerkMean),gravityMean)
1      1             LAYING                           -0.6002032
2      1            SITTING                           -0.4959319
3      1           STANDING                           -0.5249514
4      1            WALKING                           -0.1472572
5      1 WALKING_DOWNSTAIRS                           -0.1732090
  angle(tBodyAccMean,gravity)
1                 -0.57830751
2                 -0.48557351
3                 -0.53438299
4                 -0.20080644
5                 -0.09135407
> q()
Save workspace image? [y/n/c]: y

[brad@hp5800 getting_cleaning]$ head -5 tidyData.csv | cut -c -80
"subjID","actName","angle(tBodyAccJerkMean),gravityMean)","angle(tBodyAccMean,gr
1,"LAYING",-0.600203190117647,-0.5783075055,-0.565315611666667,-0.59963147765686
1,"SITTING",-0.49593191246,-0.485573508183333,-0.492928515479167,-0.493991032083
1,"STANDING",-0.524951401111111,-0.534382990675926,-0.545359422175926,-0.4974518
1,"WALKING",-0.14725721806875,-0.200806438327957,-0.158598637678495,-0.187864152

```


