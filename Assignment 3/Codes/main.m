clear,
clc,

%% Load the dataset from the file
x = xlsread('Data.xls');
label = xlsread('label.xls');

%% Separate dataset to training and test sets.
train_x = x(1:1680,:);
train_label = label(1:1680,:);

test_x = x(1681:end,:);
test_label = label(1681:end,:);

max_label = max(train_label);
min_label = min(train_label);

%% Separate data by class
n = length(train_x);
data_map = containers.Map('KeyType', 'int32', 'ValueType','any');
data_map = initializeMap(data_map);
for i = 1:n
    k = train_label(i);
    data_map(k) = [data_map(k);train_x(i,:)];
end

%% Calculate mean and standard variance for each attribute in one class
data_summarize = containers.Map('KeyType', 'int32', 'ValueType','any');
data_summarize = initializeMap(data_summarize);
for i = min_label:max_label
    one_class = data_map(i);
    data_summarize(i) = [mean(one_class);var(one_class)];
end


%% Calculate the probabilities and make Predictions of test data
predictions = getPrediction(data_summarize, test_x);

%% Check accuracy of the predictions

correct = 0.0;
for i = 1:length(test_x)
	if test_label(i) == predictions(i)
        correct = correct + 1.0;
    end
end
correct/length(test_x)
