# ----------------------------------------------------------------------------------------------------------------------------------
# Assessment : Getting and Cleaning Data Course Projec
# Source of data: 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# ----------------------------------------------------------------------------------------------------------------------------------

# 1. Merges the training and the test sets to create one data set.

tmp_train <- read.table("train/X_train.txt")
tmp_test <- read.table("test/X_test.txt")
X <- rbind(tmp_train, tmp_test)

tmp_train <- read.table("train/subject_train.txt")
tmp_test <- read.table("test/subject_test.txt")
S <- rbind(tmp_train, tmp_test)

tmp_train <- read.table("train/y_train.txt")
tmp_test <- read.table("test/y_test.txt")
Y <- rbind(tmp_train, tmp_test)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

# Read the features table that is content in features.txt
features <- read.table("features.txt")
# Extract the indices of the measurements
ind_mes <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
X <- X[, ind_mes]
names(X) <- features[ind_mes, 2]
names(X) <- gsub("\\(|\\)", "", names(X))
names(X) <- tolower(names(X))

# 3. Uses descriptive activity names to name the activities in the data set.

# Read the features table that is content in activity_labels.txt
act <- read.table("activity_labels.txt")
# Extract the names of activities 
act[, 2] = gsub("_", "", tolower(as.character(act[, 2])))
Y[,1] = act[Y[,1], 2]
names(Y) <- "activity"

# 4. Appropriately labels the data set with descriptive activity names.

names(S) <- "subject"
cld <- cbind(S, Y, X)
write.table(cld, "mcd.txt", row.names = FALSE) # Merged clean data file

# 5. Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject.

unqS = unique(S)[,1] # Unique subjects
numS = length(unique(S)[,1]) # Number of subjects
numA = length(act[,1]) # Number of activities
numC = dim(cld)[2] # Number of Columns
r = cld[1:(numS*numA), ] # Result

row = 1
for (s in 1:numS) {
  for (a in 1:numA) {
    r[row, 1] = unqS[s]
    r[row, 2] = act[a, 2]
    tmp <- cld[cld$subject==s & cld$activity==act[a, 2], ]
    r[row, 3:numC] <- colMeans(tmp[, 3:numC])
    row = row+1
  }
}
write.table(r, "dataset_averages.txt", row.names = FALSE)