library(dplyr)

## Joining data
# Downloading data
data <- read.table("X_test.txt")
data1 <- read.table("X_train.txt")
data2 <- read.table("y_test.txt")
data3 <- read.table("y_train.txt")
data4 <- read.table("subject_test.txt")
data5 <- read.table("subject_train.txt")

#Since column names are the same, we can use simple functions like rbind() and cbind() to merge data sets

testdata <- cbind(data,data2,data4) #merging test data: data on features, type of activity and subjects
traindata <- cbind(data1, data3, data5) # merging train data: data on features, type of activity and subjects
totaldata <- rbind(testdata, traindata) #joining test and train data
write.csv(totaldata, file = "Complete_data.csv")

## Extracting only variables with mean and std in their names

names <- read.table("features.txt")
names <- names[,2] #Deleting first column that was mere sequence of row numbers
names(totaldata)[1:561] <- names #Setting names of features as names of columns
mean_and_std_data <- totaldata[,grepl("mean|std", names(totaldata))] #Subsetting data on the basis of presence the words "mean" or "std"
mean_and_std_data <- cbind(mean_and_std_data, totaldata[562:563]) #Adding columns with info about type of activity and identifier of subject

##Renaming variables and labels
#Correcting the typo

oldnames <- names(mean_and_std_data)
typo <- oldnames[grep("BodyBody", oldnames)] #Subsetting names on the basis of presence typo "BodyBody" 
typo <- sub("BodyBody", "Body", typo) #Replacing typo with single "Body
oldnames[71:79] <- typo #Replacing names with typos

# Creating new names
newnames <- c() #Just initializing vector
for (i in oldnames) {
        if (grepl("Acc", i)) { #Subsetting names on the basis of presence "Acc"
                i <- sub("Acc", "Accelerometer", i) #Replacing "Acc" with "Accelerometer"
                if (grepl("Mag", i)) { #Subsetting names on the basis of presence "Mag"
                        i <- sub("Mag", "Magnitude", i) #Replacing "Mag" with "Magnitude"
                        if (grepl("Freq", i)) { #Subsetting names on the basis of presence "Freq"
                                i <- sub("Freq", "Frequency", i) #Replacing "Freq" with "Frequency"
                        }
                }
                newnames <- c(newnames, i) #Uniting vectors
                newnames <- sub("\\()","", newnames) #Deleting parentheses
        } else {
                i <- sub ("Gyro", "Gyroscope", i)  #Replacing "Gyro" with "Gyroscope"
                if (grepl("Mag", i)) { #See above
                        i <- sub("Mag", "Magnitude", i) #See above
                        if (grepl("Freq", i)) { #See above
                                i <- sub("Freq", "Frequency", i) #See above
                        }
                }
                newnames <- c(newnames, i) #See above
                newnames <- sub("\\()","", newnames) #See above
        }
}
newnames[80:81] <- c("Type of Activity", "ID of subject") #Adding names for type of activity and subject identifier columns
names(mean_and_std_data) <- newnames #Replacing old names with new ones
mean_and_std_data[,80] <- factor(mean_and_std_data[,80], levels = c("1", "2", "3", "4", "5", "6"), 
                                 labels = c("Walking", "Walking_Upstairs", "Walking_Downstairs", "Sitting", "Standing", "Laying")) #Setting
#new labels for types of activity
write.csv(mean_and_std_data, file = "Data_on_means_and_stds.csv")

## Creating new data set

new_data_set <- data.frame() #Just initializing a data frame
z <- 0 #Setting counter for number of loops
for (i in unique(mean_and_std_data[,80])) { #For each type of activity ...
        z <- z + 1 #...counter + 1 ...
        x <- filter(mean_and_std_data, `Type of Activity` == i) #...subset data ...
        x <- colMeans(x[1:79]) #...calculate means ...
        if (z == 1) { #...and if it is the first iteration of loop...
                new_data_set <- rbind(new_data_set, as.data.frame(x)) #...add data stored in x as new rows.
        } else { #But if it's not ...
                new_data_set <- cbind(new_data_set, as.data.frame(x)) #...than add data stored in x as new columns. That a little bit
                #confusing "ifelse" condition was added because cbind don't let join data frames if one of them possess no variables
        }
}
new_data_set <- as.data.frame(t(as.matrix(new_data_set))) #Transposing data frame, so features will be columns
row.names(new_data_set) <- unique(mean_and_std_data[,80]) #Naming rows that represents types of activity
for (i in unique(mean_and_std_data[,81])) { #For each subject ...
        x <- filter(mean_and_std_data, `ID of subject` == i) #...subset data...
        x <- colMeans(x[1:79]) #...calculate means ...
        new_data_set <- rbind(new_data_set, as.data.frame(t(x))) #...and attach them to data frame.
}
row.names(new_data_set)[7:36] <- paste("Subject", as.character(unique(mean_and_std_data[,81]))) #New names for rows representing subjects

## Creating new names for variables in new dataset 
# That wasn't obligatory, as far as I understood it, but the fact that columns names in different data frames with different data 
# will be the same forced me to correct them a little bit (though someone could say they are too long already).

x <- c()
for (i in names(new_data_set)) {
        names_for_new_dataset <- paste("Mean of `", i, sep = "")
        names_for_new_dataset <- paste(names_for_new_dataset, "`", sep = "")
        x <- c(x, names_for_new_dataset)
}
names(new_data_set) <- x

write.csv(new_data_set, file = "New_dataset.csv")
write.table(new_data_set, file = "justnewdataset.txt", row.names = FALSE)

