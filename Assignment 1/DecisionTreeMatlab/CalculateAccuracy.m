function Y = CalculateAccuracy(real_result,TestResultSet)
    N = size(TestResultSet,2);
    Y = zeros(N,1);
    for i = 1:N
        for j = 1:size(real_result,1)
            cur_result = TestResultSet(:,i);
            if real_result(j) == cur_result(j)
                Y(i) = Y(i) + 1.0;
            end
        end
    end
    Y = Y(:);
end