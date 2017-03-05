function y = calculateProbability(x, mean, variance)
    exponent = exp(-(x-mean)^2/(2*variance));
    y = 1 / (sqrt(2*pi) * sqrt(variance)) * exponent;
end