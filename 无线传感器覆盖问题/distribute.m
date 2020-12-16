function [sensorPoints] = distribute(targetPoints)
    % targetPoints 100*2 
    [idx, centers] = kmeans(targetPoints,33);
    
    count = hist(idx,unique(idx));
    [channel, classes] = size(count);
    sensorPoints = [];
    sensorCount = 0;
    targetCount = 0;
    for i=1:classes
        if count(i) == 3
            sensorPoints = [sensorPoints; repmat(centers(i,:),3,1)];
            sensorCount = sensorCount + 3;
        end
        if count(i) >3
            repNum = count(i)-1;
            repCon = centers(i,:);
            sensorPoints = [sensorPoints; repmat(repCon,repNum,1)];
            sensorCount = sensorCount + count(i)-1;
        end   
    end
    
    if isempty(find(count == 2,1)) > 0 
        for i = find(count == 2)
            if sensorCount <= 97
                sensorPoints = [sensorPoints; repmat(centers(i,:),3,1)];
                sensorCount = sensorCount + 3;
            end
        end
    end
    index1 = find(count == 1);
    length1 = length(index1);
    if length1 > 0 
        numIndex = 0;
        while sensorCount <100
            sensorPoints = [sensorPoints; centers(index1(mod(numIndex,length(index1))+1),:)];
            sensorCount = sensorCount +1;
            numIndex = numIndex + 1;
        end
    end
end
    