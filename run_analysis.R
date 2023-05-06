X_train <- read.table("./X_train.txt")               ## reads the training set
y_train <- read.table("./y_train.txt")               ## reads the training labels
subject_train <- read.table("./subject_train.txt")   ## reads the subject who performed the activity [1-30]


X_test <- read.table("./X_test.txt")              ## reads the test set
y_test <- read.table("./y_test.txt")              ## reads the test labels    
subject_test <- read.table("./subject_test.txt")  


features <- read.table("./features.txt")   ## reads the list of all features
mergedSets <- rbind(X_train, X_test) 
mergedSets$labels <- rbind(y_train, y_test) 
mergedSets$subjects <- rbind(subject_train, subject_test) 
colnames(mergedSets) <- features$V2   ## gives cols the names


df2 <- mergedSets[,grepl("mean()|std()", names(mergedSets))]
df2 <- cbind(subjects = rbind(subject_train, subject_test), labels = rbind(y_train, y_test), df2)
colnames(df2)[1]<-"subject"
colnames(df2)[2]<-"activity"
activity_names <- read.table("./activity_labels.txt")   ## reads the class labels with their activity name


library(qdapTools)
df2[,2] <- lookup(df2[,2], activity_names, key.reassign = NULL,
       missing = NA)   ## looks up for activities according to given num

## print(str(df2))

## library("writexl")      
## write_xlsx(df2,"./tidy-data.xlsx")    ## writes the new data into xlsx format
write.table(df2,"./tidy-data.txt", row.name=FALSE) ## writes the new data into txt format

