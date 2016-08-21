# Getting and cleaning data - Course project - Read me

This is the week 4 course project for the Coursera "Getting and cleaning data" course, which is part of the "Data Science" specialisation.

We were required to write an R script called 'run_analysis.R' (which you will find in this repo), to get and clean (hence the name of the course) data from an internet source. The original data set consists in several text files grouped in a zip file. The data is divided in two main file groups that contain distinct values of the same variables :
* Training data
* Test data

Along with descriptive data such as :
* Variable names
* Activity labels


## The 'run_analysis.R' script does the following :
* Check if the zip file exists in the working directory and, if not, download it
* Check if the zip file has been properly unzipped and, if not, unzip it
* Load trainig data, which consist in three files :
	* Training data - which countains the measurements
	* Training subjects - which describes which subject produced the measurements
	* Training labels - which describes what activity was performed by the subject, these labels are coded
* Load test data, which consist in three files :
	* Test data
	* Test subjects
	* Test labels
* Merge each pair of files into a single data frame
* Extract only measurements for mean and standard deviation by :
	* Loading variable names
	* Getting indexes for variables we are interested in
	* Subsetting the merged data frame 
	* Naming each column
* Replace coded labels values by descriptive values by
	* Loading the correlation table
	* Replacing values
* Create a tidy data set by merging labels, subjects and data and export it as 'clean_data.txt'
* Create a second tidy data set with the average for each activity and each subject and export it as 'clean_average.txt'
