function Y = change2num(X,attr)
    t = size(attr,2);
    if t==2
        for i=1:size(X,1)
            if strcmp(X{i},attr{1})
                X{i} = 1; % male = 1
            else if strcmp(X{i},attr{2})
                    X{i} = 0; % female = 0
                else
                    X{i} = NaN;
                end
            end
        end
    else
        for i=1:size(X,1)
            if strcmp(X{i},attr{1})
                X{i} = 1; % S = 1
            else if strcmp(X{i},attr{2})
                    X{i} = 2; % C = 2
                else if strcmp(X{i},attr{3})
                        X{i} = 3; % Q = 3
                    else
                        X{i} = NaN;
                    end
                end
            end
        end
    end
    Y = cell2mat(X);
    
end