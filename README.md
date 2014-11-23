README.md
=========

This directory/repository contains the `run_analysis.R` script to process and merge the
UCI Human Activity Recognition (UCI HAR) dataset for the Getting and Cleaning
Course Project.

# The Important Files in this Repository

1. `README.MD`  # this file which describes the files in the repostiory

2. `run_analysis.R`  # the R script which does the processing

3. `CodeBook.md`  # the file that describes the variables in the tidy dataset

4. `Recipe.md`  # the explicit instructions for producing the tidy dataset


  Brad Banko, 11/23/2014
  Getting and Cleaning Data Course
  Johns Hopkins School of Public Health


This is a [Markdown](https://help.github.com/articles/markdown-basics/) file which allows
for readable documentation that can also be formatted and cast in `html` directly.
Here is a [sample](http://daringfireball.net/projects/markdown/).


The four things I have:

* The **raw data** is the UCI feature activity testing and training datasets 
with activity labels and subject IDs:

  [raw data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

  * Unpack this data in the directory where the run_analysis.R script is.

* A **tidy data set** (`tidyData.csv`) is a summary of the raw dataset subsetting 86 of the 
561-feature vector time and frequency domain variables
which have either "mean" or "std" (for standard deviation) in their names. 
The **mean values** of the 86 feature variables over the subject ID and activity type labels
have been used for the **tidy data set**. 

* For the detailed description of the variables in the **tidy data set** are listed in
the `CodeBook.md`.

* For an explicit and exact recipe for transforming the raw dataset into the tidy dataset, see
`Recipe.md`



