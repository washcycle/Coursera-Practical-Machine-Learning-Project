
# Weight lifting data sets

# Training Data Set URL
# https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv

# Test Data Set URL
# https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv

trainingDataURL = "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv";
validationDataURL = "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv";

download.file(trainingDataURL, destfile = "training.csv", method = 'curl')
download.file(validationDataURL, destfile = "validation.csv", method = 'curl')

