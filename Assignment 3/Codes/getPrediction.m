function y=getPrediction(summaries, testSet)
    predictions = [];
	for i = 1:length(testSet)
		result = predict(summaries, testSet(i,:));
		predictions = [predictions;result(1,:)];
	y = [predictions;result(2,:)];
end