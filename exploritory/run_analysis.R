library(plyr)
library(reshape2)

# Primary function used to create a summary of the Human Acticity Recognition Using
# Smartphones (HARUS) Data Set. 
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones  
#
# This function does the following:
# 1) Merges the training and the test sets to create one data set.
# 2) Extracts only measurements on the mean and standard deviation. 
# 3) Applies descriptive activity names to the activities in the data set e.g. "WALKING"
# 4) Applies descriptive variable names to the selected feature set 
# 5) Creates a summary tidy data set with the average of each variable for 
#     each activity and each subject.
harus.run.analysis <- function(){
  
  # Build a data frame containing all the test data along with subject and 
  # activity columns
  x <- read.table("UCI HAR Dataset/test/X_test.txt")
  y <- read.table("UCI HAR Dataset/test/Y_test.txt")
  s <- read.table("UCI HAR Dataset/test/subject_test.txt")
  test.df <- cbind(s, y, x)
  
  # Build a data frame containing all the training data along with subject and 
  # activity columns
  x <- read.table("UCI HAR Dataset/train/X_train.txt")
  y <- read.table("UCI HAR Dataset/train/Y_train.txt")
  s <- read.table("UCI HAR Dataset/train/subject_train.txt")
  train.df <- cbind(s, y, x)
    
  # Append the test data set to the training data set 
  raw.df <- rbind(test.df, train.df)
  
  # Build vestor of meaningful variable names using descriptions from file
  column.names <- read.table("UCI HAR Dataset/features.txt")
  column.names <- c("subject", "activityCode", as.character(column.names[,2]))
  
  # Apply meaingful names to data frame
  colnames(raw.df) <- column.names
  
  # Only extract subject, activity, mean and standard deviation, omitting 
  # "meanFreq".  
  mean.std.df <- raw.df[, grepl("subject|activity|mean\\(\\)|std\\(\\)", 
                                  names(raw.df))]
  
  # Tidy the names of the features provided from the sample data set
  column.names <- names(mean.std.df)
  colnames(mean.std.df) <- harus.prettify(column.names)
  
  # Create Summary of the averages of all features/variables collected
  summary.df <- aggregate(mean.std.df, by=list(mean.std.df$subject, 
                                  mean.std.df$activity), FUN=mean, na.rm=TRUE)
  
  # Remove innocuous columns created by grouping and re-label 
  fixed.column.names <- c("subject", "activityCode")
  summary.df <- summary.df[,!(names(summary.df) %in% fixed.column.names)]
  colnames(summary.df) <- c(fixed.column.names, 
                         names(summary.df)[3:length(names(summary.df))])
  
  # Identify measures in columns that will be "melted" to rows
  measures <- names(summary.df)
  measures <- measures[3:length(measures)]
  melted.df <- melt(summary.df, id.vars=fixed.column.names, measures, 
    value.name = "average")
    
  # Replace the activity code with a descriptive value from file of descriptions
  activity.lookup <- read.table("UCI HAR Dataset/activity_labels.txt", 
                               col.names = c("activityCode", "activity"))
  final.df <- join(melted.df, activity.lookup, by = "activityCode")
  
  # Return columns of data frame in sensible order
  final.df <- final.df[,c(1,5,3,4)]
  colnames(final.df) <- c("subject", "activity", "signal", "average") 
  final.df
}

# Helper function that tidies the column names of variables
harus.prettify <- function(column.names){
  pretty.names <- c()
  
  for(column.name in column.names){  
    column.name <- harus.remove.underscore(column.name)
    column.name <- gsub('^t','time', column.name)
    column.name <- gsub('^f','frequency', column.name)
    column.name <- gsub('\\(', '', column.name)
    column.name <- gsub('\\)', '', column.name)
    column.name <- gsub('BodyBody', 'Body', column.name)
    pretty.names <- c(pretty.names, column.name)
  }
  pretty.names
}

# Helper function that removes underscores from a string and capitalises the
# following letter.
harus.remove.underscore <- function(column.name){
  find.underscore <- gregexpr("-", column.name)
  result <- find.underscore[[1]]

  if(result[1] != -1){
    position <- result[1]
    column.name <- paste( substr(column.name, 1, position-1),
                         toupper(substr(column.name,position+1,position+1)),
                         substr(column.name,position+2,nchar(column.name)),
                         sep="") 
  } else {
    return(column.name)
  }
  # Recursive call if there is more than one underscore remaining
  harus.remove.underscore(column.name)
}