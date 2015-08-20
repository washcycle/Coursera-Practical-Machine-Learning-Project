## Explore the training set data

library(data.table)
library(dplyr)

training_raw <- fread("training.csv", sep = ",", header = T)

## assign data that summarizes each event window
training <- training_raw

# convert classe to factor variable
training$classe <- as.factor(training$classe)
#training$classe <- as.numeric(training$classe)

bad_cols = grep('#', training)

## Replace #DIV/0 with NA
training[, bad_cols] <- sapply(training[, bad_cols, with = F], as.numeric)

## Remove variables that contain NA values, most have 400 plus variables
good_cols <- colSums(is.na(training)) == 0
training <- training[, good_cols, with = F]

## Remove non-measurement variables
training <- training[, !grep('timestamp|V1|user|window', names(training), value = T), with = F]
