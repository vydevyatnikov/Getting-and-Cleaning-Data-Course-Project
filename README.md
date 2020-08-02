# Getting-and-Cleaning-Data-Course-Project

This repositiry contains the results of analysis of "Human Activity Recognition Using Smartphones Dataset", which was provided by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio and Luca Oneto from Smartlab - Non Linear Complex Systems Laboratory. 
1) "Data_on_means_and_stds" contains only means and standard deviations for each measurement from "Completedata.csv" plus Activity labels and Identifiers of the subjects:
 - 79 means and standard deviations for time and frequency domain variables.
 - Its activity label. 
 - An identifier of the subject who carried out the experiment.
It also possesses more convenient variable names and labels than in the original dataset. 
2) "New_dataset.csv" contains data on means of 79 means and standard deviations from "Data_on_means_and_stds.csv" for each subject and type of activity. Rows represent identifiers of subjects and types of activity, while columns represent variables for which means were calculated. 
 - 79 means on means and standard deviations for time and frequency domain variables.
3) "run_analysis.R" contains a full script that was used to retrieve, clean and process data. The script is accompanied by explanatory comments. 
4) "Codebook.txt" contains description on variables. 
