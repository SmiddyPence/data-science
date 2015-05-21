# Code Book

## Presentation Wide Vs Narrow

After analysis the data is presented in a narrow format with a single measurement observed per row.  Initially the data comprised a wide data set with multiple measurements per row.  Making the data set narrow should facilitate easier use of the data in the future.

### Example Tidy Data
The run_analysis.R script produces a data frame with 11880 observations in the following format.

|subject|activity|signal|average|
|---|---|---|---|
|1|WALKING|timeBodyAccMeanX|0.277330759
|30|LAYING|frequencyBodyGyroJerkMagStd|-0.9754815|
 
### Data Dictionary

|Name|Description|Format|Examples|
|---|---|---|---|
|Subject|Unique identifier for the person whom the data was collected about|Number|1:30|
|Activity|Physical activity being under taken by the subject|String|WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING|
|Signal|Technial code that represents the measure that was performed by the subject.|String|timeBodyAccMeanX, frequencyBodyGyroJerkMagStd|
|Average|The mean value of all the collect data for a subject and measure|Number|A real number| 

The *signal* name can be used to derive the unit of measure, `time` or `frequency`.  The instrument `Acc` (accelerometer) or `Gyro` (Gyroscope), the measure itself `mean` or `std` (Standard Deviation) 

### Remarks on Abbreviations
Abbreviation are limited to the range of values for signal data.  I consider this acceptable as they do not comprise column headers i.e. describe the data.  Readers of this data will have sufficient domain knowledge to determine that `acc` is `accelerometer`, `mag` is `magnitude` and `std` is `standard deviation` etc.  Changing all of these to verbatim will not improve the data in my opinion.
That said `t` and `f` from the original data set have been expanded to read `time` and `frequency` as a single letter is probably too short.
 
 
 
