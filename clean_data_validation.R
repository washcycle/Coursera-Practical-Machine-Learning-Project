library(data.table)

validation_raw <- fread("validation.csv", sep = ",", header = T)

## assign data that summarizes each event window
validation <- validation_raw

bad_cols = grep('#', validation)

## Replace #DIV/0 with NA
validation[, bad_cols] <- sapply(validation[, bad_cols, with = F], as.numeric)

## Remove variables that contain NA values, most have 400 plus variables
good_cols <- colSums(is.na(validation)) == 0
validation <- validation[, good_cols, with = F]

## Remove non-measurement variables
validation <- validation[, !grep('timestamp|V1|user|window', names(validation), value = T), with = F]