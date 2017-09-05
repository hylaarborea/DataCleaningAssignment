This script (run_analysis.R) prepare a tidy data set that can be used for later analysis. 
The data set represents data collected from the accelerometers from the Samsung Galaxy S smart-phone.

A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The data for the project is download from here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The downloaded folder contain two data sets: "training" and "test". They will be merged.

The script does the following steps:

- download and unzip the data set
- read the activityLabel, i.e. a list of levels and corresponding labels which will be used to give
  descriptive activity names to name the activities in the data set
- read features and make proper names; these will be used to appropriately label the data set with descriptive variable names
- tidy the "test" set (dataTest)
- tidy the "training" set (dataTrain)
- merge the two data set (dataTotal)
- extracts only the measurements on the mean and standard deviation for each measurement
- using dplyr data are before grouped and then summarised (new dataset "dataSummary" with average of each variable for each activity and each subject)
- the final data set is saved on the disk as "table.txt"


Each data set is made tidy in the following way:

- the "activity", corresponding for each row of the data set,  is read and transformed in factor
- the "subject" of the observation, corresponding for each row of the data set,  is read and transformed in factor
- the data set is modified giving a descriptive variable names (features)
- the "subject" column is added
- the "activity" column is added
