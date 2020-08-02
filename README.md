# Getting-and-Cleaning-Data-Course-Project

This repositiry contains the results of analysis of "Human Activity Recognition Using Smartphones Dataset", which was provided by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio and Luca Oneto from Smartlab - Non Linear Complex Systems Laboratory. 
1) "Complete_data.csv" contains a full set of original data, which consists of:
 - 561-feature vector with time and frequency domain variables (in names "f" stands for frequency and "t" for time - for details see "Codebook.txt")
 - Its activity label. 
 - An identifier of the subject who carried out the experiment.
2) "Data_on_means_and_stds" contains only means and standard deviations for each measurement from "Completedata.csv" plus Activity labels and Identifiers of the subjects:
 - 79 means and standard deviations for time and frequency domain variables.
 - Its activity label. 
 - An identifier of the subject who carried out the experiment.
It also possesses more convenient variable names and labels than in the original dataset. 
3) "New_dataset.csv" contains data on means of 79 means and standard deviations from "Data_on_means_and_stds.csv" for each subject and type of activity. Rows represent identifiers of subjects and types of activity, while columns represent variables for which means were calculated. 
 - 79 means on means and standard deviations for time and frequency domain variables.
 4) "run_analysis.R" contains a full script that was used to retrieve, clean and process data. The script is accompanied by explanatory comments. 
 5) "Codebook.txt" contains description on variables. 
