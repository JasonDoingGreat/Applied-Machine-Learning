function y = predict(summaries, inputVector)
	probabilities = calculateClassProb(summaries, inputVector);
	bestLabel = 0; 
    bestProb = -1;
	for i = 1:9
        if bestLabel == 0 || probabilities(i) > bestProb
			bestProb = probabilities(i);
			bestLabel = i;
        end
	end
    y = [bestLabel;bestProb];
end