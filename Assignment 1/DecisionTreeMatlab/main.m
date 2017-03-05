%-------------------------------------------------------%
%-------------------------------------------------------%
%------------ Decision Tree Implementation -------------%
%----------- Created by Zezhou Li on 9/27/16 -----------%
%--- Copyright © 2016 Zezhou Li. All rights reserved ---%
%-------------------------------------------------------%
%-------------------------------------------------------%

clc;
clear;

%--- Change to our directory ---%
cd('/Users/zezhouli/Documents/2016-2017 Fall Semester/CPE695-Machine Learning/Assignments/Assignment 1/DecisionTreeMatlab');

%--- Read in training and test data ---%
TrainingFileName = 'train.csv';
TestFileName = 'test.csv';
ResultFileName = 'result.csv';
TrainingData = ReadinData(TrainingFileName);
TestData = ReadinData(TestFileName);
ResultData = ReadinData(ResultFileName);

%--- Set non-numeric value to numeric value ---%
disp('Age: Male = 1, Female = 0');
disp('Embarked: S = 1, C = 2, Q = 3');

%--- Use fitctree function to train the decision tree ---%
%--- View the tree structure ---%
%--- Calculate resubstitution error ---%
DTTree = fitctree(TrainingData(:,2:end),TrainingData(:,1));
view(DTTree,'Mode','graph');
resuberror = resubLoss(DTTree);
disp(['resubstitution error before pruning is:',num2str(resuberror)]);

%--- Prune the decision tree and get an optimal decision tree ---%
%--- View the tree structure ---%
%--- Calculate resubstitution error ---%
DTTreePrune = prune(DTTree,'Level',10);
view(DTTreePrune,'Mode','graph');
resuberror_prune = resubLoss(DTTreePrune);
disp(['resubstitution error after pruning is:',num2str(resuberror_prune)]);

%--- Plot the error when increasing Leaf Size ---%
% min_err = CV_error_plot(TrainingData(:,2:end),TrainingData(:,1));

%--- Plot the error when increasing prune level ---%
% % min_level = PruneLevelErrorPlot(DTTree);
% % DTTreeMinLevelErr = prune(DTTree,'Level',min_level);
% % view(DTTreeMinLevelErr,'Mode','graph');
% % resuberror_min_level = resubLoss(DTTreeMinLevelErr);
% % disp(['resubstitution error with min level pruning is:',num2str(resuberror_min_level)]);

%--- Use the leaf size which has minimum cross-validated error ---%
%--- View the tree structure ---%
%--- Calculate resubstitution error ---%
% % DTTreeMinLeafSize = fitctree(TrainingData(:,2:end),TrainingData(:,1),'MinLeafSize',min_err);
% % view(DTTreeMinLeafSize,'Mode','graph');
% % resuberror_minleafsize = resubLoss(DTTreeMinLeafSize);
% % disp(['resubstitution error with min leaf size is:',...
% %     num2str(resuberror_minleafsize)]);

%--- Implement the trained Decision tree to test the data ---%
% DTTreeSet = {DTTree; DTTreePrune; DTTreeMinLeafSize};
DTTreeSet = {DTTree; DTTreePrune};
TestResultSet = makePrediction(DTTreeSet, TestData);

%--- Calculate accuracy for each estimated result ---%
CountSet = CalculateAccuracy(ResultData, TestResultSet);

%--- Display the accuracy ---%
N = size(ResultData,1);
for i=1:size(CountSet,1)
    disp(CountSet(i)/N);
end