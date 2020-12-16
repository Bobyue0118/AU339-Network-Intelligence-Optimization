function [successDetected]=check_targets(stateGene,distances)
    sensorConnected=zeros(100,1);
    for j = 1:100                                       % 每个传感器
        if stateGene(j)~=0
            [~, n] = sort(distances(j,:));                  % 排序，m为值，n为值对应的索引（传感器）
            for i=1:stateGene(j)
                if distances(j,n(i))<=50
                   sensorConnected(n(i))=sensorConnected(n(i))+1;
                end
            end           
        end
    end
    successDetected=(sensorConnected>=3);
end