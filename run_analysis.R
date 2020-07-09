library(dplyr)

##0. To make the merging more efficient and easier
rt_instructions<- list(
        file = list(
        activity_labels = "UCI HAR Dataset/activity_labels.txt",
        y_train = "UCI HAR Dataset/train/y_train.txt",
        X_train = "UCI HAR Dataset/train/X_train.txt",
        features = "UCI HAR Dataset/features.txt",
        subject_train = "UCI HAR Dataset/train/subject_train.txt",
        subject_test = "UCI HAR Dataset/test/subject_test.txt",
        y_test = "UCI HAR Dataset/test/y_test.txt",
        X_test = "UCI HAR Dataset/test/X_test.txt"
        ), 
        
        colClasses = list(
        activity_labels = c("integer", "character"),
        y_train = "integer",
        X_train = rep("numeric", 561),
        features = c("integer", "character"),
        subject_train = "integer",
        subject_test = "integer",
        y_test = "integer",
        X_test = rep("numeric", 561)
        ),
        
        nrows = list(
        activity_labels = 6,
        y_train = 7352,
        X_train = 7352,
        features = 561,
        subject_train = 7352,
        subject_test = 2947,
        y_test = 2947,
        X_test = 2947
        )
)

data <- with(rt_instructions,
                   Map(read.table,
                       file = file, colClasses = colClasses, nrows = nrows,
                       quote = "", comment.char = "",
                       stringsAsFactors = FALSE))

##1. Merges the training and the test sets to create one data set.
merged_data <- with(data,
                    rbind(cbind(subject_train, y_train, X_train),
                          cbind(subject_test,  y_test,  X_test)))
summary(merged_data)
head(merged_data, 2)

##2. Extracts only the measurements on the mean and standard deviation for each measurement.
target_features_indexes <- grep("mean\\(\\)|std\\(\\)",
                                data_files$features[[2]])

target_variables_indexes <- c(1, 2, # the first two columns that refer to
                              # 'subject' and 'activity'
                              # should be included
                              # adds 2 to correct the indexes
                              # of target features indexes because of
                              # the 2 extra columns we have included
                              target_features_indexes + 2)

target_data <- merged_data[ , target_variables_indexes]

##3. Uses descriptive activity names to name the activities in the data set
target_data[[2]] <- factor(target_data[[2]],
                           levels = data_files$activity_labels[[1]],
                           labels = data_files$activity_labels[[2]])

##4. Appropriately labels the data set with descriptive variable names.

descriptive_variable_names <- data_files$features[[2]][target_features_indexes]

descriptive_variable_names <- gsub(pattern = "BodyBody", replacement = "Body",
                                   descriptive_variable_names)
tidy_data <- target_data
names(tidy_data) <- c("subject", "activity", descriptive_variable_names)

##5. From the data set in step 4, creates a second, independent tidy data
##      set with the average of each variable for each activity and each subject.

tidy_data_sum <- tidy_data %>%      ### necesitas dplyr para %>%
        group_by(subject, activity) %>%
        summarise_all(funs(mean)) %>%
        ungroup()

newnames_for_sum <- c(names(tidy_data_sum[c(1,2)]),
                           paste0("Avrg-", names(tidy_data_sum[-c(1, 2)])))
names(tidy_data_sum) <- newnames_for_sum

write.table(tidy_data_sum, "Courseproject_GCD.txt", row.names = FALSE)


