function Y = makePrediction(DTTreeSet, TestSet)
    Y = [];
    N = size(DTTreeSet,1);
    for i = 1:N
        Y = [Y,predict(DTTreeSet{i}, TestSet)];
    end
end