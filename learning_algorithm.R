library(caret)
library(randomForest)
library(doMC)
registerDoMC(cores = 5) # use 5 cores as this seems to be the optimal number

## Create data partition
inTrain = createDataPartition(y = training$classe, p = 0.6)[[1]]

## Create data partition of training data into training and test set
test_ <- training[-inTrain,]
training_ <- training[inTrain,]

## Define cross validation
fitControl <- trainControl(## 10-fold CV
    method = "repeatedcv",
    number = 10,
    ## repeated ten times
    repeats = 10)

## Train model
modelFit <- train(classe ~ ., data = training_, 
                  trControl = fitControl, 
                  preProcess = c("center", "scale"), 
                  model = "gbm")

## Confusion Matrix
predictions <- predict(modelFit, newdata= test_)
confuse <- confusionMatrix(predictions, test_$classe)

# Calculate out-of-sample error
mean(modelFit$resample$Accuracy)

## Test on validation data
validation_raw <- fread("validation.csv", sep = ",", header = T)

## assign data that summarizes each event window
validation <- validation_raw[, names(training_[,-53]), with = F]
predictions <- predict(modelFit, newdata= validation)