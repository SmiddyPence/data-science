# Human Activity Recognition Using Smartphones Data Set Analysis

This repository contains a script that conducts arbitrary tidying and manipulation of data collected from Samsung Galaxy SII devices.  A [full description] of the data set is available from the UCI Machine Learning Repository.

The data includes a unique identifier for the subject i.e. person, the activity they we’re performing at the time laying, walking etc.  All compiled alongside a plethora of signal readings obtained by the devices accelerometer and gyroscope.  For a more detailed explanation of the data please consult the [Code Book]


## Study Design

### Processing performed:

- Creates a single data frame of all test data, collating the subject, activity performed and signal data.
- Creates a single data frame of all training data, collating the subject, activity performed and signal data.
- Merges the test and training data frames into a single data set
- Extracts the signal measurements that relate only to mean and standard deviation
- Replace the numeric code that represents the activity with the descriptive name e.g. Walking, Laying, Sitting etc.
- Labels the measurement signals with appropriate names, applying the following tidying to original labels:
    - Removes characters: `(` & `)`
    - Removes character: `-` and capitalizes following letter
    - Replace character: `t` with non-abbreviated long name `time`
    - Replace character: `f` with non-abbreviated long name `frequency`
    - Replace duplicate word: `BodyBody` with `Body` 
- Calculates the average of each measurement for each activity and subject
- Transforms or `melts` the original wide data set, where measurements are held in columns to a narrow row based data set. 


## Code Book

A separate markdown file can be found here [Code Book].  It describes the data in more detail as well as conscious decisions made about the manipulation of the data. 

### Instruction List

#### Dependencies
This script uses functions provided in both the `plyr` and `reshape2` packages.  If you do not have these packages on your machine already you will need to use the `install.packages` command.

```R
install.packages("plyr")
install.packages("reshape2")
```

1. Download the script
	- git clone https://github.com/SmiddyPence/harus.git
	- or raw file: https://raw.githubusercontent.com/SmiddyPence/harus/master/run_analysis.R
2. Download the [data set]
3. Place or arrange so that `run_analysis.R` script is in the root of your current working directory
4. Extract the data set so that it is in your current working directory

	```
	\working
		\UCI HAR Dataset
			\test
				subject_test.txt
				X_test.txt
				y_test.txt
			\train
				subject_train.txt
				X_train.txt
				y_train.txt
			activity_labels.txt
			features.txt
		run_analysis.R
	```
> The above omitts files that are part of the original data set and not required for this analysis.

5. Load the script `source('./run_analysis.R')`
6. Execute the following command `tidy.data <- harus.run.analysis()` in the R console
7. The `tidy.data` variable contains the tidy data set 
8. If you would like to write the data to disk you can use `write.table(tidy.data, file="tidyData.csv", row.name=FALSE, sep = ",")`

## Notes 
- In order to tidy the dataset this script performs a number of expensive transformations as such it may take several seconds to complete


[full description]:http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
[code book]:https://github.com/SmiddyPence/harus/blob/master/CODEBOOK.md
[data set]:https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

