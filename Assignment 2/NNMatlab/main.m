clc;
clear;
TrainDataFile = 'Iris.csv';
TestDataFile = 'test.csv';
Data = csvimport(TrainDataFile);
Data = Data(2:end,:);
Data2 = csvimport(TestDataFile);
Data2 = Data2(2:end,:);
TrainData = cell2mat(Data(:,2:end-1));
ClassData = Data(:,end);
TestData = cell2mat(Data2(:,2:end-1));
ResultData = Data2(:,end);

for i = 1:size(ClassData,1)
    if strcmp(ClassData{i},'Iris-setosa')
        ClassData{i} = 1;
    else if strcmp(ClassData{i},'Iris-versicolor')
            ClassData{i} = 2;
        else
            ClassData{i} = 3;
        end
    end
end

for i = 1:size(ResultData,1)
    if strcmp(ResultData{i},'Iris-setosa')
        ResultData{i} = 1;
    else if strcmp(ResultData{i},'Iris-versicolor')
            ResultData{i} = 2;
        else
            ResultData{i} = 3;
        end
    end
end

ClassData = cell2mat(ClassData);

ResultData = cell2mat(ResultData);

[input,minI,maxI] = premnmx(TrainData');

s = length(ClassData);
output = zeros(s, 3);

for i = 1:s 
   output(i, ClassData(i)) = 1;
end

net = newff(minmax(input),[10 3], {'logsig' 'purelin'},'traingdx');

net.trainparam.show = 50;
net.trainparam.epochs = 100;
net.trainparam.goal = 0.01;
net.trainParam.lr = 0.01;

net = train(net,input,output');

testInput = tramnmx(TestData',minI,maxI);

Y = sim(net,testInput);

[s1,s2] = size(Y);
hitNum = 0;
for i = 1:s2
    [m,Index] = max(Y(:,i));
    if(Index == ResultData(i)) 
        hitNum = hitNum + 1; 
    end
end

sprintf('Accuracy is %3.3f%%',100 * hitNum / s2 )
