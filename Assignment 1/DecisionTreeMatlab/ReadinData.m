function Y = ReadinData(Filename)
    data = csvimport(Filename);
    Y = [];
    N = size(data,2);
    %--- Seperate training data into vectors ---%
    if N == 8
        Y = [Y,cell2mat(data(2:end,1))];
        Y = [Y,cell2mat(data(2:end,2))];
        Y = [Y,change2num(data(2:end,3),{'male','female'})];
        Y = [Y,cell2mat_preprocess(data(2:end,4))];
        Y = [Y,cell2mat(data(2:end,5))];
        Y = [Y,cell2mat(data(2:end,6))];
        Y = [Y,cell2mat(data(2:end,7))];
        Y = [Y,change2num(data(2:end,8),{'S','C','Q'})];
    end
    if N == 7
        Y = [Y,cell2mat(data(2:end,1))];
        Y = [Y,change2num(data(2:end,2),{'male','female'})];
        Y = [Y,cell2mat_preprocess(data(2:end,3))];
        Y = [Y,cell2mat(data(2:end,4))];
        Y = [Y,cell2mat(data(2:end,5))];
        Y = [Y,cell2mat_preprocess(data(2:end,6))];
        Y = [Y,change2num(data(2:end,7),{'S','C','Q'})];
    end
    if N == 2
        Y = cell2mat(data(2:end,2));
    end
    
end