function y = calculateClassProb(summaries, inputVector)
    probabilities = containers.Map('KeyType', 'int32', 'ValueType','any');
    probabilities = initializeMap(probabilities);
    for i = 1:9
        probabilities(i) = 1;
        temp = summaries(i);
        for j = 1:size(summaries(i),2)
            mean = temp(1,j);
            variance = temp(2,j);
            x = inputVector(j);
            probabilities(i) = probabilities(i) * calculateProbability(x,mean,variance);
        end
    end
    y = probabilities;
end