function Y = cell2mat_preprocess(X)
    ix = cellfun(@isempty,X);
    X(ix)={'nan'};
    Y = cellfun(@str2num,X);
end