library(ElemStatLearn);
library(caret);
library(AppliedPredictiveModeling)
library(e1071)
library(forecast)

# Q1
data(vowel.train);
data(vowel.test);
vowel.train$y <- as.factor(vowel.train$y);
vowel.test$y <- as.factor(vowel.test$y);
set.seed(33833);
rfModel <- train(y ~ ., method='rf', vowel.train)
gbmModel <- train(y ~ ., method='gbm', vowel.train);
pred1 <- predict(rfModel, vowel.test);
pred2 <- predict(gbmModel, vowel.test);
#predDf <- data.frame(pred1,pred2,y=vowel.test$y);
rfAcc<-sum(pred1==vowel.test$y)/length(vowel.test$y);
gbmAcc<-sum(pred2==vowel.test$y)/length(vowel.test$y);
match <-c(pred1==pred2)
trues <- sum(match);
agreement <- trues/length(match);

#Q3
set.seed(3523)
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]
set.seed(233)
lModel <- train(CompressiveStrength ~ ., method='lasso', concrete)
plot.enet(lModel$finalModel, xvar="penalty", use.color=TRUE)

#Q5
set.seed(3523)
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]
set.seed(235)
svmModel <- svm(CompressiveStrength ~ ., data = training)
svmPred <- predict(svmModel, testing);
accuracy(svmPred, testing$CompressiveStrength)
