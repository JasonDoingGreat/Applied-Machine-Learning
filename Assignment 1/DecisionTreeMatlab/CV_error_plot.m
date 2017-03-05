function Y = CV_error_plot(X,Y)
    rng('default')
    leafs = logspace(0,2,100);
    N = numel(leafs);
    err = zeros(N,1);
    for n=1:N
        t = fitctree(X,Y,'CrossVal','On',...
            'MinLeafSize',leafs(n));
        err(n) = kfoldLoss(t);
    end
    figure();
    plot(leafs,err);
    xlabel('Min Leaf Size');
    ylabel('cross-validated error');
    [M,I] = min(err(:));
    Y = leafs(I);
end