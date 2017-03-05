function Y = PruneLevelErrorPlot(Tree)
    rng('default')
    level = 1:100;
    N = numel(level);
    err = zeros(N,1);
    for n=1:N
        t = prune(Tree,'Level',level(n));
        err(n) = resubLoss(t);
    end
    figure();
    plot(level,err);
    xlabel('Level of Tree');
    ylabel('cross-validated error');
    [M,I] = min(err(:));
    Y = level(I);
end