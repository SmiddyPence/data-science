library(AppliedPredictiveModeling)
library(caret);

#1
data(segmentationOriginal)

test <- subset(segmentationOriginal, Case == "Test");
train <- subset(segmentationOriginal, Case == "Train");
set.seed(125);

model <- train(Class ~ ., method = 'rpart', train);
print(model$finalModel)
plot (model$finalModel, uniform = TRUE)
text(model$finalModel, use.n = TRUE, all = TRUE, cex=.8)

#3
library(pgmm)
data(olive)
olive = olive[,-1]
model <- train(Area ~ ., method = 'rpart', olive)
newdata = as.data.frame(t(colMeans(olive)))
newpred <- predict(model,newdata)

#4
library(ElemStatLearn)
data(SAheart)
set.seed(8484)
train = sample(1:dim(SAheart)[1],size=dim(SAheart)[1]/2,replace=F)
trainSA = SAheart[train,]
testSA = SAheart[-train,]
set.seed(13234)
model <- train(chd ~ age+alcohol+obesity+tobacco+typea+ldl, method = 'glm', 
               family="binomial", trainSA)
prediction <- predict(model,testSA)
missClass = function(values,prediction){sum(((prediction > 0.5)*1) != values)/length(values)}
missClass(trainSA$chd, predict(model, trainSA))
missClass(testSA$chd, predict(model, testSA))

#5
library(ElemStatLearn)
data(vowel.train)
data(vowel.test)
vowel.train$y <- as.factor(vowel.train$y)
vowel.test$y <- as.factor(vowel.test$y)
set.seed(33833)
#model <- train(y ~ ., method='rf',vowel.train)
model <- randomForest(y ~ ., vowel.train)
varImp(model)

